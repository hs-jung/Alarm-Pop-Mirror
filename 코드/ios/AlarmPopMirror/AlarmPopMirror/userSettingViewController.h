//
//  userSettingViewController.h
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 23..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainViewController.h"

@interface userSettingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *userID;
@property (weak, nonatomic) IBOutlet UILabel *nickName;

- (IBAction)logoutClicked:(id)sender;


@end
