//
//  userSettingViewController.m
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 23..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import "userSettingViewController.h"
#import "mainViewController.h"

@interface userSettingViewController ()

@end

@implementation userSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _userID.text=[NSString stringWithFormat:@"%@",uuid];
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

- (IBAction)logoutClicked:(id)sender {
    NSLog(@"%@ LOGED OUT",uuid);
    uuid == nil;
    [self switchView];
    
}

-(void)switchView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * loginViewController = [storyboard   instantiateViewControllerWithIdentifier:@"loginViewController"] ;
    [self presentViewController:loginViewController animated:YES completion:nil];
}
@end
