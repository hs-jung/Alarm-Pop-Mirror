//
//  changePWViewController.h
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 26..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginViewController.h"

@class ViewController;

@interface changePWViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *PWField;
@property (weak, nonatomic) IBOutlet UITextField *changedPWField;
@property (weak, nonatomic) IBOutlet UITextField *changedPWField2;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)changeClicked:(id)sender;

@end