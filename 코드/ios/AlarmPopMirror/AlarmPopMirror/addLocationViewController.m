//
//  addLocationViewController.m
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 9. 15..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import "addLocationViewController.h"
#import "mainViewController.h"

@interface addLocationViewController (){
    
    NSDictionary *cases;

}

@end

@implementation addLocationViewController

- (void)viewDidLoad {
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.png"]];
    [super viewDidLoad];
    
    locationPicker = [[UIPickerView alloc] init];
    locationPicker.delegate = self;
    locationPicker.dataSource = self;
    cityPicker = [[UIPickerView alloc] init];
    cityPicker.delegate = self;
    cityPicker.dataSource = self;
    
    stdid = [[NSNumber alloc]init];
    
    locationData = [[NSArray alloc] initWithObjects:@"---- location ----",@"특별시 / 광역시",@"경기도",@"강원도",@"충청북도",@"충청남도",@"전라북도",@"전라남도",@"경상북도",@"경상남도",@"제주 특별 자치도",nil];
    cityData0 = [[NSArray alloc] init];
    cityData1 = [[NSArray alloc] initWithObjects:@"---- city ----",@"서울 특별시",@"인천 광역시",@"대전 광역시",@"광주 광역시",@"울산광역시",@"부산 광역시",nil];
    cityData2 = [[NSArray alloc] initWithObjects:@"---- city ----",@"동두천시",@"수원시",@"양평군",@"이천시",@"파주시",nil];
    cityData3 = [[NSArray alloc] initWithObjects:@"---- city ----",@"강릉시",@"고성군",@"동해시",@"영월군",@"원주시",@"인제군",@"정선군",@"철원군",@"춘천시",@"태백시",@"평창군",@"홍천군",nil];
    cityData4 = [[NSArray alloc] initWithObjects:@"---- city ----",@"보은군",@"영동군",@"제천시",@"청주시",@"충주시",nil];
    cityData5 = [[NSArray alloc] initWithObjects:@"---- city ----",@"금산군",@"보령시",@"부여군",@"서산시",@"천안시",nil];
    cityData6 = [[NSArray alloc] initWithObjects:@"---- city ----",@"고창군",@"군산시",@"남원시",@"부안군",@"순창군",@"임실군",@"장수군",@"전주시",@"정읍시",nil];
    cityData7 = [[NSArray alloc] initWithObjects:@"---- city ----",@"강진군",@"고흥군",@"광양시",@"목포시",@"보성군",@"순천시",@"신안군",@"여수시",@"영광군",@"완도군",@"장흥군",@"진도군",@"해남군",nil];
    cityData8 = [[NSArray alloc] initWithObjects:@"---- city ----",@"경주시",@"구미시",@"문경시",@"봉화군",@"상주시",@"안동시",@"영덕군",@"영주시",@"영천시",@"울릉군",@"울진군",@"의성군",@"청송군",@"포항시",nil];
    cityData9 = [[NSArray alloc] initWithObjects:@"---- city ----",@"거제시",@"거창군",@"김해시",@"남해군",@"밀양시",@"산청군",@"양산시",@"의련군",@"진주시",@"창원시",@"통영시",@"함양군군",@"합천군",nil];
    cityData10 = [[NSArray alloc] initWithObjects:@"---- city ----",@"서귀포시",@"제주시",nil];
    
    locationPicker.tag=1;
    cityPicker.tag=2;
    
    UIToolbar *toolBar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 375, 40)];
    [toolBar1 setTintColor:[UIColor lightGrayColor]];
    UIToolbar *toolBar2 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 375, 40)];
    [toolBar2 setTintColor:[UIColor lightGrayColor]];
    
    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButton1Pressed)];
    UIBarButtonItem *doneButton2 = [[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButton2Pressed)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [toolBar1 setItems:[NSArray arrayWithObjects: space, doneButton1,nil]];
    [toolBar2 setItems:[NSArray arrayWithObjects: space, doneButton2,nil]];
    
    
    _locationField.placeholder = @"location";
    _cityField.placeholder = @"city";
    
    
    [self.locationField setInputView:locationPicker];
    [self.locationField setInputAccessoryView:toolBar1];
    [self.cityField setInputView:cityPicker];
    [self.cityField setInputAccessoryView:toolBar2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) doneButton1Pressed {
    [_locationField resignFirstResponder];
}

-(void) doneButton2Pressed {
    [_cityField resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)saveButtonClicked:(id)sender {
    
    NSInteger success = 0;
    
       @try {
        
        NSString *post =[[NSString alloc] initWithFormat:@"id=%@&stdid=%@&location=%@",uuid,stdid,_cityField.text];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://cslab2.kku.ac.kr/~200917307/addweatherloca.php"];
        
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSLog(@"Response code: %ld", (long)[response statusCode]);
        
        if ([response statusCode] >= 200 && [response statusCode] < 300)
        {
            NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            NSLog(@"Response ==> %@", responseData);
            
            NSError *error = nil;
            NSDictionary *jsonData = [NSJSONSerialization
                                      JSONObjectWithData:urlData
                                      options:NSJSONReadingMutableContainers
                                      error:&error];
            
            success = [jsonData[@"Success"] integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            if(success == 1)
            {
                [self switchView];
                NSLog(@"Location Add SUCCESS");
            } else {
                
                NSString *error_msg = (NSString *) jsonData[@"error_message"];
                [self alertStatus:error_msg :@"Add Failed!" :0];
            }
            
        } else {
            if (error) NSLog(@"Error: %@", error);
            [self alertStatus:@"Connection Failed" :@"Add Failed!" :0];
        }
    }
    
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Add Failed." :@"Error!" :0];
    }

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

-(void)switchView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * weatherViewController = [storyboard  instantiateViewControllerWithIdentifier:@"weatherSettingViewController"] ;
    weatherViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:weatherViewController animated:YES completion:nil];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pickerView.tag==1){
        return [locationData count];
    }else{
        return [cityData0 count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView.tag == 1){
        return [locationData objectAtIndex:row];
    }else{
        return [cityData0 objectAtIndex:row];
    }
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView.tag ==1){
        if (row == 0) {
            [pickerView selectRow:row+1 inComponent:component animated:YES];
        }else{
            switch (row) {
                case 1:
                    cityData0 = cityData1;
                    break;
                case 2:
                    cityData0 = cityData2;
                    break;
                case 3:
                    cityData0 = cityData3;
                    break;
                case 4:
                    cityData0 = cityData4;
                    break;
                case 5:
                    cityData0 = cityData5;
                    break;
                case 6:
                    cityData0 = cityData6;
                    break;
                case 7:
                    cityData0 = cityData7;
                    break;
                case 8:
                    cityData0 = cityData8;
                    break;
                case 9:
                    cityData0 = cityData9;
                    break;
                case 10:
                    cityData0 = cityData10;
                    break;
                default:
                    break;
            }
            
            _locationField.text = [locationData objectAtIndex:row];
        }
    }else{
        if (row == 0) {
            [pickerView selectRow:row+1 inComponent:component animated:YES];
        }else{
            
            switch (row) {
                case 1:
                    
                    cases = @{@"서울 특별시" : @108,
                              @"동두천시" : @98,
                              @"강릉시" : @105,
                              @"고창군" : @251,
                              @"보은군" : @226,
                              @"금산군" : @238,
                              @"강진군" : @259,
                              @"경주시" : @283,
                              @"거제시" : @294,
                              @"서귀포시" : @189
                              };
                    
                    stdid = [cases objectForKey:[cityData0 objectAtIndex:row]];
                
                    break;
                case 2:
                    
                    cases = @{@"인천 광역시" : @112,
                              @"수원시" : @119,
                              @"고성군" : @90,
                              @"군산시" : @140,
                              @"영동군" : @135,
                              @"보령시" : @235,
                              @"고흥군" : @262,
                              @"구미시" : @279,
                              @"거창군" : @284,
                              @"제주시" : @184
                              };
                    
                    stdid = [cases objectForKey:[cityData0 objectAtIndex:row]];
                    
                    break;
                case 3:
                    
                    cases = @{@"대전 광역시" : @133,
                              @"양평군" : @202,
                              @"동해시" : @106,
                              @"남원시" : @247,
                              @"제천시" : @221,
                              @"부여군" : @236,
                              @"광양시" : @266,
                              @"문경시" : @273,
                              @"김해시" : @253
                              };
                    
                    stdid = [cases objectForKey:[cityData0 objectAtIndex:row]];
                    
                    break;
                case 4:
                    
                    cases = @{@"광주 광역시" : @156,
                              @"이천시" : @203,
                              @"영월군" : @121,
                              @"부안군" : @243,
                              @"청주시" : @131,
                              @"서산시" : @129,
                              @"목포시" : @165,
                              @"봉화군" : @271,
                              @"남해군" : @295
                              };
                    
                    stdid = [cases objectForKey:[cityData0 objectAtIndex:row]];
                    
                    break;
                case 5:
                    
                    cases = @{@"울산 광역시" : @152,
                              @"파주시" : @99,
                              @"원주시" : @114,
                              @"순창군" : @254,
                              @"충주시" : @127,
                              @"천안시" : @232,
                              @"보성군" : @258,
                              @"상주시" : @137,
                              @"밀양시" : @288
                              };
                    
                    stdid = [cases objectForKey:[cityData0 objectAtIndex:row]];
                    
                    break;
                case 6:
                    
                    cases = @{@"부산 광역시" : @159,
                              @"인제군" : @211,
                              @"임실군" : @244,
                              @"순천시" : @174,
                              @"안동시" : @136,
                              @"산청군" : @289
                              };
                    
                    stdid = [cases objectForKey:[cityData0 objectAtIndex:row]];
                    
                    break;
                case 7:
                    
                    cases = @{@"정선군" : @217,
                              @"장수군" : @248,
                              @"신안군" : @169,
                              @"영덕군" : @277,
                              @"양산시" : @257
                              };
                    
                    stdid = [cases objectForKey:[cityData0 objectAtIndex:row]];
                    
                    break;
                case 8:
                    
                    cases = @{@"철원군" : @95,
                              @"전주시" : @146,
                              @"여수시" : @168,
                              @"영주시" : @272,
                              @"의련군" : @263
                              };
                    
                    stdid = [cases objectForKey:[cityData0 objectAtIndex:row]];
                    
                    break;
                case 9:
                    
                    cases = @{@"춘천시" : @101,
                              @"정읍시" : @245,
                              @"영광군" : @252,
                              @"영천시" : @281,
                              @"진주시" : @192
                              };
                    
                    stdid = [cases objectForKey:[cityData0 objectAtIndex:row]];
                    
                    break;
                case 10:
                    
                    cases = @{@"태백시" : @216,
                              @"완도군" : @170,
                              @"울릉군" : @115,
                              @"창원시" : @155
                              };
                    
                    stdid = [cases objectForKey:[cityData0 objectAtIndex:row]];
                    
                    break;
                case 11:
                    
                    cases = @{@"평창군" : @100,
                              @"장흥군" : @170,
                              @"울진군" : @130,
                              @"통영시" : @162
                              };
                    
                    stdid = [cases objectForKey:[cityData0 objectAtIndex:row]];
                    
                    break;
                case 12:
                    
                    cases = @{@"홍천군" : @212,
                              @"진도군" : @268,
                              @"의성군" : @278,
                              @"함양군군" : @264
                              };
                    
                    stdid = [cases objectForKey:[cityData0 objectAtIndex:row]];
                    
                    break;
                case 13:
                    
                    cases = @{@"해남군" : @261,
                              @"청송군" : @276,
                              @"합천군" : @285
                              };
                    
                    stdid = [cases objectForKey:[cityData0 objectAtIndex:row]];
                    
                    break;
                case 14:
                    
                    cases = @{@"포항시" : @138
                              };
                    
                    stdid = [cases objectForKey:[cityData0 objectAtIndex:row]];
                    
                    break;
                    
                    
                default:
                    break;
            }
            
            //NSLog(@"STDID : %@",stdid);
            _cityField.text = [cityData0 objectAtIndex:row];
        }
    }
    
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView.tag == 1){
        if(row==0){
            NSAttributedString *attString = [[NSAttributedString alloc] initWithString:[locationData    objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    
            return attString;
        }else{
            NSAttributedString *attString = [[NSAttributedString alloc] initWithString:[locationData    objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        
            return attString;
        }
    }else{
        if(row==0){
            NSAttributedString *attString = [[NSAttributedString alloc] initWithString:[cityData0    objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
            
            return attString;
        }else{
            NSAttributedString *attString = [[NSAttributedString alloc] initWithString:[cityData0    objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
            
            return attString;
        }
    }
}


@end
