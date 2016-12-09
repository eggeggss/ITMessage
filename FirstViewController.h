//
//  FirstViewController.h
//  ITMessage
//
//  Created by RogerRoan on 2016/4/20.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ECSlidingViewController.h"
#import "AppDelegate.h"
#import "Util.h"
@interface FirstViewController : UIViewController
{
    NSTimer *timer;
    NSArray *magee_list;
    NSInteger magee_index;
}
@property (weak, nonatomic) IBOutlet UITextView *lb;
@property (weak,nonatomic) NSString *idd;
@property (weak, nonatomic) IBOutlet UILabel *marquee;

//@property (strong,nonatomic) UILabel *marquee;
@end
