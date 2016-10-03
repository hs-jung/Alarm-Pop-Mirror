//
//  editScheduleViewController.h
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 9. 14..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainViewController.h"

@interface editScheduleViewController : UIViewController<UITextFieldDelegate>{
    UIDatePicker *datePicker;
    UIDatePicker *timePicker;
}

@property (weak, nonatomic) IBOutlet UITextField *dateSettingField;
@property (weak, nonatomic) IBOutlet UITextField *timeSettingField;
@property (weak, nonatomic) IBOutlet UITextField *subjectSettingField;

- (IBAction)backgroundTap:(id)sender;
- (IBAction)backButtonClicked:(id)sender;
- (IBAction)saveButtonClicked:(id)sender;
- (IBAction)deleteButtonClicked:(id)sender;

extern NSString *editDate;
extern NSString *editTime;
extern NSString *editSubject;
extern NSString *editScheduleId;

@end
