//
//  joinViewController.h
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 22..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface joinViewController : UIViewController <UITextFieldDelegate>


- (IBAction)idCheckButton:(id)sender;
- (IBAction)joinButton:(id)sender;
- (IBAction)cancleButton:(id)sender;

- (IBAction)backgroundTap:(id)sender;

@end
