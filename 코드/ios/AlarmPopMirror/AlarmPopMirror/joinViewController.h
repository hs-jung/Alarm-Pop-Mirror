//
//  joinViewController.h
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 22..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginViewController.h"

@interface joinViewController : UIViewController <UITextFieldDelegate>


- (IBAction)idCheckButton:(id)sender;
- (IBAction)joinButton:(id)sender;
- (IBAction)cancleButton:(id)sender;

- (IBAction)backgroundTap:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *IDField;
@property (weak, nonatomic) IBOutlet UITextField *nickNameField;
@property (weak, nonatomic) IBOutlet UITextField *PWField;
@property (weak, nonatomic) IBOutlet UITextField *PW2Field;
@property (weak, nonatomic) IBOutlet UIButton *addImage;


@property  NSInteger checked;   //ID 체크 확인

@end
