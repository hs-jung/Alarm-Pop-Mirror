//
//  loginViewController.h
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 21..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainViewController.h"


@class ViewController;

@interface loginViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *IDField;
@property (weak, nonatomic) IBOutlet UITextField *PWField;

- (IBAction)backgroundTap:(id)sender;
- (IBAction)signinClicked:(id)sender;




@end
