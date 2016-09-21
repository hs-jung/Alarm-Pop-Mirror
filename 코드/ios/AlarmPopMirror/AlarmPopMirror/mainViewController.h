//
//  mainViewController.h
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 20..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "editScheduleViewController.h"

@interface mainViewController : UIViewController<UITextViewDelegate,UITableViewDelegate, UITableViewDataSource>
{
    NSTimer *timer;
    IBOutlet UILabel *timeField;
    IBOutlet UILabel *dateField;
    IBOutlet UITextView *memoField;
    IBOutlet UILabel *weatherField;
    UITextView *textView;
    UITableView *tableView;
    UIDatePicker *datePicker;
    UIDatePicker *timePicker;
}

@property (weak, nonatomic) IBOutlet UIImageView *logoField;    //로고 표시 image view
@property (nonatomic, retain) UITextView *textView;
@property (copy, nonatomic) NSMutableArray *scheduleSubject;
@property (copy, nonatomic) NSMutableArray *schedule_id;
@property (copy, nonatomic) NSMutableArray *scheduleYmdt;
@property (copy, nonatomic) NSMutableArray *fullYmdt;
@property (nonatomic, retain) UITableView *tableView;

- (IBAction)settingTouch:(id)sender;    //setting 버튼 클릭했을 때
- (IBAction) functionPressed:(id)sender; //기능 버튼 클릭했을 때
- (void) onTimer; // 타이머 이벤트
- (IBAction)memoPressed;  //메모 수정

extern NSString *uuid;
extern NSString *userMemo;

extern NSInteger weatherArraySize;
extern NSMutableArray *codeArray;
extern NSMutableArray *locationArray;
extern NSMutableArray *skyNameArray;
extern NSMutableArray *skyCodeArray;
extern NSMutableArray *tcArray;
extern NSMutableArray *tminArray;
extern NSMutableArray *tmaxArray;
extern NSMutableArray *subtextArray;
@end
