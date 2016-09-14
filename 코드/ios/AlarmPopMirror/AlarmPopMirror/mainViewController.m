//
//  mainViewController.m
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 20..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import "mainViewController.h"
#import "editScheduleViewController.h"

@interface mainViewController ()

@end

NSString *uuid = nil;
NSString *userMemo = nil;
BOOL checkChange = false;

@implementation mainViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.png"]];
    
    NSLog(@"uuid : %@",uuid);
    [self onTimer];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    
    [dateField setFont:[UIFont fontWithName:@"Arial" size:40]];
    [timeField setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:45]];
    
    //로고 표시
    [_logoField setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"logo" ofType:@"png"]]];
    
    //일정 가져오기, 출력
    _schedule_id = [[NSMutableArray alloc] init];
    _scheduleSubject = [[NSMutableArray alloc] init];
    _scheduleYmdt = [[NSMutableArray alloc] init];
    _fullYmdt = [[NSMutableArray alloc] init];
    [self loadSchedule];
    
    //memo 가져오기, 출력
    [self loadMemo];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:nil];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 375, 40)];
    [toolBar setTintColor:[UIColor lightGrayColor]];
    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonPressed)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects: space, doneButton1,nil]];
    
    [memoField setInputView:datePicker];
    [memoField setInputAccessoryView:toolBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    memoField.delegate = self;
    
    //날씨 가져오기, 출력
    //_weatherField.text = @"test WEATHER test.";
    
    [super viewDidLoad];
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)settingTouch:(id)sender {
}

//타이머 이벤트
-(void) onTimer{
    int pmonth,pday,phour,pminute;
    
    NSCalendar *pCalendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDate *date= [NSDate date];
    NSDateComponents *comps = [pCalendar components:unitFlags fromDate:date];
    pmonth=(int)[comps month];
    pday=(int)[comps day];
    phour=(int)[comps hour];
    pminute=(int)[comps minute];
    //psecond=(int)[comps second];
    
    dateField.text=[NSString stringWithFormat:@"%02d\n/ %02d",pmonth,pday];
    timeField.text=[NSString stringWithFormat:@"%02d : %02d",phour,pminute];
}

//memo 가져오기
-(void) loadMemo{
    NSString *userMemoContents;
    NSInteger umemo_id;
    NSString *replacedMemo=nil;
    
    @try {
            NSString *post =[[NSString alloc] initWithFormat:@"id=%@",uuid];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://cslab2.kku.ac.kr/~200917307/memo.php"];
            
            NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
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
                
                umemo_id = [jsonData[@"umemo_id"] integerValue];
                NSLog(@"umemo_id: %ld",umemo_id);
                
                if(umemo_id > 0)
                {
                    userMemoContents = [jsonData objectForKey:@"content"];
                    replacedMemo = [userMemoContents stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
                    [memoField setText:replacedMemo];
                } else {
                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
                }
                
            } else {
                if (error) NSLog(@"Error: %@", error);
            }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
}

//메모 수정
-(void) saveMemo{
    NSInteger success = 0;
    NSString *replaced_memo= nil;
   
    if(checkChange){
    
    @try {
        replaced_memo =[memoField.text stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
        
        NSString *post =[[NSString alloc] initWithFormat:@"id=%@&content=%@",uuid,replaced_memo];
        NSLog(@"PostData: %@",post);
    
        NSURL *url=[NSURL URLWithString:@"http://cslab2.kku.ac.kr/~200917307/memom.php"];
        
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
                checkChange = false;
                NSLog(@"save complete");
            } else {
                    
                NSString *error_msg = (NSString *) jsonData[@"error_message"];
                [self alertStatus:error_msg :@"memo " :0];
            }
                
        } else {
            if (error) NSLog(@"Error: %@", error);
            [self alertStatus:@"Connection Failed" :@"Modify Failed!" :0];
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Modify Failed." :@"Error!" :0];
    }
    }
}

//알람창
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


- (void)textViewDidEndEditing:(UITextView *)textView{
    [self saveMemo];
    
}

//테이블 라인 갯수 설정
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    [tableView setRowHeight:63];
    [tableView setCellLayoutMarginsFollowReadableWidth:YES];
    return [self.scheduleSubject count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *scheduleIdentifier = @"scheduleIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:scheduleIdentifier];
    
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:scheduleIdentifier];
    }
    cell.backgroundColor = cell.contentView.backgroundColor;
    
    cell.textLabel.text =  self.scheduleSubject[indexPath.row];
    cell.detailTextLabel.text = self.scheduleYmdt[indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
    return cell;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger deleteNum = [indexPath row];
    NSInteger arraySize = _schedule_id.count;
    [self deleteSchedule:_schedule_id[deleteNum]];
    
    for(int i=deleteNum ; i<arraySize-1 ; i++){
        _schedule_id[i] = _schedule_id[i+1];
        _scheduleSubject[i] = _scheduleSubject[i+1];
        _scheduleYmdt[i] = _scheduleYmdt[i+1];
        _fullYmdt[i] = _fullYmdt[i+1];
    }
    
    [_schedule_id removeObjectAtIndex:arraySize-1];
    [_scheduleSubject removeObjectAtIndex:arraySize-1];
    [_scheduleYmdt removeObjectAtIndex:arraySize-1];
    [_fullYmdt removeObjectAtIndex:arraySize-1];
    
    [tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger cellNumber = indexPath.row;
    editDate = [_fullYmdt[(long)cellNumber] substringWithRange:NSMakeRange(0,10)];
    editTime = [_fullYmdt[(long)cellNumber] substringWithRange:NSMakeRange(11,5)];
    editSubject = _scheduleSubject[cellNumber];
    editScheduleId = _schedule_id[(long)cellNumber];
    NSLog(@"%@",editScheduleId);
    [self switchView];
}


//일정 가져오기

- (void) loadSchedule{
    NSDictionary *contents;
    NSMutableArray *userScheduleContents;
    NSInteger rows;
    
    @try {
        NSString *post =[[NSString alloc] initWithFormat:@"id=%@",uuid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://cslab2.kku.ac.kr/~200917307/schedule.php"];
        
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
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
            
            rows = [jsonData[@"rows"] integerValue];
            NSLog(@"rows: %ld",(long)rows);
            
            if(rows == 0)
            {
                //do nothing
            }else if(rows ==1){
                [self.scheduleSubject addObject:[jsonData objectForKey:@"subject"]];
                [self.scheduleYmdt addObject:[[jsonData objectForKey:@"ymdt"] substringWithRange:NSMakeRange(11,5)]];
                [self.schedule_id addObject:[jsonData objectForKey:@"schedule_id"]];
                [self.fullYmdt addObject:[contents objectForKey:@"ymdt"]];
            }else if (rows > 1) {
                
                userScheduleContents = [jsonData objectForKey:@"array"];
                
                for(int i=0; i<rows; i++){
                    contents = userScheduleContents[i];
                    [self.scheduleSubject addObject:[contents objectForKey:@"subject"]];
                    [self.scheduleYmdt addObject:[[contents objectForKey:@"ymdt"] substringWithRange:NSMakeRange(11,5)]];
                    [self.schedule_id addObject:[contents objectForKey:@"schedule_id"]];
                    [self.fullYmdt addObject:[contents objectForKey:@"ymdt"]];
                }
                //NSLog(@"Schedule Load SUCCESS");
            }else{
                NSString *error_msg = (NSString *) jsonData[@"error_message"];
            }
            
        } else {
            if (error) NSLog(@"Error: %@", error);
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    checkChange = true;
}

-(void) doneButtonPressed{
    [self saveMemo];
    [memoField resignFirstResponder];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    [self.view setFrame:CGRectMake(0,-170,375,667)];
   
}
 -(void)keyboardDidHide:(NSNotification *)notification {
         [self.view setFrame:CGRectMake(0,0,375,667)];
}


- (void) deleteSchedule:(id)sender{
    NSInteger success;
    
    @try {
        NSString *post =[[NSString alloc] initWithFormat:@"id=%@&sid=%@",uuid,sender];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://cslab2.kku.ac.kr/~200917307/delesche.php"];
        
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
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
            NSLog(@"success: %ld",(long)success);
            
            if(success == 1)
            {
                [tableView reloadData];
                [self alertStatus:@"삭제되었습니다." :@"Deleted!" :0];
                
            }else{
                NSString *error_msg = (NSString *) jsonData[@"error_message"];
            }
            
        } else {
            if (error) NSLog(@"Error: %@", error);
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
}

-(void)switchView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * editScheduleViewController = [storyboard  instantiateViewControllerWithIdentifier:@"editScheduleViewController"] ;
    editScheduleViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:editScheduleViewController animated:YES completion:nil];
}

@end
