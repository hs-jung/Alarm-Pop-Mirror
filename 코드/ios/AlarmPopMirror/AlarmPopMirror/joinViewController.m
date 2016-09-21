//
//  joinViewController.m
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 22..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import "joinViewController.h"
#import "loginViewController.h"

@interface joinViewController ()

@end

@implementation joinViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.png"]];
    
    [super viewDidLoad];
    
    _checked = 0;
    
    [userPhoto setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"addImage" ofType:@"png"]]];
    
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//ID 중복 체크
- (IBAction)idCheckButton:(id)sender {
    NSInteger success = 0;
    @try {
        
        if([[self.IDField text] isEqualToString:@""]) {
            
            [self alertStatus:@"Please enter ID" :@"check Failed!" :0];
            
        } else {
            NSString *post =[[NSString alloc] initWithFormat:@"id=%@",[self.IDField text]];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://cslab2.kku.ac.kr/~200917307/idcheck.php"];
            
            NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"Response code: %ld", (long)[response statusCode]);
            
            if ([response statusCode] >= 200 && [response statusCode] < 300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                NSError *error = nil;
                NSDictionary *jsonData = [NSJSONSerialization
                                          JSONObjectWithData:urlData
                                          options:NSJSONReadingMutableContainers
                                          error:&error];
                
                success = [jsonData[@"Success"] integerValue];
                NSLog(@"Success: %ld",(long)success);
                
                if(success == 1)
                {
                    [self alertStatus:@"checked" :@"사용 가능한 ID입니다." :0];
                    //NSLog(@"사용 가능한 ID 입니다.");
                } else if(success==2){
                    
                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
                    [self alertStatus:error_msg :@"동일한 아이디가 있습니다." :0];
                } else{
                    //기타 예외
                }
                
            } else {
                if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"check Failed!" :0];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"check Failed." :@"Error!" :0];
    }
    if (success==1) {
        _checked = 1;
    }

}

//회원 가입
- (IBAction)joinButton:(id)sender {
    NSInteger success = 0;
    @try {
        
        if(_checked == 0){
            [self alertStatus:@"ID 중복 확인을 해주세요." :@"join Failed!" :0];
        }else{
        
            if([[self.IDField text] isEqualToString:@""] || [[self.nickNameField text] isEqualToString:@""] || [[self.PWField text] isEqualToString:@""] || [[self.PW2Field text] isEqualToString:@""])
            {
                
                [self alertStatus:@"Please enter whole blank" :@"join Failed!" :0];
            
            } else {
                if([self.PWField text] == [self.PW2Field text]){
                    NSString *post =[[NSString alloc] initWithFormat:@"id=%@&nickname=%@&pw=%@",[self.IDField text],[self.nickNameField text],[self.PWField text]];
                    NSLog(@"PostData: %@",post);
                    
                    NSURL *url=[NSURL URLWithString:@"http://cslab2.kku.ac.kr/~200917307/joinus.php"];
                    
                    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                    
                    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
                    
                    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                    [request setURL:url];
                    [request setHTTPMethod:@"POST"];
                    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
                    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
                    [request setHTTPBody:postData];
                    
                    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
                    
                    NSError *error = [[NSError alloc] init];
                    NSHTTPURLResponse *response = nil;
                    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                    
                    NSLog(@"Response code: %ld", (long)[response statusCode]);
                    
                    if ([response statusCode] >= 200 && [response statusCode] < 300)
                    {
                        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                        NSLog(@"Response ==> %@", responseData);
                        
                        NSError *error = nil;
                        NSDictionary *jsonData = [NSJSONSerialization
                                                  JSONObjectWithData:urlData
                                                  options:NSJSONReadingMutableContainers
                                                  error:&error];
                        
                        success = [jsonData[@"Success"] integerValue];
                        NSLog(@"Success: %ld",(long)success);
                        
                        if(success == 1){
                            [self alertStatus:@"회원 가입을 축하드립니다." :@"WELECOME!" :0];
                            NSLog(@"Join SUCCESS");
                            [self switchView];
                        } else if(success == 2) {
                            NSString *error_msg = (NSString *) jsonData[@"error_message"];
                            [self alertStatus:error_msg :@"Join Failed!" :0];
                        }else{
                            //기타 예외
                        }
                        
                    } else {
                        if (error) NSLog(@"Error: %@", error);
                        [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
                    }
                }else{
                    [self alertStatus:@"비밀번호를 확인해 주세요." :@"join Failed!" :0];
                }
                
                            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Join Failed." :@"Error!" :0];
    }
}

- (IBAction)cancleButton:(id)sender {
}

//빈곳 tap하면 키보드 숨김
- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

//사진 촬영
- (IBAction)takePhoto {
    picker =[[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}

//사진 가져오기
-(IBAction)choosePhoto{
    picker2 =[[UIImagePickerController alloc] init];
    picker2.delegate = self;
    picker2.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker2 animated:YES completion:NULL];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *selectedPhoto = [info objectForKey:UIImagePickerControllerOriginalImage];
    [userPhoto setImage:selectedPhoto];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//키보드 return
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//알람창
- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}

-(void)switchView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * loginViewController = [storyboard   instantiateViewControllerWithIdentifier:@"loginViewController"] ;
    loginViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:loginViewController animated:YES completion:nil];
}




@end
