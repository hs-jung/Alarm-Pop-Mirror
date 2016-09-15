//
//  addLocationViewController.m
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 9. 15..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import "addLocationViewController.h"

@interface addLocationViewController (){

}

@end

@implementation addLocationViewController

- (void)viewDidLoad {
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.png"]];
    [super viewDidLoad];
    
    cityPicker = [[UIPickerView alloc] init];
    cityPicker.delegate = self;
    cityPicker.dataSource = self;
    
    
    pickData = [[NSArray alloc] initWithObjects:@"---- city ----",@"서울 특별시",@"대전 광역시",@"대구 광역시",@"부산 광역시",@"찍고", nil];
    
    
    // Do any additional setup after loading the view.
    
    UIToolbar *toolBar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 375, 40)];
    [toolBar1 setTintColor:[UIColor lightGrayColor]];
    //UIToolbar *toolBar2 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 375, 40)];
    //[toolBar2 setTintColor:[UIColor lightGrayColor]];
    //UIToolbar *toolBar3 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 375, 40)];
    //[toolBar3 setTintColor:[UIColor lightGrayColor]];
    
    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButton1Pressed)];
    //UIBarButtonItem *doneButton2 = [[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButton2Pressed)];
    //UIBarButtonItem *doneButton3 = [[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButton3Pressed)];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [toolBar1 setItems:[NSArray arrayWithObjects: space, doneButton1,nil]];
    //[toolBar2 setItems:[NSArray arrayWithObjects: space, doneButton2,nil]];
    //[toolBar3 setItems:[NSArray arrayWithObjects: space, doneButton3,nil]];
    
    _cityField.placeholder = @"city";
    //_timeSettingField.placeholder = @"time";
    //_subjectSettingField.placeholder = @"subject";
    
    [self.cityField setInputView:cityPicker];
    [self.cityField setInputAccessoryView:toolBar1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) doneButton1Pressed {
    [_cityField resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [pickData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickData objectAtIndex:row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //NSLog(@"value:%i",(int)row);
    if (row == 0) {
        [pickerView selectRow:row+1 inComponent:component animated:YES];
    }else{
        _cityField.text = [pickData objectAtIndex:row];
    }
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(row==0){
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:[pickData objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    
        return attString;
    }else{
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:[pickData objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        
        return attString;
    }
    
    
}


@end
