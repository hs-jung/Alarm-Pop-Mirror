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

//자동로그인

//빈곳 tap하면 키보드 숨김
- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

//키보드 return
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//로그인버튼 클릭시
- (IBAction)signinClicked:(id)sender {
    bool check =FALSE;
    
    //ID,PW 전송
    
    
    if(check){
        //화면전환
    }
    else{
        //팝업
    }
    
}

//PHP로 전송

-(IBAction) postLocation: (id) sender{

    NSString *latitude = @"37.3229978";
    NSString *longitude = @"-122.0321823";
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.mydomain.me/webservice.php"]];
    [request setHTTPMethod:@"POST"];
    
    NSString *post =[[NSString alloc] initWithFormat:@"latitude=%@&longitude=%@&submit=",latitude,longitude];
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
}



@end
