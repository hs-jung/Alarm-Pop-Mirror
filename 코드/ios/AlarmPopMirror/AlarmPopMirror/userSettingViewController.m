//
//  userSettingViewController.m
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 23..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import "userSettingViewController.h"
#import "mainViewController.h"

@interface userSettingViewController (){
    NSInteger imageCount;
    NSInteger buttonID;
    
    BOOL buttonImagechanged;
    
    UIImage *userImage1;
    UIImage *userImage2;
    UIImage *userImage3;
    
    NSData *imageData1;
    NSData *imageData2;
    NSData *imageData3;
}

@end

@implementation userSettingViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.png"]];
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [super viewDidLoad];

    _userID.text=[NSString stringWithFormat:@"%@",uuid];
    
    //image 가져오기
    [self bringInfo];
    
    buttonID = 0;
    
    buttonImagechanged = false;

    imageData1 = [[NSData alloc] init];
    imageData2 = [[NSData alloc] init];
    imageData3 = [[NSData alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutClicked:(id)sender {
    NSLog(@"%@ LOGED OUT", uuid);
    uuid = nil;
    [self alertStatus:nil :@"LOG OUT" :0];
    [self switchView];
    
}

-(void)switchView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * loginViewController = [storyboard   instantiateViewControllerWithIdentifier:@"loginViewController"] ;
    loginViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:loginViewController animated:YES completion:nil];
}

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

-(void) bringInfo{
    
    
    //nickname
    
    //userImage1 = ;
    //userImage2 = ;
    //userImage3 = ;
    //[_addImageButton1 setImage:userImage1 forState:UIControlStateNormal];
    //[_addImageButton2 setImage:userImage2 forState:UIControlStateNormal];
    //[_addImageButton3 setImage:userImage3 forState:UIControlStateNormal];
    
}

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
    
    
    [view addAction:camera];
    [view addAction:gallery];
    [self presentViewController:view animated:YES completion:nil];
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

- (IBAction)backButtonClicked:(id)sender {
    if(buttonImagechanged){
        //이미지 업데이트
        
        NSInteger success = 0;
        @try {
            
            NSURL *url=[NSURL URLWithString:@"http://cslab2.kku.ac.kr/~200917307/test/imgtest1.php"];
                        
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
                        
            NSString *boundary = @"---------------------------0A0BLRJ34ZZ";
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
            [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
                        
            NSMutableData *body = [NSMutableData data];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id\"; \r\n\r\n%@",uuid] dataUsingEncoding:NSUTF8StringEncoding]];
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
                    //do nothing.
                } else if(success == 2) {
                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
                    [self alertStatus:error_msg :@"Join Failed!" :0];
                }else{
                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
                    [self alertStatus:error_msg :@"Join Failed!" :0];
                }
            }
        
        }
        @catch (NSException * e) {
            NSLog(@"Exception: %@", e);
            [self alertStatus:@"Join Failed." :@"Error!" :0];
        }

    }
}


-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *selectedPhoto = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if(buttonID == 1){
        imageData1 = UIImageJPEGRepresentation(selectedPhoto, 0.5);
        [_addImageButton1 setImage:selectedPhoto forState:UIControlStateNormal];
        buttonImagechanged = true;
    }else if(buttonID == 2){
        imageData2 = UIImageJPEGRepresentation(selectedPhoto, 0.5);
        [_addImageButton2 setImage:selectedPhoto forState:UIControlStateNormal];
        buttonImagechanged = true;
    }else if(buttonID == 3){
        imageData3 = UIImageJPEGRepresentation(selectedPhoto, 0.5);
        [_addImageButton3 setImage:selectedPhoto forState:UIControlStateNormal];
        buttonImagechanged = true;
    }else{
        //do nothing.
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
