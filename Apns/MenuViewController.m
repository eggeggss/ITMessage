//
//  ViewController.m
//  Apns
//
//  Created by RogerRoan on 2016/4/18.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()
{
    NSArray *section1;
    NSArray *section2;
    NSArray *section3;
    NSArray *section4;
    NSArray *section5;
    NSArray *menu;
}
@property (nonatomic, strong) ECSlidingViewController *slidingViewController;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *app=[UIApplication sharedApplication].delegate;
    
    self.slidingViewController =app.slidingViewController;
    
    SectionObj *obj1=[[SectionObj alloc] init];
    obj1.storyid=@"first";
    obj1.chname=@"公佈欄";
    obj1.img=[UIImage imageNamed:@"clover50.png"];
    
    SectionObj *obj2=[[SectionObj alloc] init];
    obj2.storyid=@"second";
    obj2.chname=@"通訊錄";
    obj2.img=[UIImage imageNamed:@"myspace50.png"];
    
    SectionObj *obj3=[[SectionObj alloc] init];
    obj3.storyid=@"third";
    obj3.chname=@"訊息紀錄";
    obj3.img=[UIImage imageNamed:@"g50.png"];
    
    SectionObj *obj4=[[SectionObj alloc] init];
    obj4.storyid=@"forth";
    obj4.chname=@"找會議室";
    obj4.img=[UIImage imageNamed:@"u50.png"];
    
    SectionObj *obj5=[[SectionObj alloc] init];
    obj5.storyid=@"fifth";
    obj5.chname=@"報表";
    obj5.img=[UIImage imageNamed:@"p50.png"];

    section1=[NSArray arrayWithObjects:obj1, nil];
    
    section2=[NSArray arrayWithObjects:obj2, nil];
    
    section3=[NSArray arrayWithObjects:obj3 ,nil];

    section4=[NSArray arrayWithObjects:obj4 ,nil];

    section5=[NSArray arrayWithObjects:obj5 ,nil];
    
    menu=[NSArray arrayWithObjects:section1,section2,section3,section4,section5, nil];
    
    UIColor *color=[UIColor colorWithRed:54/255.0 green:48/255.0 blue:48/255.0 alpha:1];
    
    self.view.backgroundColor=color;
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    self.tableView.backgroundColor=color;
    
    UIView * headerview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 10)];
    
    self.tableView.tableHeaderView=headerview;
    
}
-(void) viewWillAppear:(BOOL)animated
{
    [self.delegateReset Reset];
    NSLog(@"Menu WillApear");
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return menu.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *obj_arr=[self->menu objectAtIndex:section];
    
    return obj_arr.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellname=@"MyCell";
    
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellname];
    
    if (cell!=nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellname];
    }
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    SectionObj *obj;
    UIImage *img;
    
    NSArray *obj_arr=[self->menu objectAtIndex:indexPath.section];
    
    obj=(SectionObj *) [obj_arr objectAtIndex:indexPath.row];
    
    img=obj.img;
    
    cell.textLabel.text=obj.chname;
    
    
    UIColor *color=[UIColor colorWithRed:54/255.0 green:48/255.0 blue:48/255.0 alpha:1];
    
  
    
    cell.contentView.backgroundColor=color;
    
    cell.textLabel.font=[UIFont boldSystemFontOfSize:16];
    
    cell.textLabel.textColor=[UIColor whiteColor];
    
    cell.imageView.image=img;
    
    //cell.textLabel.textAlignment=NSTextAlignmentRight;
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *obj_arr=[self->menu objectAtIndex:indexPath.section];
  
    SectionObj *obj=(SectionObj *)[obj_arr objectAtIndex:indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    //NSLog(@"%@",obj.storyid);
    /*
    UIBarButtonItem *anchorRightButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(anchorRight)];
    */
    
    UIBarButtonItem *anchorRightButton = [UIBarButtonItem GenerateButton:@selector(anchorRight) andSender:self];
    
    
    UIViewController *newcontroller=[[self storyboard] instantiateViewControllerWithIdentifier:obj.storyid];
    
    if([newcontroller isMemberOfClass:[SecondViewController class]])
    {
        self.delegateReset=(SecondViewController *) newcontroller;
    }
    
    newcontroller.navigationItem.title = obj.chname;//@"Layout Demo";
    
    newcontroller.navigationItem.leftBarButtonItem  = anchorRightButton;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newcontroller];
    /*
    UIColor *color=[UIColor colorWithRed:54/255.0 green:48/255.0 blue:48/255.0 alpha:1];
    */
    UIColor *color=[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1];
    
    navigationController.navigationBar.barTintColor = color;

    
    // enable swiping on the top view
    [navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    // configure anchored layout
    self.slidingViewController.anchorRightPeekAmount  = 100.0;
    self.slidingViewController.anchorLeftRevealAmount = 250.0;
    
    CGRect rect=self.slidingViewController.topViewController.view.frame;
    
    
    self.slidingViewController.topViewController=navigationController;
    
    self.slidingViewController.topViewController.view.frame=rect;
    
    [self.slidingViewController resetTopViewAnimated:YES];
    
}


- (void)anchorRight {
    
    SystemSoundID soundId=1057;
    
    AudioServicesPlaySystemSound(soundId);    //[slider anchorTopViewToRightAnimated:YES];
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
    NSLog(@"Right");
}

/*
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
    
    if(section==0){
        return 30;
    }
    return 10;
    
}
*/

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat flot=60;
    return flot;
    
}


//讓線靠左
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        //self.tableview.layer.borderWidth=10;
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        //self.tableview.layer.borderWidth=10;
    }
}



-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation SectionObj


@end

