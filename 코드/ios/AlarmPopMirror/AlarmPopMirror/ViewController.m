//
//  ViewController.m
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 5. 24..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import "ViewController.h"
#import "loginViewController.h"

@interface ViewController ()

@end

@implementation ViewController;
@synthesize activityIndicator;
@synthesize LoginViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //intro 이미지 표시
    [_IntroView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"introImage" ofType:@"png"]]];
    
    
    //activity indicator 시작
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [activityIndicator setCenter:CGPointMake(177.0,530.0)]; //좌표지정
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview : activityIndicator];
    
    activityIndicator.hidden= FALSE;
    [activityIndicator startAnimating];
    
    //3초후 login화면으로 전환
    [NSTimer scheduledTimerWithTimeInterval : 2.0 target:self selector:@selector(switchView) userInfo:nil repeats:NO];
    
}


-(void)switchView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * loginViewController = [storyboard   instantiateViewControllerWithIdentifier:@"loginViewController"] ;
    [self presentViewController:loginViewController animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testbutton:(id)sender {
}

@end
