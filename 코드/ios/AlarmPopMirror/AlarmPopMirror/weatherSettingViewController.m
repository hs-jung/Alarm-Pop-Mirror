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
    tableView = [[UITableView alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger tableHeight;
    tableHeight = [locationArray count]*90;
    
    if(tableHeight > 450){
        tableHeight = 450;
    }
    
    tableView.frame = CGRectMake(9, 148, 357, tableHeight);
    tableView.backgroundColor = [UIColor clearColor];
    [tableView setRowHeight:90];
    [tableView setCellLayoutMarginsFollowReadableWidth:YES];
    return [locationArray count];
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
    
    /*
    UIImage *weatherIcon = [[UIImage alloc]init];
    if ([skyCodeArray[0] isEqualToString:@"SKY_A01"])
    {
        weatherIcon = [UIImage imageNamed:@"sun.png"];
    }else if([skyCodeArray[0] isEqualToString:@"SKY_A02"]){
        
        weatherIcon = [UIImage imageNamed:@"cloud.png"];
    }else if([skyCodeArray[0] isEqualToString:@"SKY_A03"] || [skyCodeArray[0] isEqualToString:@"SKY_A04"] || [skyCodeArray[0] isEqualToString:@"SKY_A05"] || [skyCodeArray[0] isEqualToString:@"SKY_A06"]){
        
        weatherIcon = [UIImage imageNamed:@"cloud2.png"];
    }else if([skyCodeArray[0] isEqualToString:@"SKY_A07"] || [skyCodeArray[0] isEqualToString:@"SKY_A08"] || [skyCodeArray[0] isEqualToString:@"SKY_A09"] || [skyCodeArray[0] isEqualToString:@"SKY_A10"] || [skyCodeArray[0] isEqualToString:@"SKY_A11"]){
        
        weatherIcon = [UIImage imageNamed:@"cloudwithsun.png"];
    }else if([skyCodeArray[0] isEqualToString:@"SKY_A12"] || [skyCodeArray[0] isEqualToString:@"SKY_A14"]){
        
        weatherIcon = [UIImage imageNamed:@"umbrella.png"];
    }else if([skyCodeArray[0] isEqualToString:@"SKY_A13"]){
        
        weatherIcon = [UIImage imageNamed:@"snowflake.png"];
    }else{
        //do nothing.
    }
    
    cell.imageView.image = weatherIcon;
    */
    
    cell.textLabel.text =  locationArray[indexPath.row];
    cell.detailTextLabel.text = subtextArray[indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    //[cell.textLabel.textAlignment right];
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
    NSInteger arraySize = [locationArray count];
    [self deleteLocation:(int)deleteNum];
    
    
    for(int i = (int)deleteNum ; i<arraySize-1 ; i++){
        locationArray[i] = locationArray[i+1];
        subtextArray[i] = subtextArray[i+1];
    }
    
    [locationArray removeObjectAtIndex:arraySize-1];
    [subtextArray removeObjectAtIndex:arraySize-1];
    
    [tableView reloadData];
}

- (void) deleteLocation:(int)sender{
    NSInteger success;
    
    @try {
        NSString *post =[[NSString alloc] initWithFormat:@"id=%@&stdid=%@&city=%@",uuid,codeArray[sender],locationArray[sender]];
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

@end
