//
//  RoomView.h
//  ITMessage
//
//  Created by RogerRoan on 2016/5/16.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
@interface RoomView : UIView
{
    BOOL b_init;
    CGContextRef context ;
    NSTimer *mytimer;
    
}
@property (nonatomic,strong) UIImage *img;
@property  CGRect *myframe;
@property  CGFloat g_width;//螢幕寬度
@property  CGFloat g_height;
@property NSTimer *timer;
@property (strong,nonatomic) MyRoom *myroom;
@property (assign,nonatomic) CGFloat greencolor;
-(void) initObj:(CGRect) rect;
-(void) changeImage:(UIImage *) img;
-(void) changePoint:(MyRoom *) room;

@end
