//
//  addLocationViewController.h
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 9. 15..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainViewController.h"

@interface addLocationViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    
    UIPickerView *locationPicker;
    UIPickerView *cityPicker;
    NSArray *locationData;
    NSArray *cityData0;
    NSArray *cityData1;
    NSArray *cityData2;
    NSArray *cityData3;
    NSArray *cityData4;
    NSArray *cityData5;
    NSArray *cityData6;
    NSArray *cityData7;
    NSArray *cityData8;
    NSArray *cityData9;
    NSArray *cityData10;
    NSNumber *stdid;
}

@property (weak, nonatomic) IBOutlet UITextField *cityField;
@property (weak, nonatomic) IBOutlet UITextField *locationField;

- (IBAction)backgroundTap:(id)sender;
- (IBAction)saveButtonClicked:(id)sender;

@end
