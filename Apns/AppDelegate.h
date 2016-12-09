//
//  AppDelegate.h
//  Apns
//
//  Created by RogerRoan on 2016/4/18.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "UIViewController+ECSlidingViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "FirstViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property id<delegateTableViewDo> delegate;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) ECSlidingViewController *slidingViewController;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic,strong) DataBase *db;
@property (nonatomic,strong) NSString *reg_id;
@property (nonatomic,strong) NSString *user_id;
@property (nonatomic,strong) NSString *user_name;
-(void) GetMessage:(NSDictionary *) userInfo andCallBack:(void(^)(void)) dosomething;
-(void) GetMessage:(NSDictionary *) userInfo;
//-(void) HttpCallBackIdCloud:(NSInteger *) id_cloud;
-(void) insertMessage:(NSString *)id_cloud_msg andMsg:(NSString *)msg andCreateDate:(NSString *) dt_create;
@end
