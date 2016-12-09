//
//  SecondViewController.h
//  ITMessage
//
//  Created by RogerRoan on 2016/4/21.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ECSlidingViewController.h"
#import "AppDelegate.h"
#import "Util.h"
#import "PhoneViewController.h"
@interface SecondViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchBarDelegate,UISearchDisplayDelegate,delegateRestStatus>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak,nonatomic)UISearchBar * searchbar;

@property (nonatomic,strong) UISearchController *searchcontroller;
-(void) CallMember:(Member *)member;
@end
