//
//  addScheduleViewController.m
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 9. 12..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import "addScheduleViewController.h"

@interface addScheduleViewController ()

@end

@implementation addScheduleViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.png"]];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIToolbar *toolBar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 375, 40)];
    [toolBar1 setTintColor:[UIColor lightGrayColor]];
    UIToolbar *toolBar2 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 375, 40)];
    [toolBar2 setTintColor:[UIColor lightGrayColor]];
    UIToolbar *toolBar3 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 375, 40)];
    [toolBar3 setTintColor:[UIColor lightGrayColor]];
    
    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButton1Pressed)];
    UIBarButtonItem *doneButton2 = [[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButton2Pressed)];
    UIBarButtonItem *doneButton3 = [[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButton3Pressed)];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [toolBar1 setItems:[NSArray arrayWithObjects: space, doneButton1,nil]];
    [toolBar2 setItems:[NSArray arrayWithObjects: space, doneButton2,nil]];
    [toolBar3 setItems:[NSArray arrayWithObjects: space, doneButton3,nil]];
    
    _dateSettingField.placeholder = @"date";
    _timeSettingField.placeholder = @"time";
    _subjectSettingField.placeholder = @"subject";
    
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    timePicker = [[UIDatePicker alloc] init];
    timePicker.datePickerMode = UIDatePickerModeTime;
    
    [self.dateSettingField setInputView:datePicker];
    [self.dateSettingField setInputAccessoryView:toolBar1];
    
    [self.timeSettingField setInputView:timePicker];
    [self.timeSettingField setInputAccessoryView:toolBar2];
    
    [self.subjectSettingField setInputAccessoryView:toolBar3];
    
    self.subjectSettingField.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) doneButton1Pressed {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    _dateSettingField.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate: datePicker.date]];
    [_dateSettingField resignFirstResponder];
}


 -(void) doneButton2Pressed{
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     [formatter setDateFormat:@"HH:mm"];
     _timeSettingField.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate: timePicker.date]];
     [_timeSettingField resignFirstResponder];
 }

 -(void) doneButton3Pressed{
 [_subjectSettingField resignFirstResponder];
 }

//일정 저장
- (IBAction) addSchedule{
    NSInteger success = 0;
    NSString *ymdt = [NSString stringWithFormat:@"%@ %@:00",_dateSettingField.text,_timeSettingField.text];
    NSLog(@"%@",ymdt);
    
    @try {
        
            NSString *post =[[NSString alloc] initWithFormat:@"id=%@&ymdt=%@&subject=%@",uuid,ymdt,_subjectSettingField.text];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://cslab2.kku.ac.kr/~200917307/addsche.php"];
            
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
                    [self switchView];
                    NSLog(@"Login SUCCESS");
                } else {
                    
                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
                    [self alertStatus:error_msg :@"Add Failed!" :0];
                }
                
            } else {
                if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Add Failed!" :0];
            }
        }
    
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Add Failed." :@"Error!" :0];
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
    UIViewController * mainViewController = [storyboard  instantiateViewControllerWithIdentifier:@"mainViewController"] ;
    mainViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:mainViewController animated:YES completion:nil];
}

//키보드 return
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}
@end
