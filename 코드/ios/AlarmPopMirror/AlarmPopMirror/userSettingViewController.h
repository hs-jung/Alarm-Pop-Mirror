//
//  userSettingViewController.h
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 23..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainViewController.h"

@interface userSettingViewController : UIViewController{
    
}

@property (weak, nonatomic) IBOutlet UILabel *userID;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UIButton *addImageButton1;
@property (weak, nonatomic) IBOutlet UIButton *addImageButton2;
@property (weak, nonatomic) IBOutlet UIButton *addImageButton3;

- (IBAction)logoutClicked:(id)sender;
- (IBAction)takePhoto;
- (IBAction)choosePhoto;
- (IBAction)addImageButton1:(id)sender;
- (IBAction)addImageButton2:(id)sender;
- (IBAction)addImageButton3:(id)sender;
- (IBAction)backButtonClicked:(id)sender;


@end
