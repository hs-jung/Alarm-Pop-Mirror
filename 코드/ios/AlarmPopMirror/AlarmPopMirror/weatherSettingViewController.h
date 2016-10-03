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

@end
