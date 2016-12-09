//
//  AppDelegate.m
//  Apns
//
//  Created by RogerRoan on 2016/4/18.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property(assign,nonatomic) int bagenumber;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //NSLog(@"Launching");
    
    int cacheSizeMemory = 4*1024*1024; // 4MB
    int cacheSizeDisk = 32*1024*1024; // 32MB
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"];
    
    [NSURLCache setSharedURLCache:sharedCache];
    
    UIMutableUserNotificationAction *action=[UIMutableUserNotificationAction new];
    action.identifier=@"ACTIONNotify";
    action.title=@"Notify";
    action.activationMode=UIUserNotificationActivationModeForeground;
    action.authenticationRequired=YES;
    action.destructive=YES;
    
    UIMutableUserNotificationCategory *category=[UIMutableUserNotificationCategory new];
    category.identifier=@"Category1";
    [category setActions:@[action] forContext:UIUserNotificationActionContextDefault];
    NSSet *set=[NSSet setWithObject:category];
    
    UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge categories:set];
    

    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    
    
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];

    
    self.bagenumber=0;
    
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    
    /*
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIStoryboard *storybord=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *topViewController=[storybord instantiateViewControllerWithIdentifier:@"third"];
    
    UIViewController *underLeftViewController=[storybord instantiateViewControllerWithIdentifier:@"menu"];
    
    // configure top view controller
    UIBarButtonItem *anchorRightButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(anchorRight)];
    
    topViewController.navigationItem.title = @"公佈欄";
    
    topViewController.navigationItem.leftBarButtonItem  = anchorRightButton;
   
    _navigationController = [[UINavigationController alloc] initWithRootViewController:topViewController];
    
      // configure sliding view controller
    self.slidingViewController = [ECSlidingViewController slidingWithTopViewController:_navigationController];
    
    self.slidingViewController.underLeftViewController  = underLeftViewController;
 
    // enable swiping on the top view
    [_navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    // configure anchored layout
    self.slidingViewController.anchorRightPeekAmount  = 100.0;
    self.slidingViewController.anchorLeftRevealAmount = 250.0;
    self.window.rootViewController = self.slidingViewController;
    */
        
   
    UIBarButtonItem *anchorRightButton = [UIBarButtonItem GenerateButton:@selector(anchorRight) andSender:self];
  
    /*
    UIBarButtonItem *anchorRightButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(anchorback)];
    */
    
    self.slidingViewController=[Util FactoryECSliderViewController:@"menu" andContent:@"first" andTitle:@"公佈欄" andBarButton:anchorRightButton];
    
    self.window.rootViewController = self.slidingViewController;
    
    //[self.window.rootViewController presentViewController:self.slidingViewController animated:YES completion:^{
        
    //}];
    
    //[self.view.window.rootViewController presentViewController:picker animated:NO completion:nil]
    
    [self.window makeKeyAndVisible];
    
    if (self.db != nil)
    {
        self.db=nil;
    }
    self.db=[[DataBase alloc] initDataBase];
    
    [self.db refreshMsgData];
    

    //[Util ChangeLayout:anchorRightButton andName:@"third" andTitle:@"test" andEcsliderController:self.slidingViewController];
    // Override point for customization after application launch.
    return YES;
}



-(void) anchorback
{
   
    NSLog(@"anchorback");
    self.slidingViewController.topViewController.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
    [self.slidingViewController resetTopViewAnimated:YES];
    
}

- (void)anchorRight {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
    //NSLog(@"Right");
}

- (void)anchorLeft {
    [self.slidingViewController anchorTopViewToLeftAnimated:YES];
    
    //NSLog(@"lEFT");
}


-(void) PopMessage:(NSString *)msg
{
    UIAlertController *cot;
    
    cot=[UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    
    [self.slidingViewController.topViewController presentViewController :cot animated:YES completion:^{
        
        int duration = 5; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            [cot dismissViewControllerAnimated:YES completion:^{
                
            }];
            //[toast dismissWithClickedButtonIndex:0 animated:YES];
        });
    }];
}



-(void) GetMessage:(NSDictionary *) userInfo andCallBack:(void(^)(void)) dosomething
{
   
    [self GetMessage:userInfo];
    
    NSString *str_cloud=(userInfo[@"aps"])[@"id_cloud"];
    
    NSNumberFormatter *f=[[NSNumberFormatter alloc] init];
    f.numberStyle=NSNumberFormatterDecimalStyle;
    NSNumber *number=[f numberFromString:str_cloud];
    
    [Util HttpCallBackIdCloud:number.integerValue];
    //[self HttpCallBackIdCloud:number.integerValue];
    
    
}


-(void) GetMessage:(NSDictionary *) userInfo
{

   // NSLog(@"1=>%@",(userInfo[@"aps"])[@"id_cloud"]);
    
    NSDictionary *dictionary = userInfo[@"aps"];
    
    NSString *base64content=[Util Base64Decoding:dictionary[@"message"]];
    
    //NSLog(@"%@",base64content);
    //
    /*
    UILocalNotification *ln=[UILocalNotification new];
    
    ln.alertBody=base64content;
    ln.soundName=UILocalNotificationDefaultSoundName;
    ln.applicationIconBadgeNumber=1;
    ln.fireDate=[NSDate dateWithTimeIntervalSinceNow:1.0];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:ln];
    */
    
    /*
    NSNumberFormatter *f=[[NSNumberFormatter alloc] init];
    
    f.numberStyle=NSNumberFormatterDecimalStyle;
    
    NSNumber *ll_id_cloud=[f numberFromString:dictionary[@"id_cloud"]];
    
    ///避免重複
    if(![self.db searchCloudId:ll_id_cloud])
    {
       [self.db insertMsgData:@"" andContent:base64content andDate:dictionary[@"dt_create"] andCloudid:ll_id_cloud.integerValue];
    }*/
    [self insertMessage:dictionary[@"id_cloud"] andMsg:base64content andCreateDate:dictionary[@"dt_create"]];
    
    self.bagenumber++;
    
    [UIApplication sharedApplication].applicationIconBadgeNumber=self.bagenumber;
}


-(void) insertMessage:(NSString *)id_cloud_msg andMsg:(NSString *)msg andCreateDate:(NSString *) dt_create
{
    
    NSNumber *ll_id_cloud=[Util StringToInterger:id_cloud_msg];
    if(![self.db searchCloudId:ll_id_cloud])
    {
        [self.db insertMsgData:@"" andContent:msg andDate:dt_create andCloudid:ll_id_cloud.integerValue];
    }

}






- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        NSLog(@"didRegisterUser");
        [application registerForRemoteNotifications];
    }
}




-(void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    
    
    
    if(application.applicationState == UIApplicationStateInactive) {
        
        [self GetMessage:userInfo andCallBack:^{
            
        }];
        
        /*
        UIBarButtonItem *anchorRightButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(anchorRight)];
        */
        UIBarButtonItem *anchorRightButton = [UIBarButtonItem GenerateButton:@selector(anchorRight) andSender:self];
        
        self.slidingViewController=[Util FactoryECSliderViewController:@"menu" andContent:@"third" andTitle:@"公佈欄" andBarButton:anchorRightButton];
        
        self.window.rootViewController = self.slidingViewController;
        
        
        completionHandler(UIBackgroundFetchResultNewData);
        
    } else if (application.applicationState == UIApplicationStateBackground) {
        
        [self GetMessage:userInfo andCallBack:^{
            
        }];
        
        
        UIBarButtonItem *anchorRightButton = [UIBarButtonItem GenerateButton:@selector(anchorRight) andSender:self];
        
        self.slidingViewController=[Util FactoryECSliderViewController:@"menu" andContent:@"third" andTitle:@"公佈欄" andBarButton:anchorRightButton];
        
        self.window.rootViewController = self.slidingViewController;
        
        
        
        //[self performSelector:@selector(GetMessage:) withObject:(NSDictionary *)userInfo];
        
        //Refresh the local model
        
        completionHandler(UIBackgroundFetchResultNewData);
        
    } else {
        
        [self GetMessage:userInfo andCallBack:^{
        
        }];
        
        NSString *base64content=(userInfo[@"aps"])[@"message"];

        base64content=[Util Base64Decoding:base64content];
        
        base64content=[NSString stringWithFormat:@"您收到一封簡訊:\n%@",base64content];
        
        //base64content=[Util Base64Decoding:base64content];
        
        [self performSelector:@selector(PopMessage:) withObject:(NSString *) base64content];
        
        
        //http://iphonedevwiki.net/index.php/AudioServices
        SystemSoundID soundId=1007;
        
        AudioServicesPlaySystemSound(soundId);
        
        
        [self.delegate RefreshTable];

        
        /*
        [self performSelector:@selector(GetMessage:) withObject:(NSDictionary *)userInfo];
        
        
        base64content=[NSString stringWithFormat:@"您收到一封簡訊:\n%@",base64content];
        
        //http://iphonedevwiki.net/index.php/AudioServices
        SystemSoundID soundId=1007;

        AudioServicesPlaySystemSound(soundId);
        
        [self performSelector:@selector(PopMessage:) withObject:(NSString *) base64content];
        
        [self.delegate RefreshTable];
        
        NSLog(@"Active");
        */
        
        completionHandler(UIBackgroundFetchResultNewData);
    }
}



-(void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    //_reg_id=deviceToken;
    
     NSString *reg_id=[[[deviceToken.description stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [self.db updateUserInfo:reg_id];
    
    [self.db selectUserInfo];
    
    self.reg_id=reg_id;
    
    NSLog(@"receive deviceTokan %@",reg_id);
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Remote notification error:%@", [error localizedDescription]);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    //NSLog(@"foreground");
    
    self.bagenumber=0;
    
    [UIApplication sharedApplication].applicationIconBadgeNumber=self.bagenumber;
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
    NSLog(@"app receivememory");
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
