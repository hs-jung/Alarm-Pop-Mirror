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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.png"]];
    
    [super viewDidLoad];
    
    _userID.text=[NSString stringWithFormat:@"%@",uuid];
    
    [userPhoto setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"addImage" ofType:@"png"]]];
    
    //image 가져오기
    [self bringImage];
    
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

- (IBAction)logoutClicked:(id)sender {
    NSLog(@"%@ LOGED OUT", uuid);
    uuid = nil;
    [self alertStatus:nil :@"LOG OUT" :0];
    [self switchView];
    
}

-(void)switchView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * loginViewController = [storyboard   instantiateViewControllerWithIdentifier:@"loginViewController"] ;
    loginViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:loginViewController animated:YES completion:nil];
}

- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}

-(void) bringImage{
    
}

//사진 촬영
- (IBAction)takePhoto {
    picker =[[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}

//사진 가져오기
-(IBAction)choosePhoto{
    picker2 =[[UIImagePickerController alloc] init];
    picker2.delegate = self;
    picker2.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker2 animated:YES completion:NULL];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *selectedPhoto = [info objectForKey:UIImagePickerControllerOriginalImage];
    [userPhoto setImage:selectedPhoto];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
