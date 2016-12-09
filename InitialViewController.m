//
//  InitialViewController.m
//  ITMessage
//
//  Created by RogerRoan on 2016/4/20.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import "InitialViewController.h"

@interface InitialViewController ()
@property (nonatomic, strong) ECSlidingViewController *slidingViewController;
@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UIViewController *controller=[[self storyboard] instantiateViewControllerWithIdentifier:@"menu"];
    
    UIBarButtonItem *anchorRightButton = [[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStylePlain target:self action:@selector(anchorRight)];
    UIBarButtonItem *anchorLeftButton  = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStylePlain target:self action:@selector(anchorLeft)];
    
    self.navigationItem.title = @"Layout Demo";
    self.navigationItem.leftBarButtonItem  = anchorRightButton;
    
    self.view.backgroundColor = [UIColor blueColor];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self];
    
    self.slidingViewController = [ECSlidingViewController slidingWithTopViewController:navigationController];
    //self.slidingViewController.underLeftViewController  = underLeftViewController;
    
    // enable swiping on the top view
    [navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    // configure anchored layout
    self.slidingViewController.anchorRightPeekAmount  = 100.0;
    self.slidingViewController.anchorLeftRevealAmount = 250.0;
    
    AppDelegate *app=[UIApplication sharedApplication].delegate;
    
    app.window.window.rootViewController=self.slidingViewController;
    
    [app.window makeKeyAndVisible];
    //self.window.rootViewController = self.slidingViewController;
    
    //[self.window makeKeyAndVisible];

    // Do any additional setup after loading the view.
}


-(void) anchorback
{
    self.slidingViewController.topViewController.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
    [self.slidingViewController resetTopViewAnimated:YES];
    NSLog(@"BACK");
}

- (void)anchorRight {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
    NSLog(@"Right");
}

- (void)anchorLeft {
    [self.slidingViewController anchorTopViewToLeftAnimated:YES];
    
    NSLog(@"lEFT");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
