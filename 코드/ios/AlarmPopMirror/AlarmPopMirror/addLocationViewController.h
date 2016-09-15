//
//  addLocationViewController.h
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 9. 15..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addLocationViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    
    UIPickerView *cityPicker;
    NSArray *pickData;
}

@property (weak, nonatomic) IBOutlet UITextField *cityField;

- (IBAction)backgroundTap:(id)sender;

@end
