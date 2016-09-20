//
//  weatherSettingViewController.m
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 23..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import "weatherSettingViewController.h"
#import "mainViewController.h"

@interface weatherSettingViewController ()

@end



@implementation weatherSettingViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.png"]];
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [super viewDidLoad];
    
    _code = [[NSMutableArray alloc] init];
    _location = [[NSMutableArray alloc] init];
    _skyCode = [[NSMutableArray alloc] init];
    _skyName = [[NSMutableArray alloc] init];
    _tc = [[NSMutableArray alloc] init];
    _tmax = [[NSMutableArray alloc] init];
    _tmin = [[NSMutableArray alloc] init];
    _subtext = [[NSMutableArray alloc] init];
    
    [self loadLocation];
    
    NSInteger arrSize = [_location count];
    
    
    for(int i=0; i<[_location count]; i++){
        [self loadWeather:_code[i]];
    }
    //NSLog(@"load finish-load finish-load finish-load finish-,,,,,%d",arrSize);
    
    for(int i=0; i<[_location count]; i++){
        _subtext[i] = [NSString stringWithFormat:@"%@ %@'C (%@'C / %@'C)", _skyName[i], _tc[i], _tmin[i], _tmax[i]];
        NSLog(@"subtext : %@",_subtext[i]);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger tableHeight;
    tableHeight = [_location count]*90;
    
    if(tableHeight > 450){
        tableHeight = 450;
    }
    
    tableView.frame = CGRectMake(9, 148, 357, tableHeight);
    tableView.backgroundColor = [UIColor clearColor];
    [tableView setRowHeight:90];
    [tableView setCellLayoutMarginsFollowReadableWidth:YES];
    return [self.location count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *locationIdentifier = @"locationIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:locationIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:locationIdentifier];
    }
    
    if(indexPath.row % 2 == 0){
        cell.backgroundColor = [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1];
    } else{
        cell.backgroundColor = [UIColor clearColor];
    }
    
    UIImage *weatherIcon = [[UIImage alloc]init];
    if ([_skyCode[0] isEqualToString:@"SKY_A01"])
    {
        weatherIcon = [UIImage imageNamed:@"sun.png"];
    }else if([_skyCode[0] isEqualToString:@"SKY_A02"]){
        
        weatherIcon = [UIImage imageNamed:@"cloud.png"];
    }else if([_skyCode[0] isEqualToString:@"SKY_A03"] || [_skyCode[0] isEqualToString:@"SKY_A04"] || [_skyCode[0] isEqualToString:@"SKY_A05"] || [_skyCode[0] isEqualToString:@"SKY_A06"]){
        
        weatherIcon = [UIImage imageNamed:@"cloud2.png"];
    }else if([_skyCode[0] isEqualToString:@"SKY_A07"] || [_skyCode[0] isEqualToString:@"SKY_A08"] || [_skyCode[0] isEqualToString:@"SKY_A09"] || [_skyCode[0] isEqualToString:@"SKY_A10"] || [_skyCode[0] isEqualToString:@"SKY_A11"]){
        
        weatherIcon = [UIImage imageNamed:@"cloudwithsun.png"];
    }else if([_skyCode[0] isEqualToString:@"SKY_A12"] || [_skyCode[0] isEqualToString:@"SKY_A14"]){
        
        weatherIcon = [UIImage imageNamed:@"umbrella.png"];
    }else if([_skyCode[0] isEqualToString:@"SKY_A13"]){
        
        weatherIcon = [UIImage imageNamed:@"snowflake.png"];
    }else{
        //do nothing.
    }
    
    
    cell.imageView.image = weatherIcon;
    
    cell.textLabel.text =  self.location[indexPath.row];
    cell.detailTextLabel.text = self.subtext[indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
    
    return cell;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


//셀 삭제
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger deleteNum = [indexPath row];
    NSInteger arraySize = _location.count;
    [self deleteLocation:(int)deleteNum];
    
    
    for(int i = (int)deleteNum ; i<arraySize-1 ; i++){
        _location[i] = _location[i+1];
        _subtext[i] = _subtext[i+1];
    }
    
    [_location removeObjectAtIndex:arraySize-1];
    [_subtext removeObjectAtIndex:arraySize-1];
    
    [tableView reloadData];
}

- (void) deleteLocation:(int)sender{
    NSInteger success;
    
    @try {
        NSString *post =[[NSString alloc] initWithFormat:@"id=%@&stdid=%@&city=%@",uuid,_code[sender],_location[sender]];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://cslab2.kku.ac.kr/~200917307/deleteweatherloca.php"];
        
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
                //success delete. do nothing
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


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//지역 가져오기
-(void)loadLocation{
    NSDictionary *contents;
    NSMutableArray *userWeatherContents;
    NSInteger rows;
    
    @try {
        NSString *post =[[NSString alloc] initWithFormat:@"id=%@",uuid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://cslab2.kku.ac.kr/~200917307/weatherloca.php"];
        
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
                NSLog(@"load location success");
                [self.code addObject:[jsonData objectForKey:@"stdid"]];
                [self.location addObject:[jsonData objectForKey:@"city"]];
                NSLog(@"load location success");
                
            }else if (rows > 1) {
                
                userWeatherContents = [jsonData objectForKey:@"array"];
                
                for(int i=0; i<rows; i++){
                    contents = userWeatherContents[i];
                    [self.code addObject:[contents objectForKey:@"stdid"]];
                    [self.location addObject:[contents objectForKey:@"city"]];
                    NSLog(@"teset ::: %@,%@",_location[i],_code[i]);
                }
                //NSLog(@"Schedule Load SUCCESS");
            }else{
                NSString *error_msg = (NSString *) jsonData[@"error_message"];
            }
            NSLog(@"load location success");
            
        } else {
            if (error) NSLog(@"Error: %@", error);
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
}

//날씨 가져오기
-(void)loadWeather :(id) sender{
    @try {
        NSString *url = [[NSString alloc] initWithFormat:@"http://apis.skplanetx.com/weather/current/minutely?&Content-Length=320&Content-Type=utf-8&Accept=application/json&Accept-Language=ko&host=www.skplanetx.com&appKey=49712187-23b7-3bc4-a200-8b30d4daf837&version=1&stnid=%@", sender];
        
        NSString *serviceUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:serviceUrl]];
        
        NSURLConnection *joinConnection = [NSURLConnection connectionWithRequest:request delegate:self];
        
        NSHTTPURLResponse *response;
        NSError *error;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSDictionary *weather;
        NSArray *minutely;
        NSDictionary *today;
        NSDictionary *sky;
        NSDictionary *temperature;
        NSDictionary *temp;
        
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
            
            weather = [jsonData objectForKey:@"weather"];
            
            minutely =  [weather objectForKey:@"minutely"];
            temp = minutely[0];
            sky =  [temp objectForKey:@"sky"];
            temperature =  [temp objectForKey:@"temperature"];
            
            [self.skyName addObject:[sky objectForKey:@"name"]];
            [self.skyCode addObject:[sky objectForKey:@"code"]];
            [self.tc addObject:[temperature objectForKey:@"tc"]];
            [self.tmax addObject:[temperature objectForKey:@"tmax"]];
            [self.tmin addObject:[temperature objectForKey:@"tmin"]];
            
        } else {
            if (error) NSLog(@"Error: %@", error);
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }

    
}

@end
