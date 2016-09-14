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
    
    _location = [[NSMutableArray alloc] init];
    _temperature = [[NSMutableArray alloc] init];
    _rainProbability = [[NSMutableArray alloc] init];
    _subtext = [[NSMutableArray alloc] init];
    
    [_location addObject:@"서울 특별시"];
    [_location addObject:@"충주시"];
    [_location addObject:@"익산시"];
    [_location addObject:@"제주도"];
    [_location addObject:@"독도"];
    [_temperature addObject:@"23"];
    [_temperature addObject:@"24"];
    [_temperature addObject:@"25"];
    [_temperature addObject:@"26"];
    [_temperature addObject:@"27"];
    [_rainProbability addObject:@"80"];
    [_rainProbability addObject:@"60"];
    [_rainProbability addObject:@"65"];
    [_rainProbability addObject:@"70"];
    [_rainProbability addObject:@"30"];
    
    for(int i=0; i<[_location count]; i++){
        _subtext[i] = [NSString stringWithFormat:@"%@'C(20'C/29'C), 강수확률 : %@, 미세먼지 : 나쁨",_temperature[i],_rainProbability[i]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger tableHeight;
    tableHeight = [_location count]*80;
    
    if(tableHeight > 495){
        tableHeight = 495;
    }
    
    tableView.frame = CGRectMake(9, 128, 357, tableHeight);
    tableView.backgroundColor = [UIColor clearColor];
    [tableView setRowHeight:100];
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
    
    UIImage *imagetest = [UIImage imageNamed:@"backbutton1.png"];
    cell.imageView.image = imagetest;
    
    cell.textLabel.text =  self.location[indexPath.row];
    cell.detailTextLabel.text = self.subtext[indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:20.0];
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
    [self deleteLocation:_location[deleteNum]];
    
    for(int i = deleteNum ; i<arraySize-1 ; i++){
        _location[i] = _location[i+1];
        _subtext[i] = _subtext[i+1];
    }
    
    [_location removeObjectAtIndex:arraySize-1];
    [_subtext removeObjectAtIndex:arraySize-1];
    
    [tableView reloadData];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void) deleteLocation:(id) sender{
    
}

@end
