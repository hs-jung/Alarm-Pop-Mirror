//
//  weatherSettingViewController.h
//  AlarmPopMirror
//
//  Created by 송산하 on 2016. 8. 23..
//  Copyright © 2016년 송산하. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainViewController.h"

@interface weatherSettingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *tableView;
    UIDatePicker *datePicker;
}

@property (copy, nonatomic) NSMutableArray *location;
@property (copy, nonatomic) NSMutableArray *skyName;
@property (copy, nonatomic) NSMutableArray *skyCode;
@property (copy, nonatomic) NSMutableArray *tc;
@property (copy, nonatomic) NSMutableArray *tmax;
@property (copy, nonatomic) NSMutableArray *tmin;
@property (copy, nonatomic) NSMutableArray *subtext;


@end
