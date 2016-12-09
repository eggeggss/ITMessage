//
//  ForthViewController.h
//  ITMessage
//
//  Created by RogerRoan on 2016/4/22.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ECSlidingViewController.h"
#import "Util.h"
#import "RoomView.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
@interface ForthViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickview;
@property(strong,nonatomic) NSMutableArray *group_list;
@property (weak, nonatomic) IBOutlet RoomView *roomView;
//@property (strong,nonatomic) UILabel *closerview1;
//@property (strong,nonatomic) UILabel *closerview2;


@property (strong,nonatomic)    CLLocationManager *locmanager;
@property (strong,nonatomic) CLBeaconRegion *gbean;
@property (strong,nonatomic) CLBeacon *clbean;

@end
