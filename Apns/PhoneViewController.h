//
//  PhoneViewController.h
//  ITMessage
//
//  Created by RogerRoan on 2016/6/8.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "MessageUI/MessageUI.h"
@interface PhoneViewController : UIViewController<MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lb_userName;
@property (weak, nonatomic) IBOutlet UIButton *btn_Phone;

@property (weak, nonatomic) IBOutlet UIButton *btn_Sms;
@property (weak, nonatomic) IBOutlet UILabel *lb_phoneno;

@property(strong,nonatomic) Member *member;
-(void)ResizeToolBar :(UIInterfaceOrientation)toInterfaceOrientation;
@end
