//
//  editScheduleViewController.m
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 9. 14..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import "editScheduleViewController.h"
#import "mainViewController.h"

@interface editScheduleViewController ()

@end

NSString *editDate = nil;
NSString *editTime = nil;
NSString *editSubject = nil;
NSString *editScheduleId = nil;

@implementation editScheduleViewController

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
    
    [toolBar1 setItems:[NSArray arrayWithObjects: space, doneButton1, nil]];
    [toolBar2 setItems:[NSArray arrayWithObjects: space, doneButton2, nil]];
    [toolBar3 setItems:[NSArray arrayWithObjects: space, doneButton3, nil]];
    
    _dateSettingField.placeholder = @"date";
    _timeSettingField.placeholder = @"time";
    _subjectSettingField.placeholder = @"subject";

    _dateSettingField.text = editDate;
    _timeSettingField.text = editTime;
    _subjectSettingField.text= editSubject;
    
    datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    //datePicker.date =
    timePicker = [[UIDatePicker alloc]init];
    timePicker.datePickerMode = UIDatePickerModeTime;
    
    [self.dateSettingField setInputView:datePicker];
    [self. dateSettingField setInputAccessoryView:toolBar1];
    [self.timeSettingField setInputView:timePicker];
    [self.timeSettingField setInputAccessoryView:toolBar2];
    [self.subjectSettingField setInputAccessoryView:toolBar3];
    
    self.subjectSettingField.delegate=self;
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

-(void)switchView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * mainViewController = [storyboard  instantiateViewControllerWithIdentifier:@"mainViewController"] ;
    mainViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:mainViewController animated:YES completion:nil];
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)backButtonClicked:(id)sender {
    //수정 취소
}

- (IBAction)saveButtonClicked:(id)sender {
    //일정 수정
    
    NSInteger success;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"HH:mm:00"];
    NSString *appendedymdt = [[NSString alloc] initWithFormat:@"%@ %@", [NSString stringWithFormat:@"%@", [formatter stringFromDate: datePicker.date]], [NSString stringWithFormat:@"%@", [formatter2 stringFromDate: timePicker.date]]];
    NSLog(@"%@",appendedymdt);
    @try {
        NSString *post =[[NSString alloc] initWithFormat: @"sid=%@&subject=%@&ymdt=%@",editScheduleId, _subjectSettingField.text, appendedymdt];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://cslab2.kku.ac.kr/~200917307/updatesche.php"];
        
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
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
            NSLog(@"success: %ld",(long)success);
            
            if(success == 1)
            {
                NSLog(@"일정 수정 완료");
                [self switchView];
                [self alertStatus:@"수정되었습니다." :@"Changed!" :0];
                
                
            }else{
                NSString *error_msg = (NSString *) jsonData[@"error_message"];
            }
            
        } else {
            if (error) NSLog(@"Error: %@", error);
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
}


- (IBAction)deleteButtonClicked:(id)sender {
    NSInteger success;
    
    @try {
        NSString *post =[[NSString alloc] initWithFormat:@"id=%@&sid=%@",uuid,editScheduleId];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://cslab2.kku.ac.kr/~200917307/delesche.php"];
        
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
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
            NSLog(@"success: %ld",(long)success);
            
            if(success == 1)
            {
                [self switchView];
                [self alertStatus:@"삭제되었습니다." :@"Deleted!" :0];
                
            }else{
                NSString *error_msg = (NSString *) jsonData[@"error_message"];
            }
            
        } else {
            if (error) NSLog(@"Error: %@", error);
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
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



//키보드 return
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
    
@end
