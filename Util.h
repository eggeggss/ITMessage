//
//  Util.h
//  ITMessage
//
//  Created by RogerRoan on 2016/4/23.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import <sys/types.h>
#import <sys/sysctl.h>
#import "UIViewController+ECSlidingViewController.h"
@class MessageObject;
@class UserInforObject;



@protocol delegateTableViewDo
-(void) RefreshTable;

@end

@protocol delegateRestStatus

-(void) Reset;
@end



@interface MyUIBarButtonItem:UIBarButtonItem
@property (nonatomic, readwrite, retain) id userData;
+(MyUIBarButtonItem *) GenerateMyButton:(SEL)selector andSender:(id) sender;
@end

@interface UIBarButtonItem(extention)
+(UIBarButtonItem *) GenerateButton:(SEL)selector andSender:(id) sender;
@end

@interface Util : NSObject

+(NSString *)Pattern:(NSString *)input;
+(NSString *)Depattern:(NSString *)input;
+(NSString *)Base64Decoding:(NSString *) input;
+(NSString *)Base64Encoding:(NSString *) input;
+(NSNumber *) StringToInterger:(NSString *) str;
+(void) HttpReturnUserInfor:(UserInforObject *) obj;
+(void) HttpReturnUnReadMessage:(NSString *) userId completion:(void (^)(NSString *)) completion;
+(void) HttpCallBackIdCloud:(NSInteger*)  id_cloud;
+(ECSlidingViewController *)FactoryECSliderViewController:(NSString *)Menu andContent:(NSString *) Content andTitle:(NSString *)title andBarButton:(UIBarButtonItem *) anchorRightButton;
+(void) ChangeLayout:(UIBarButtonItem *)anchorRightButton andName:(NSString *) storyid andTitle:(NSString *) chname andEcsliderController:(ECSlidingViewController *) ecsliderController;

+(NSString *) DeviceModel;
+(CGSize) GetScreenSize;
@end

@interface DataBase : NSObject 
{
    sqlite3 * msgdb;
}
-(instancetype)initDataBase;
@property(strong,nonatomic) UserInforObject *userobj;
@property(strong,nonatomic) NSMutableArray *msg_list;
-(void)createMsgDb;
-(void)createMsgTable;
-(void)createUserInfoTable;
-(BOOL) searchCloudId:(NSNumber *) id_cloud_msg;
-(void)insertMsgData:(NSString *) name andContent:(NSString *) content andDate:(NSString *) date andCloudid:(NSInteger) id_cloud_msg;
-(void)refreshMsgData;

-(void)insertUserInfo:(NSString *) user_id andUserName:(NSString *)user_name;

-(void)updateUserInfo:(NSString *) reg_id;
-(BOOL)findUserInfo;
-(void)selectUserInfo;
@end

@interface MessageObject : NSObject

@property(strong,nonatomic) NSString *content;
@property(strong,nonatomic) NSString *dt_create;
@property(strong,nonatomic) NSString *stat_read;
@property(strong,nonatomic) NSString *id_cloud_msg;

@end


@interface MemberGroup : NSObject
-(instancetype) initwithgroupname:(NSString *) group_name;
@property (nonatomic,strong) NSString *group_name;
@property (nonatomic,retain) NSMutableArray *member_list;
@end

@interface Member:NSObject
-(instancetype) initwithid:(NSString *) user_id andname:(NSString *) user_name andphone:(NSString *) phone andimage:(NSString *)image;
@property (nonatomic,strong) NSString *user_id;
@property (nonatomic,strong) NSString *user_name;
@property (nonatomic,strong) NSString *phone_number;
@property (nonatomic,strong) NSString *image;

@end

@class MyRoom;
@interface RoomGroup : NSObject
@property(strong,nonatomic) NSString *GroupName;
@property(strong,nonatomic) NSMutableArray<MyRoom *> *RoomList;

@end

@interface MyRoom :NSObject

@property (strong,nonatomic) NSString *RoomName;
@property (assign,nonatomic) CGPoint point;
@property (assign,nonatomic)CGRect rect;
@property (strong,nonatomic) UIColor *color;
-(instancetype) initobjectX:(CGFloat) x andY:(CGFloat) y;
@end

@interface UserInforObject:NSObject
@property (strong,nonatomic) NSString *user_id;
@property (strong,nonatomic) NSString *user_name;
@property (strong,nonatomic) NSString *reg_id;
@end


