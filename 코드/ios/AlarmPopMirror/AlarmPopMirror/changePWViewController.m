//
//  changePWViewController.m
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 26..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import "changePWViewController.h"
#import "loginViewController.h"

@interface changePWViewController ()

@end

@implementation changePWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


//키보드 return
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//빈곳 tap하면 키보드 숨김
- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)changeClicked:(id)sender {NSInteger success = 0;
    @try {
        if(_changedPWField.text == _changedPWField2.text)
        {
            if([[self.PWField text] isEqualToString:@""] || [[self.changedPWField text] isEqualToString:@""] || [[self.changedPWField2 text] isEqualToString:@""] ) {
                
                [self alertStatus:@"Please enter whole blank" :@"Change Password Failed!" :0];
                
            } else {
                NSString *post =[[NSString alloc] initWithFormat:@"pw=%@&new_pw=%@",[self.PWField text],[self.changedPWField text]];
                NSLog(@"PostData: %@",post);
                
                NSURL *url=[NSURL URLWithString:@"http://10.251.20.247/changepw.php"];
                
                NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
                
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
                        NSLog(@"Change Password SUCCESS");
                        [self switchView];
                    } else {
                        
                        NSString *error_msg = (NSString *) jsonData[@"error_message"];
                        [self alertStatus:error_msg :@"Change Password Failed!" :0];
                    }
                    
                } else {
                    if (error) NSLog(@"Error: %@", error);
                    [self alertStatus:@"Connection Failed" :@"Change Password Failed!" :0];
                }
            }
        }else{
            [self alertStatus:@"비밀번호가 일치하지 않습니다." :@"Change Password Failed!" :0];
        }

    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Change Password Failed." :@"Error!" :0];
    }
    if (success==1) {
        //[self performSegueWithIdentifier:@"login_success" sender:self];
    }
    
    
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

-(void)switchView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * loginViewController = [storyboard   instantiateViewControllerWithIdentifier:@"loginViewController"] ;
    [self presentViewController:loginViewController animated:YES completion:nil];
}

@end
