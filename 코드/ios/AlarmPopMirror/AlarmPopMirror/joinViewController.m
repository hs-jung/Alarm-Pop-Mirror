//
//  joinViewController.m
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 22..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import "joinViewController.h"
#import "loginViewController.h"

@interface joinViewController (){
    NSInteger imageCount;
    NSInteger buttonID;
    
    BOOL button1ImageEmpty;
    BOOL button2ImageEmpty;
    BOOL button3ImageEmpty;
    
    NSData *imageData1;
    NSData *imageData2;
    NSData *imageData3;
}

@end

@implementation joinViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.png"]];
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [super viewDidLoad];
    
    _checked = 0;
    imageCount = 0;
    buttonID = 0;
    
    button1ImageEmpty = true;
    button2ImageEmpty = true;
    button3ImageEmpty = true;
    
    imageData1 = [[NSData alloc] init];
    imageData2 = [[NSData alloc] init];
    imageData3 = [[NSData alloc] init];
  
    UIImage *buttonDefaultImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"addImage" ofType:@"png"]];
    
    [_addImageButton1 setImage:buttonDefaultImage forState:UIControlStateNormal];
    [_addImageButton2 setImage:buttonDefaultImage forState:UIControlStateNormal];
    [_addImageButton3 setImage:buttonDefaultImage forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ID 중복 체크
- (IBAction)idCheckButton:(id)sender {
    NSInteger success = 0;
    @try {
        
        if([[self.IDField text] isEqualToString:@""]){
            
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
        
            if([[self.IDField text] isEqualToString:@""] || [[self.nickNameField text] isEqualToString:@""] || [[self.PWField text] isEqualToString:@""] || [[self.PW2Field text] isEqualToString:@""] || button1ImageEmpty || button2ImageEmpty || button3ImageEmpty)
            {
                
                [self alertStatus:@"빈칸을 채워주세요." :@"join Failed!" :0];
            
            } else {
                if([self.PWField text] == [self.PW2Field text]){
                    
                    NSURL *url=[NSURL URLWithString:@"http://cslab2.kku.ac.kr/~200917307/test/imgtest1.php"];
                   
                    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                    [request setURL:url];
                    [request setHTTPMethod:@"POST"];
                    
                    NSString *boundary = @"---------------------------0A0BLRJ34ZZ";
                    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
                    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
                    
                    NSMutableData *body = [NSMutableData data];
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id\"; \r\n\r\n%@",[self.IDField text]] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"nickname\"; \r\n\r\n%@",[self.nickNameField text]] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"pw\"; \r\n\r\n%@",[self.PWField text]] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    // Image 1 추가
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"img1\"; filename=\"img1.jpeg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[NSData dataWithData:imageData1]];
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    // Image 2 추가
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"img2\"; filename=\"img2.jpeg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[NSData dataWithData:imageData2]];
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    // Image 3 추가
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"img3\"; filename=\"img3.jpeg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"Content-Type: image/jpeg\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[NSData dataWithData:imageData3]];
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    [request setHTTPBody:body];
                    
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
                            NSString *error_msg = (NSString *) jsonData[@"error_message"];
                            [self alertStatus:error_msg :@"Join Failed!" :0];
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
- (void)takePhoto {
    UIImagePickerController *picker =[[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}

//사진 가져오기
-(void)choosePhoto{
    UIImagePickerController *picker =[[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *selectedPhoto = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if(buttonID == 1){
        imageData1 = UIImageJPEGRepresentation(selectedPhoto, 0.5);
        [_addImageButton1 setImage:selectedPhoto forState:UIControlStateNormal];
        button1ImageEmpty = false;
    }else if(buttonID == 2){
        imageData2 = UIImageJPEGRepresentation(selectedPhoto, 0.5);
        [_addImageButton2 setImage:selectedPhoto forState:UIControlStateNormal];
        button2ImageEmpty = false;
    }else if(buttonID == 3){
        imageData3 = UIImageJPEGRepresentation(selectedPhoto, 0.5);
        [_addImageButton3 setImage:selectedPhoto forState:UIControlStateNormal];
        button3ImageEmpty = false;
    }else{
        //do nothing.
    }
    
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

//카메라, 갤러리 선택 알림창
-(void) alertTwotype{
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"사진을 등록해주세요"
                                 message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* camera = [UIAlertAction
                         actionWithTitle:@"카메라"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [self takePhoto];
                             [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* gallery = [UIAlertAction
                             actionWithTitle:@"사진 라이브러리"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self choosePhoto];
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    UIAlertAction* cancle = [UIAlertAction
                             actionWithTitle:@"취소"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    [view addAction:camera];
    [view addAction:gallery];
    [view addAction:cancle];
    [self presentViewController:view animated:YES completion:nil];
}

-(void)switchView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * loginViewController = [storyboard   instantiateViewControllerWithIdentifier:@"loginViewController"] ;
    loginViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:loginViewController animated:YES completion:nil];
}

- (IBAction)addImageButton1:(id)sender {
    buttonID = 1;
    [self alertTwotype];
}

- (IBAction)addImageButton2:(id)sender {
    buttonID = 2;
    [self alertTwotype];
}

- (IBAction)addImageButton3:(id)sender {
    buttonID = 3;
    [self alertTwotype];
}


@end
