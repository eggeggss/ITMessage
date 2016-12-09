//
//  ThirdViewController.m
//  ITMessage
//
//  Created by RogerRoan on 2016/4/22.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat flot=150;
    return flot;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"rowcount =>%i",self.msg_list.count);

    return self.msg_list.count;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}



-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_name=@"MyCell";
    
    UITableViewCell *cell=[tableView dequeueReusableHeaderFooterViewWithIdentifier:cell_name];
    
    if(cell ==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:cell_name];
    }
    
    NSString *ls_read=@"0";//(NSString *)self->read[indexPath.row];
    
    UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
    
    UILabel *lb2=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, 300, 50)];
    
    lb.font=[UIFont boldSystemFontOfSize:12.0];
    
    lb2.font=[UIFont boldSystemFontOfSize:12.0];
    
    //[lb sizeToFit];
    lb2.textColor=[UIColor yellowColor];
    
    lb.textAlignment=NSTextAlignmentLeft;
    lb2.textAlignment=NSTextAlignmentRight;
    
    lb.backgroundColor=[UIColor blackColor];
    lb2.backgroundColor=[UIColor blackColor];
    
    MessageObject *msg_obj=self.msg_list[indexPath.row];
    
    if ([ls_read isEqual:@"1"])
    {
        lb.textColor=[UIColor redColor];
        //cell.textLabel.textColor=[UIColor redColor];
    }else{
        lb.textColor=[UIColor greenColor];
        //cell.textLabel.textColor=[UIColor blackColor];
    }
    
    lb.text=msg_obj.content;
    [lb setLineBreakMode:NSLineBreakByTruncatingTail];
    lb.numberOfLines=3;
    
    lb2.text=msg_obj.dt_create;
    
    cell.contentView.superview.backgroundColor=[UIColor blackColor];
    
    [cell.contentView addSubview:lb];
    
    [cell.contentView addSubview:lb2];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


//讓線靠左
-(void)viewDidLayoutSubviews
{
    if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        //self.tableview.layer.borderWidth=10;
    }
    
    if ([self.tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
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

-(void) fresh
{
   
    [_app.db selectUserInfo];
    
    NSString *userId=[_app.db userobj].user_id;
    userId=@"A110018";
    //NSString * userId=@"A110018";
    
    [Util HttpReturnUnReadMessage:userId completion:^(NSString * result) {
        
        NSData *jsonData=[result dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *err;
        NSArray *array=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        if(err)
        {
            NSLog(@"pase fail %@",err);
        }
        
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            //NSLog(@"%i",idx);
            NSDictionary *dic=[array objectAtIndex:idx];
            
            [_app insertMessage:dic[@"id_cloud_msg"] andMsg:dic[@"content"] andCreateDate:dic[@"dt_create"]];
            
            NSInteger *id_could_msg=[Util StringToInterger:dic[@"id_cloud_msg"]].integerValue;
            
            [Util HttpCallBackIdCloud:id_could_msg];
    
        }];
        
        SystemSoundID soundId=1100;
        
        AudioServicesPlaySystemSound(soundId);
       [self RefreshTable];
        [self.refreshControl endRefreshing];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview.dataSource=self;
    self.tableview.delegate=self;
    self.tableview.backgroundColor=[UIColor blackColor];
    self.refreshControl=[[UIRefreshControl alloc] init];
    
    [self.tableview addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(fresh) forControlEvents:UIControlEventValueChanged];
    
    _app=[UIApplication sharedApplication].delegate;
    
    
    
    [self performSelector:@selector(RefreshTable)];
    //[self.tableview reloadData];
    
    // Do any additional setup after loading the view.
}

-(void) viewDidAppear:(BOOL)animated
{
    
   // [self performSelector:@selector(RefreshTable)];
   // self.msg_list=_app.db.msg_list;
}

-(void) viewWillAppear:(BOOL)animated
{
    
        //[super viewWillAppear:animated];
    //self.msg_list=_app.db.msg_list;
    
    //[self.tableview reloadData];
    //[self performSelector:@selector(RefreshTable)];
    
    //NSLog(@"willappear %i",self.msg_list.count);
}

#pragma delegate
-(void) RefreshTable
{
    /*
    AppDelegate *app= [UIApplication sharedApplication].delegate;
    
    app.delegate=self;
    
    if (app.db ==nil)
    {
        app.db=[[DataBase alloc] initDataBase];
    }
    
    [app.db refreshMsgData];
    
    self.msg_list=nil;
    self.msg_list=app.db.msg_list;
    
    [self.tableview reloadData];
    */
    DataBase *db=[[DataBase alloc] initDataBase];
    [db refreshMsgData];
    self.msg_list=db.msg_list;
    
    [self.tableview reloadData];
    
    
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
