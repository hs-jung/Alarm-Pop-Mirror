//
//  ViewController.h
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 5. 24..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginViewController.h"


@class loginViewController;

@interface ViewController : UIViewController
{
    // Activity Indicator
    UIActivityIndicatorView *activityIndicator;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *IntroView; //intro배경화면 view
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator; //Activity Indicator
@property (weak, nonatomic) loginViewController *LoginViewController;

@end

