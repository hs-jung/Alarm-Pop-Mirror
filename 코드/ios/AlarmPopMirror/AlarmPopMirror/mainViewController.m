//
//  mainViewController.m
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 20..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import "mainViewController.h"

@interface mainViewController ()

@end

NSString *uuid = nil;

@implementation mainViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.png"]];
    
    NSLog(@"uuid : %@",uuid);
    [self onTimer];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    
    [dateField setFont:[UIFont fontWithName:@"Arial" size:40]];
    [timeField setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:45]];
    
    //로고 표시
    [_logoField setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"logo" ofType:@"png"]]];
    
    
    
    //일정 가져오기, 출력
    _scheduleFiled.text = @"test SCHEDULE text.";
    
    //memo 가져오기, 출력
    [self bringMemo];
    
    
    //날씨 가져오기, 출력
    _weatherField.text = @"test WEATHER test.";
    
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [super viewDidLoad];
   
    
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

- (IBAction)infoButton:(id)sender {
}

- (IBAction)settingTouch:(id)sender {
}

//타이머 이벤트
-(void) onTimer{
    int pmonth,pday,phour,pminute;
    
    NSCalendar *pCalendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDate *date= [NSDate date];
    NSDateComponents *comps = [pCalendar components:unitFlags fromDate:date];
    pmonth=(int)[comps month];
    pday=(int)[comps day];
    phour=(int)[comps hour];
    pminute=(int)[comps minute];
    //psecond=(int)[comps second];
    
    dateField.text=[NSString stringWithFormat:@"%02d\n/ %02d",pmonth,pday];
    timeField.text=[NSString stringWithFormat:@"%02d : %02d",phour,pminute];
}

-(void) bringMemo{
    NSString *userMemoContents;
    NSInteger umemo_id;
    
    @try {
            NSString *post =[[NSString alloc] initWithFormat:@"id=%@",uuid];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://cslab2.kku.ac.kr/~200917307/memo.php"];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
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
                
                umemo_id = [jsonData[@"umemo_id"] integerValue];
                NSLog(@"umemo_id: %ld",umemo_id);
                
                if(umemo_id > 0)
                {
                    userMemoContents = [jsonData objectForKey:@"content"];
                    [memoFeild setText:userMemoContents];
                } else {
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


@end
