//
//  ThirdViewController.h
//  ITMessage
//
//  Created by RogerRoan on 2016/4/22.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Util.h"
#import "UIViewController+ECSlidingViewController.h"
@interface ThirdViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,delegateTableViewDo>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(strong,nonatomic) NSMutableArray *msg_list;
@property(strong,nonatomic) UIRefreshControl *refreshControl;
@property(strong,nonatomic) AppDelegate *app;
@end
