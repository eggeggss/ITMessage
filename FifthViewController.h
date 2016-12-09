//
//  FifthViewController.h
//  ITMessage
//
//  Created by RogerRoan on 2016/4/22.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ECSlidingViewController.h"
#import "Util.h"
#import "AppDelegate.h"
@interface FifthViewController : UIViewController <UIWebViewDelegate>
@property (strong,nonatomic)    NSTimer *timer;

@property (strong,nonatomic) UIView *alert;
@property (strong,nonatomic) UIProgressView *progress;


@property (weak, nonatomic) IBOutlet UIWebView *wv;
@property (strong,nonatomic) DataBase *db;
@end
