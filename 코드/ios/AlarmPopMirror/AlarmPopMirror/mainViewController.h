//
//  mainViewController.h
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 20..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mainViewController : UIViewController
{
    NSTimer *timer;
    IBOutlet UILabel *timeField;
    IBOutlet UILabel *dateField;
    IBOutlet UILabel *memoFeild;
}

@property (weak, nonatomic) IBOutlet UITextView *scheduleFiled; //일정 표시 text view

@property (weak, nonatomic) IBOutlet UITextView *weatherField;  //날씨 표시 text view
@property (weak, nonatomic) IBOutlet UIImageView *logoField;    //로고 표시 image view
@property (weak, nonatomic) IBOutlet UIButton *infoButton;  //info button

- (IBAction)settingTouch:(id)sender;

//기능 버튼 클릭했을 때
-(IBAction) functionPressed:(id)sender;

-(void) onTimer; // 타이머 이벤트

extern NSString *uuid;

@end
