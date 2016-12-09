//
//  SecondViewController.m
//  ITMessage
//
//  Created by RogerRoan on 2016/4/21.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
{
    NSMutableArray<MemberGroup *> *m_group;
    NSMutableArray<Member *> *findlist;
}
@property (strong,nonatomic) UIView *myview;
@property (nonatomic, strong) ECSlidingViewController *slidingViewController;
@end

@implementation SecondViewController

-(void) CallMember:(Member *)member
{
    _myview=nil;
    _myview=[[UIView alloc] initWithFrame:CGRectMake(0, 500, 200, 150)];
    
    _myview.center=CGPointMake(self.view.center.x, self.view.center.y);
    
    _myview.backgroundColor=[UIColor orangeColor];
    
    _myview.layer.cornerRadius=20;
    
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    btn.backgroundColor=[UIColor whiteColor];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [_myview addSubview:btn];
    
    [self.view addSubview:_myview];
    
}

-(void)click:(id)sender
{
    [_myview removeFromSuperview];
    
    [self performSelector:@selector(adjustTableView)];
    
    [self.navigationController setToolbarHidden:YES];
    
}

-(void) initPhoneList{
    
    m_group=[NSMutableArray<MemberGroup *> array];
    
    NSString *bstr=[[NSBundle mainBundle] pathForResource:@"member_list" ofType:@"txt"];
    
    NSData *filedata=[NSData dataWithContentsOfFile:bstr];
    
    NSString *bcont=[[NSString alloc]initWithData:filedata encoding:NSUTF8StringEncoding];
    
    //NSArray *list=[bcont componentsSeparatedByString:@";"];
    
    NSMutableArray *list=[bcont componentsSeparatedByString:@";"];
    
    
    [list removeLastObject];
    
    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *list=(NSString *)obj;
        
        NSArray *member=[list componentsSeparatedByString:@","];
        
        NSString *group_id=[member[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                            
        NSString *user_id=member[1];
        NSString *user_name=member[2];
        NSString *phone_number=member[3];
        NSString *img=member[4];
        
        Member *member1=[[Member alloc] initwithid:user_id andname:user_name andphone:phone_number andimage:img];
        
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"group_name MATCHES[cd] %@",group_id];
               
        NSArray *findlistarray= [m_group filteredArrayUsingPredicate:predicate];
               
        if (findlistarray.count==0)
        {
           MemberGroup *m_group1=[[MemberGroup alloc] initwithgroupname:group_id];
              
           [m_group addObject:m_group1];
            
           [m_group1.member_list addObject:member1];
        }
        else
        {
            MemberGroup *m_group2= (MemberGroup *)findlistarray[0];
            
            [m_group2.member_list addObject:member1];
            
        }
    }];
}



-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self->findlist)
        return  1;
    
    return self->m_group.count;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self->findlist)
    {
        //NSLog(@"find size %i",findlist.count);
        return self->findlist.count;
    }
    return [m_group objectAtIndex:section].member_list.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellname=@"MyCell";
    
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellname];
    
    if (cell!=nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellname];
    }
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    //cell.textLabel.text=@"test";
    Member *member;
    
    if (self->findlist)
    {
        member=[self->findlist objectAtIndex:indexPath.row];
    }
    else
    {
        member=[[self->m_group objectAtIndex:indexPath.section].member_list objectAtIndex:indexPath.row];
    }
    
    
    UIImage *img1=[UIImage imageNamed:member.image];
    
    UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    
    img.image=img1;
    
    [cell.contentView addSubview:img];
    cell.textLabel.text=[NSString stringWithFormat:@"  %@",member.user_name];//member.user_name;
    cell.detailTextLabel.text=member.phone_number;
    
    UIColor *color=[UIColor colorWithRed:250/255.0 green:250/255.0 blue:210/255.0 alpha:1];
    
    cell.backgroundColor=color;
    
    return cell;
    
}


-(void) btnCancel:(id) sender
{
   [self dismissViewControllerAnimated:YES completion:^{
       
   }];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhoneViewController *phone=[[self storyboard] instantiateViewControllerWithIdentifier:@"PhoneViewcontroller"];
    
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:phone];
    
    UIBarButtonItem *btn=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(btnCancel:)];
    
    phone.navigationItem.leftBarButtonItem=btn;
    
    Member *member=nil;
    
    if (self->findlist)
    {
        member=[self->findlist objectAtIndex:indexPath.row];
    }
    else
    {
        member=[[self->m_group objectAtIndex:indexPath.section].member_list objectAtIndex:indexPath.row];
    }
    
    phone.member=member;
    
    [self presentViewController:nav animated:YES completion:nil];
    
}



#pragma mark 返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (self->findlist)
        return  @"";
    
    MemberGroup *group=[self->m_group objectAtIndex:section];
    
    return  group.group_name;
}

#pragma mark 返回每组尾部说明
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    return @"";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
    
    if(section==0){
        return 0;
    }
    return 10;
    
}

#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

#pragma mark 设置尾部说明内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MemberGroup *group=[self->m_group objectAtIndex:section];

    UILabel *lb=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    UIColor *color=[UIColor colorWithRed:255/255.0 green:218/255.0 blue:185/255.0 alpha:1];
    lb.backgroundColor=color;
    lb.text=group.group_name;
    lb.font=[UIFont fontWithName:@"Menlo" size:16];
    //UIFont *font=[UIFont fontWithName:@"Menlo" size:16];
    
    return lb;
    
    //return headerView;
}


//search bar edit
-(void) updateSearchResultsForSearchController:(UISearchController *)searchController
{
    if([self.searchcontroller isActive])
    {
        NSString *search_string=self.searchcontroller.searchBar.text;
        
        //self.slidingViewController.panGesture.enabled=NO;
        
        if(search_string.length>0)
        {
            //self.slidingViewController.panGesture.enabled=NO;

            self->findlist=[NSMutableArray new];
            
            [self->m_group enumerateObjectsUsingBlock:^(MemberGroup * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                MemberGroup *group=[self->m_group objectAtIndex:idx];
                
                NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user_name CONTAINS[cd] %@",search_string];
                
                NSArray *findlistarray;
                
                findlistarray= [group.member_list filteredArrayUsingPredicate:predicate];
                
                [findlistarray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    Member *member=[findlistarray objectAtIndex:idx];
                    
                    [self->findlist addObject:member];
                    // NSLog(@"%@",member.user_name);
                    
                }];
            }];
            
            
        }else
        {
            self->findlist=nil;
            //self.slidingViewController.panGesture.enabled=YES;
            
        }
        
        [self.tableview reloadData];
        
    }
    
}



-(BOOL) searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
        //搜尋結束後，恢復原狀，如果要產生動畫效果，要另外執行animation代碼
    /*
    self.tableview.frame = CGRectMake(self.tableview.frame.origin.x, 0, self.tableview.frame.size.width, self.tableview.frame.size.height);
    */
    
    [self performSelector:@selector(adjustTableView)];
     //NSLog(@"SEARCH BEGIN END");
    
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    
    //self.slidingViewController.panGesture.enabled=YES;
    //搜尋結束後，恢復原狀，如果要產生動畫效果，要另外執行animation代碼
    /*
    self.tableview.frame = CGRectMake(self.tableview.frame.origin.x, 0, self.tableview.frame.size.width, self.tableview.frame.size.height);
    */
    
    
    [self performSelector:@selector(adjustTableView)];
     //NSLog(@"SEARCH END");
    
    
    //[self.searchbar resignFirstResponder];
    //[self.searchbar setShowsCancelButton:NO animated:NO];
    
    return YES;
    
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //self.slidingViewController.panGesture.enabled=YES;
    
    [self.searchbar resignFirstResponder];
    [self.searchbar setShowsCancelButton:NO animated:NO];
    
    self->findlist=nil;
    [self.tableview reloadData];
    //NSLog(@"searchbar cancel");
}


-(void) adjustTableView
{
    self.tableview.frame = CGRectMake(self.tableview.frame.origin.x, 0, self.tableview.frame.size.width, self.view.frame.size.height);
    
}

-(void) Reset
{
    self.searchcontroller.active=NO;
    [self updateSearchResultsForSearchController:self.searchcontroller];
    [self.tableview reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelector:@selector(initPhoneList)];
    
    
    AppDelegate *app=[UIApplication sharedApplication].delegate;
    self.slidingViewController =app.slidingViewController;
    
    
    
    self.tableview.dataSource=self;
    self.tableview.delegate=self;
    
    self.searchcontroller=[[UISearchController alloc]initWithSearchResultsController:nil];
    
    self.searchcontroller.dimsBackgroundDuringPresentation=NO;
    
    self.searchcontroller.searchResultsUpdater=self;
    
    self.definesPresentationContext=NO;
    
    self.searchbar=self.searchcontroller.searchBar;
    
    UIColor *color=[UIColor colorWithRed:255/255.0 green:179/255.0 blue:179/255.0 alpha:1];
    
    self.searchbar.barTintColor=color;
    
    
    CGRect rect=self.searchbar.frame;
    rect.size.height=70;
    
    self.searchbar.frame=rect;
    
    self.searchcontroller.hidesNavigationBarDuringPresentation=NO;
    
    self.searchbar.tintColor=color;
    
    self.searchbar.delegate=self;
    
    self.tableview.tableHeaderView=self.searchbar;
    
    //self.tableview.backgroundColor=[UIColor blueColor];
    
    //[self.tableview addSubview:self.refreshControl];

    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSelector:@selector(adjustTableView)];

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
