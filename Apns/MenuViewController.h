//
//  ViewController.h
//  Apns
//
//  Created by RogerRoan on 2016/4/18.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ECSlidingViewController.h"
#import "AppDelegate.h"
#import "SecondViewController.h"
@interface MenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property id<delegateTableViewDo> delegate;
@property id<delegateRestStatus> delegateReset;

@end

@interface SectionObj:NSObject
@property(weak,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *storyid;
@property(strong,nonatomic) NSString *chname;
@property(strong,nonatomic) UIImage *img;
@end
