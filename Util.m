//
//  Util.m
//  ITMessage
//
//  Created by RogerRoan on 2016/4/23.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import "Util.h"

@implementation MyUIBarButtonItem

+(MyUIBarButtonItem *) GenerateMyButton:(SEL)selector andSender:(id) sender
{
    
    UIImage *image=[UIImage imageNamed:@"menu.png"];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    /*
    [btn addTarget:sender action:selector forControlEvents:UIControlEventTouchUpInside];
    */
    btn.bounds=CGRectMake(0, 0, image.size.width, image.size.height);
    [btn setImage:image forState:UIControlStateNormal];
    
    MyUIBarButtonItem *anchor=[[MyUIBarButtonItem alloc] initWithCustomView:btn];
    
    anchor.target=sender;
    anchor.action=selector;
    
    return anchor;
}
@end

@implementation UIBarButtonItem(extention)
+(UIBarButtonItem *) GenerateButton:(SEL)selector andSender:(id)sender
{
    
    UIImage *image=[UIImage imageNamed:@"menu.png"];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:sender action:selector forControlEvents:UIControlEventTouchUpInside];
    
    btn.bounds=CGRectMake(0, 0, image.size.width, image.size.height);
    [btn setImage:image forState:UIControlStateNormal];
    
    UIBarButtonItem *anchor=[[UIBarButtonItem alloc] initWithCustomView:btn];

    //anchor.target=sender;
    //anchor.action=selector;
    return anchor;
    
    /*
     UIBarButtonItem *anchorRightButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:selector];
    
    return anchorRightButton;
    */
}

@end


@implementation Util

+(NSString *)Pattern:(NSString *)input
{
    input=[input stringByReplacingOccurrencesOfString:@"0" withString:@"00"];
    
    input=[input stringByReplacingOccurrencesOfString:@"+" withString:@"01"];
    
    input=[input stringByReplacingOccurrencesOfString:@"/" withString:@"02"];
    
    input=[input stringByReplacingOccurrencesOfString:@"=" withString:@"03"];
    
    return input;
}

+(NSString *)Depattern:(NSString *)input
{
    input=[input stringByReplacingOccurrencesOfString:@"00" withString:@"0"];
    
    input=[input stringByReplacingOccurrencesOfString:@"01" withString:@"+"];
    
    input=[input stringByReplacingOccurrencesOfString:@"02" withString:@"/"];
    
    input=[input stringByReplacingOccurrencesOfString:@"03" withString:@"="];
    
    return input;
}

+(NSString *)Base64Decoding:(NSString *) input
{
    
    input=[self Depattern:input];
    
    NSData *data=[[NSData alloc] initWithBase64EncodedString:input options:0];
    
    NSString *result=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return result;
}

+(NSString *)Base64Encoding:(NSString *)input
{
    NSData *plainData=[input dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String=[plainData base64EncodedStringWithOptions:0];
    
    base64String=[self Pattern:base64String];
    return base64String;
    
}

+(NSNumber *) StringToInterger:(NSString *) str
{
    NSString *str2=[NSString stringWithFormat:@"%@",str];
    
    NSNumberFormatter *f=[[NSNumberFormatter alloc] init];
    f.numberStyle=NSNumberFormatterDecimalStyle;
    NSNumber *ll_id_cloud=[f numberFromString:str2];
    
    return ll_id_cloud;
}

+(void) HttpReturnUnReadMessage:(NSString *) userId completion:(void (^)(NSString *)) completion
{
    
    userId=[self Base64Encoding:userId];
    NSString *body=[NSString stringWithFormat:@"catelog=%@&content=%@",@"GetApnsUReadItem",userId];
    
    NSURLSessionConfiguration  *conf=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *s1=[NSURLSession sessionWithConfiguration:conf];
    
    NSURL *urlst=[NSURL URLWithString:@"http://eggeggss.ddns.net/sse/Request.aspx"];
    
    
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:urlst cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    
    NSData *post_body=[body dataUsingEncoding:NSUTF8StringEncoding];
    
    req.HTTPBody=post_body;
    req.HTTPMethod=@"post";
    
    
    NSURLSessionDataTask *ts=[s1 dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *s=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        s=[Util Base64Decoding:s];
        
        completion(s);
        //NSLog(@"%@",s);
        //Done
        
    }];
    
    [ts resume];
    
}

+(void) HttpReturnUserInfor:(UserInforObject *) obj
{
    NSString *user_id=obj.user_id;
    NSString *user_name=obj.user_name;
    NSString *reg_id=obj.reg_id;
    
    NSString *body=[NSString stringWithFormat:@"catelog=%@&user_id=%@&user_name=%@&reg_id=%@&type=APNS",@"C",user_id,user_name,reg_id];
    
    NSURLSessionConfiguration  *conf=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *s1=[NSURLSession sessionWithConfiguration:conf];
    
    NSURL *urlst=[NSURL URLWithString:@"http://eggeggss.ddns.net/sse/Recv.aspx"];
    
    
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:urlst cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    
    NSData *post_body=[body dataUsingEncoding:NSUTF8StringEncoding];
    
    req.HTTPBody=post_body;
    req.HTTPMethod=@"post";
    
    NSURLSessionDataTask *ts=[s1 dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *s=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",s);
        //Done
        
    }];
    
    [ts resume];
}

+(void) HttpCallBackIdCloud:(NSInteger*)  id_cloud
{
    
    NSString *body=[NSString stringWithFormat:@"catelog=%@&id_cloud_msg=%i",@"A",id_cloud];
    
    NSURLSessionConfiguration  *conf=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *s1=[NSURLSession sessionWithConfiguration:conf];
    
    NSURL *urlst=[NSURL URLWithString:@"http://eggeggss.ddns.net/sse/Recv.aspx"];
    
    //http://eggeggss.ddns.net/sse/Recv.aspx?catelog=A&id_cloud_msg=37
    
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:urlst cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    
    NSData *post_body=[body dataUsingEncoding:NSUTF8StringEncoding];
    
    req.HTTPBody=post_body;
    req.HTTPMethod=@"post";
    
    NSURLSessionDataTask *ts=[s1 dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *s=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",s);
        //Done
        
    }];
    
    [ts resume];
}
+(ECSlidingViewController *)FactoryECSliderViewController:(NSString *)Menu andContent:(NSString *) Content andTitle:(NSString *)title andBarButton:(UIBarButtonItem *) anchorRightButton
{
    
    UIStoryboard *storybord=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *topViewController=[storybord instantiateViewControllerWithIdentifier:Content];
    
    UIViewController *underLeftViewController=[storybord instantiateViewControllerWithIdentifier:Menu];
    
    // configure top view controller
    
    topViewController.navigationItem.title = title;
    
    
    
    topViewController.navigationItem.leftBarButtonItem  = anchorRightButton;
    
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:topViewController];
    
    UIColor *color=[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1];
    
    navigationController.navigationBar.barTintColor = color;

    // configure sliding view controller
    ECSlidingViewController *sliderController = [ECSlidingViewController slidingWithTopViewController:navigationController];
    
    sliderController.underLeftViewController  = underLeftViewController;
    
    // enable swiping on the top view
    [navigationController.view addGestureRecognizer:sliderController.panGesture];
    
    // configure anchored layout
    sliderController.anchorRightPeekAmount  = 100.0;
    sliderController.anchorLeftRevealAmount = 250.0;

    return sliderController;
}
+(void) ChangeLayout:(UIBarButtonItem *)anchorRightButton andName:(NSString *) storyid andTitle:(NSString *) chname andEcsliderController:(ECSlidingViewController *) ecsliderController
{
    UIStoryboard *storybord=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *newcontroller=[storybord instantiateViewControllerWithIdentifier:storyid];
    
    //newcontroller.title=obj.chname;
    
    newcontroller.navigationItem.title = chname;
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newcontroller];
    
    UIColor *color=[UIColor colorWithRed:54/255.0 green:48/255.0 blue:48/255.0 alpha:1];
    
    navigationController.navigationBar.barTintColor = color;
    
    // enable swiping on the top view
    [navigationController.view addGestureRecognizer:ecsliderController.panGesture];
    
    // configure anchored layout
    ecsliderController.anchorRightPeekAmount  = 100.0;
    ecsliderController.anchorLeftRevealAmount = 250.0;
    
    CGRect rect=ecsliderController.topViewController.view.frame;
    
    ecsliderController.topViewController=navigationController;
    
    ecsliderController.topViewController.view.frame=rect;
    
    [ecsliderController resetTopViewAnimated:YES];
}

+(NSString *) DeviceModel {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *model = malloc(size);
    sysctlbyname("hw.machine", model, &size, NULL, 0);
    NSString *deviceModel = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
    free(model);
    
    return deviceModel;
}
+(CGSize) GetScreenSize
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    /* 分解動作是這樣：
     CGRect screenBound = [[UIScreen mainScreen] bounds];
     CGSize screenSize = screenBound.size;
     */
    return screenSize;
}

@end


@implementation DataBase

-(instancetype) initDataBase
{
    [self createMsgDb];
    [self createMsgTable];
    [self createUserInfoTable];
    
    self.msg_list=[[NSMutableArray alloc] init];
    
    return  self;
}

-(void)createMsgDb
{
    NSString *dbph=[NSString stringWithFormat:@"%@/Documents/msgdb.db",NSHomeDirectory()];
    
    if (sqlite3_open([dbph UTF8String], &msgdb)==SQLITE_OK)
    {
        NSLog(@"create dbok");
    }
}

//roger 20160531 create infotable
-(void) createUserInfoTable
{
     const char *sql="create table if not exists userinfo (id integer primary key autoincrement, user_id text , user_name text ,reg_id text)";
    
    char *err;
    
    if(sqlite3_exec(msgdb, sql, NULL, NULL, &err)==SQLITE_OK)
    {
        NSLog(@"create userinfo table ok");
    }
}

-(BOOL)findUserInfo
{
    /*
    NSInteger row;
    
    NSString *sqlst=@"select count(*) from userinfo";
    
    NSData *data= [sqlst dataUsingEncoding:NSUTF8StringEncoding];
    
    const char *sql= [data bytes];
    
    sqlite3_stmt *stmt;
    
    if (sqlite3_prepare(msgdb, sql , -1, &stmt, NULL)==SQLITE_OK)
    {
        while (sqlite3_step(stmt)==SQLITE_ROW)
        {
            row=sqlite3_column_int(stmt, 0);
            
            //NSLog(@"row => %i",i);
        }
    }
    
    sqlite3_finalize(stmt);
    */
    
    [self selectUserInfo];
    
    if(self.userobj.user_id==nil || [self.userobj.user_id isEqualToString:@""])
    {
        return NO;
    }else
    {
        return YES;
    }
    
    
    //return (row>=1)? YES:NO;
}

-(void)insertUserInfo:(NSString *) user_id andUserName:(NSString *)user_name
{
    char *err;
    
    if (user_id==nil || [user_id isEqualToString:@""])
    {
        return;
    }
    
    NSString *sql2=[NSString stringWithFormat:@"insert into userinfo (user_id, user_name) values('%@','%@');",user_id,user_name];
    
    NSData *data=[sql2 dataUsingEncoding:NSUTF8StringEncoding];
    
    const char *sql=[data bytes];
    
    if(sqlite3_exec(msgdb, sql, NULL, NULL, &err)==SQLITE_OK)
    {
        NSLog(@"insert userinfo table ok");
    }
    else
    {
        NSLog(@"insert userinfo error %s",err);
    }
}

-(void)updateUserInfo:(NSString *) reg_id
{
    char *err;
    
    if(reg_id ==nil || [reg_id isEqualToString:@""])
    {
        return;
    }
    
    NSString *sql2=[NSString stringWithFormat:@"update userinfo set reg_id='%@';",reg_id];
    
    //NSData *data=[sql2 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data=[sql2 dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    const char *sql=[data bytes];
    
    if(sqlite3_exec(msgdb, sql, NULL, NULL, &err)==SQLITE_OK)
    {
        NSLog(@"update userinfo table ok");
    }
    else
    {
        NSLog(@"update userinfo error %s",err);
    }
}

-(void)selectUserInfo
{
    NSString *id_1,*user_id,*user_name,*reg_id;
    const char *sql="select * from userinfo order by id desc";
    
    sqlite3_stmt *stmt;
    
    [self.msg_list removeAllObjects];
    
    if( sqlite3_prepare(msgdb, sql, -1, &stmt, NULL)==SQLITE_OK)
    {
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            
            id_1=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
            
            user_id=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
            
            user_name=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
            
            const char *reg_temp=(char *)sqlite3_column_text(stmt, 3);
            
            if (reg_temp==nil)
            {
                NSLog(@"no reg_id");
            }
            else
            {
               reg_id=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
            }
            
            //reg_id=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
            
            self.userobj=nil;
            self.userobj=[[UserInforObject alloc] init];
            
            self.userobj.user_id=user_id;
            self.userobj.user_name=user_name;
            self.userobj.reg_id=reg_id;
            
            if (user_id !=nil && [user_id isEqualToString:@""]==NO)
            {
                if (reg_id !=nil&& [reg_id isEqualToString:@""]==NO)
                {
                    //test
                    [Util HttpReturnUserInfor:self.userobj];
                }
            }
            
            //NSLog(@"selectUserInfo user_id=> %@ , user_name=> %@ , reg_id=>%@",user_id,user_name,reg_id);
            
        }
        
        sqlite3_finalize(stmt);
    }
}



-(void) createMsgTable
{
    const char *sql="create table if not exists msg (id integer primary key autoincrement, name text , content text ,dt_create text, stat_update integer ,stat_read integer ,id_cloud_msg integer)";
    
    char *err;
    
    if(sqlite3_exec(msgdb, sql, NULL, NULL, &err)==SQLITE_OK)
    {
        //NSLog(@"create table ok");
    }
}


-(void)insertMsgData:(NSString *) name andContent:(NSString *) content andDate:(NSString *)date andCloudid:(NSInteger) id_cloud_msg
{
    char *err;
    
    NSString *sql2=[NSString stringWithFormat:@"insert into msg (name, content, dt_create, stat_update,stat_read,id_cloud_msg) values('%@','%@','%@',%i,%i,%li);",name,content,date,0,0,(long)id_cloud_msg];
    
    NSData *data=[sql2 dataUsingEncoding:NSUTF8StringEncoding];
    
    const char *sql=[data bytes];
    
    if(sqlite3_exec(msgdb, sql, NULL, NULL, &err)==SQLITE_OK)
    {
        NSLog(@"insert table ok");
    }
    else
    {
        NSLog(@"insert error %s",err);
    }
}



-(BOOL) searchCloudId:(NSNumber *) id_cloud_msg
{
    NSInteger row;
    
    NSString *sqlst=[NSString stringWithFormat:@"select count(*) from msg where id_cloud_msg=%li;", (long)[id_cloud_msg integerValue]];
    
    NSData *data= [sqlst dataUsingEncoding:NSUTF8StringEncoding];
    
    const char *sql= [data bytes];
    
    sqlite3_stmt *stmt;
    
    if (sqlite3_prepare(msgdb, sql , -1, &stmt, NULL)==SQLITE_OK)
    {
        while (sqlite3_step(stmt)==SQLITE_ROW)
        {
            row=sqlite3_column_int(stmt, 0);
            
            //NSLog(@"row => %i",i);
        }
    }
    
    sqlite3_finalize(stmt);
    
    return (row>=1)? YES:NO;
};


-(void) refreshMsgData
{
    NSString *name,*content,*dt_create,*stat_read,*id_1;
    NSString *id_cloud_msg;
    const char *sql="select * from msg order by id desc";
    
    sqlite3_stmt *stmt;
    
    [self.msg_list removeAllObjects];
    
    if( sqlite3_prepare(msgdb, sql, -1, &stmt, NULL)==SQLITE_OK)
    {
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            
            id_1=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
            
            name=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
            content=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
            dt_create=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
            
            stat_read=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)];
            
            id_cloud_msg=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)];
            
            MessageObject *msgobj=[[MessageObject alloc] init];
            
            msgobj.content=content;
            msgobj.dt_create=dt_create;
            msgobj.stat_read=stat_read;
            msgobj.id_cloud_msg=id_cloud_msg;
            
            
           // NSLog(@"%@=> %@",content,id_cloud_msg);
            
            [self.msg_list addObject:msgobj];
            
        }
        
        sqlite3_finalize(stmt);
    }
    
}



@end



@implementation MessageObject


@end



@implementation MemberGroup

-(instancetype) initwithgroupname:(NSString *) group_name
{
    _group_name=group_name;
    
    _member_list=[NSMutableArray new];
    
    return self;
}

@end

@implementation Member

-(instancetype) initwithid:(NSString *) user_id andname:(NSString *) user_name andphone:(NSString *) phone andimage:(NSString *)image{
    
    _user_id=user_id;
    _user_name=user_name;
    _phone_number=phone;
    _image=image;
    
    
    return self;
}

@end

@implementation RoomGroup


@end



@implementation MyRoom
-(instancetype) initobjectX:(CGFloat) x andY:(CGFloat) y
{
    _point=CGPointMake(x, y);
    _rect=CGRectMake(x, y, 20, 20);
    
    return self;
}
@end

@implementation UserInforObject

@end



