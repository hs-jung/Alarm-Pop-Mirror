//
//  settingViewController.m
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 21..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import "settingViewController.h"

@interface settingViewController ()

@end

@implementation settingViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.png"]];
    
    [super viewDidLoad];
    
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
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

- (IBAction)schedulebutton:(id)sender {
}

- (IBAction)memobutton:(id)sender {
}

- (IBAction)weatherbutton:(id)sender {
}

- (IBAction)newsbutton:(id)sender {
}
@end
