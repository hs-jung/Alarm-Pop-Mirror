//
//  addScheduleViewController.h
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 9. 12..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainViewController.h"

@interface addScheduleViewController : UIViewController<UITextFieldDelegate>{
    UIDatePicker *datePicker;
    UIDatePicker *timePicker;
}

@property (weak, nonatomic) IBOutlet UITextField *dateSettingField;
@property (weak, nonatomic) IBOutlet UITextField *timeSettingField;
@property (weak, nonatomic) IBOutlet UITextField *subjectSettingField;

- (IBAction)backgroundTap:(id)sender;



@end
