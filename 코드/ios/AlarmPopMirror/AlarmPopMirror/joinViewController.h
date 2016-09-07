//
//  joinViewController.h
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 22..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginViewController.h"

@interface joinViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate>
{
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    IBOutlet UIImageView *userPhoto;
}

- (IBAction)idCheckButton:(id)sender;
- (IBAction)joinButton:(id)sender;
- (IBAction)cancleButton:(id)sender;

- (IBAction)backgroundTap:(id)sender;

- (IBAction)takePhoto;
- (IBAction)choosePhoto;

@property (weak, nonatomic) IBOutlet UITextField *IDField;
@property (weak, nonatomic) IBOutlet UITextField *nickNameField;
@property (weak, nonatomic) IBOutlet UITextField *PWField;
@property (weak, nonatomic) IBOutlet UITextField *PW2Field;



@property  NSInteger checked;   //ID 체크 확인

@end
