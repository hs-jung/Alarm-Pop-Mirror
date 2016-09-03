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
    [_logoField setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"logo2" ofType:@"png"]]];
    
    
    
    //일정 가져오기, 출력
    _scheduleFiled.text = @"test SCHEDULE text.";
    
    //memo 가져오기, 출력
    _memoField.text = @"test MEMO text.";
    
    //날씨 가져오기, 출력
    _weatherField.text = @"test WEATHER test.";
    
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



@end
