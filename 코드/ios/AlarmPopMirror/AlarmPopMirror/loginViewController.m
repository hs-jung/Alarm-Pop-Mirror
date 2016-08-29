//
//  loginViewController.m
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 21..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import "loginViewController.h"

@interface loginViewController ()

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//로그인버튼 클릭시


//빈곳 tap하면 키보드 숨김
- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)signinClicked:(id)sender {
}

//키보드 return
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
