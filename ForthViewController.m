//
//  ForthViewController.m
//  ITMessage
//
//  Created by RogerRoan on 2016/4/22.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import "ForthViewController.h"

@interface ForthViewController ()
@property (assign,nonatomic) double loc1;
@property (assign,nonatomic) double loc2;
@property NSInteger rowkind;
@property (strong,nonatomic) NSString *currentGroupName;
/*
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activeview;
*/
@end

@implementation ForthViewController


#pragma pickview
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==0)
    {
        self.rowkind=row;
        
        [self.pickview reloadAllComponents];
        [self.pickview selectRow:0 inComponent:1 animated:YES];
        RoomGroup *group=(RoomGroup *)self.group_list[row];
        
        _currentGroupName=nil;
        _currentGroupName=group.GroupName;
        
        UIImage *img=nil;
        if ([group.GroupName isEqual:@"8F1"])
        {
            img=[UIImage imageNamed:@"8f1"];
            
        }else if([group.GroupName isEqual:@"8F2"])
        {
            img=[UIImage imageNamed:@"8f2"];
            
        }else if([group.GroupName isEqual:@"6F"])
        {
            img=[UIImage imageNamed:@"6F"];
        }
        
        [self.roomView changeImage:img];
        
        MyRoom *room =[group.RoomList objectAtIndex:0];
        
        [self.roomView changePoint:room];
        
       
    }else
    {
        RoomGroup *group2=(RoomGroup *)self.group_list[self.rowkind];
        MyRoom *room=group2.RoomList[row];
        
        [self.roomView changePoint:room];
        NSLog(@"selected %@",room.RoomName);
    }
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component==0)
    {
        RoomGroup *group=self.group_list[row];
        return group.GroupName;
    }
    else
    {
        //NSLog(@"%i ,%i",row,self.rowkind);
        RoomGroup *group2=(RoomGroup *)self.group_list[self.rowkind];
        MyRoom *room=group2.RoomList[row];
        return room.RoomName;
        
    }
}



#pragma must be
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

#pragma  must be
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0)
    {
        return self.group_list.count;
    }else
    {
        RoomGroup *group=(RoomGroup *)self.group_list[self.rowkind];
        
        return group.RoomList.count;
       //self.group_list[]
    }
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyRoom *myroom=[[MyRoom alloc] initobjectX:60 andY:67.5];
    myroom.RoomName=@"阿波羅";
    
    MyRoom *myroom2=[[MyRoom alloc] initobjectX:46 andY:154];
    myroom2.RoomName=@"邱比特";
    
    MyRoom *myroom3=[[MyRoom alloc] initobjectX:64 andY:192];
    myroom3.RoomName=@"啟發";
    
    MyRoom *myroom4=[[MyRoom alloc] initobjectX:141.5 andY:194];
    myroom4.RoomName=@"維納斯";
    
    MyRoom *myroom5=[[MyRoom alloc] initobjectX:185 andY:199.5];
    myroom5.RoomName=@"雅典娜";
    
    MyRoom *myroom6=[[MyRoom alloc] initobjectX:227 andY:332];
    myroom6.RoomName=@"HR面談室";
    
    RoomGroup *group1=[[RoomGroup alloc] init];
    group1.GroupName=@"6F";
    
    group1.RoomList=[[NSMutableArray<MyRoom *> alloc] init];
    
    [group1.RoomList addObject:myroom];
    [group1.RoomList addObject:myroom2];
    [group1.RoomList addObject:myroom3];
    [group1.RoomList addObject:myroom4];
    [group1.RoomList addObject:myroom5];
    [group1.RoomList addObject:myroom6];
    
    MyRoom *myroom7=[[MyRoom alloc] initobjectX:63.5 andY:66];
    myroom7.RoomName=@"Arcadyan VIP";
    
    MyRoom *myroom8=[[MyRoom alloc] initobjectX:284.5 andY:281];
    myroom8.RoomName=@"戰情室";
    
    MyRoom *myroom9=[[MyRoom alloc] initobjectX:238 andY:312];
    myroom9.RoomName=@"前瞻";
    
    MyRoom *myroom10=[[MyRoom alloc] initobjectX:286 andY:316.5];
    myroom10.RoomName=@"睿智";
    
    RoomGroup *group2=[[RoomGroup alloc] init];
    group2.GroupName=@"8F1";

    group2.RoomList=[[NSMutableArray<MyRoom *> alloc] init];
    
    [group2.RoomList addObject:myroom7];
    [group2.RoomList addObject:myroom8];
    [group2.RoomList addObject:myroom9];
    [group2.RoomList addObject:myroom10];
    
    MyRoom *myroom11=[[MyRoom alloc] initobjectX:90.5 andY:140];
    myroom11.RoomName=@"卓越";
    
    MyRoom *myroom12=[[MyRoom alloc] initobjectX:134 andY:128];
    myroom12.RoomName=@"領先";

    MyRoom *myroom13=[[MyRoom alloc] initobjectX:177 andY:120.5];
    myroom13.RoomName=@"展望";

    MyRoom *myroom14=[[MyRoom alloc] initobjectX:221 andY:120];
    myroom14.RoomName=@"創新";

    MyRoom *myroom15=[[MyRoom alloc] initobjectX:271.5 andY:124];
    myroom15.RoomName=@"策略";

    MyRoom *myroom16=[[MyRoom alloc] initobjectX:278 andY:247];
    myroom16.RoomName=@"思維";

    MyRoom *myroom17=[[MyRoom alloc] initobjectX:257 andY:277];
    myroom17.RoomName=@"願景";
        
    RoomGroup *group3=[[RoomGroup alloc] init];
    group3.GroupName=@"8F2";
    group3.RoomList=[[NSMutableArray<MyRoom *> alloc] init];
    
    [group3.RoomList addObject:myroom11];
    [group3.RoomList addObject:myroom12];
    [group3.RoomList addObject:myroom13];
    [group3.RoomList addObject:myroom14];
    [group3.RoomList addObject:myroom15];
    [group3.RoomList addObject:myroom16];
    [group3.RoomList addObject:myroom17];
    
    self.group_list=[[NSMutableArray alloc] init];
    [self.group_list addObject:group1];
    [self.group_list addObject:group2];
    [self.group_list addObject:group3];
    
    self.rowkind=0;
    
    self.pickview.dataSource=self;
    self.pickview.delegate=self;
    
    
    [self.roomView changePoint:myroom];
    
    _currentGroupName=@"6F";
    
    
    CGFloat w=self.roomView.frame.size.width;
    CGFloat h=self.roomView.frame.size.height;
    //2016-12-08 roger stop
    /*
    self.locmanager=[CLLocationManager new];
    self.locmanager.delegate=self;
    
    [self.locmanager requestAlwaysAuthorization];
    
    self.locmanager.allowsBackgroundLocationUpdates=YES;
    
    NSUUID *uiid=[[NSUUID alloc] initWithUUIDString:@"FDA50693-A4E2-4FB1-AFCF-C6EB07647826"];
    
   
    self.gbean=[[CLBeaconRegion alloc] initWithProximityUUID:uiid identifier:@"myregion"];
    
    [self.locmanager startRangingBeaconsInRegion:self.gbean];
    
    [self.locmanager startMonitoringForRegion:self.gbean];
    
    self.locmanager.desiredAccuracy=kCLLocationAccuracyBest;
    
    self.locmanager.distanceFilter = 0.0f;
    
    [self.locmanager startUpdatingLocation];
    */

}


-(void) whereIsYourBuilding:(NSString *) group_name
{
    if ([_currentGroupName isEqual:group_name])
    {
        
        switch([self.clbean proximity])
        {
            case CLProximityUnknown:
                self.roomView.greencolor=1;
                //NSLog(@"Unknow");
                break;
            case CLProximityFar:
                self.roomView.greencolor=0.6;
                //NSLog(@"Far");
                break;
                
            case CLProximityImmediate:
                
                self.roomView.greencolor=0;
                //NSLog(@"Immediate");
                break;
                
            case CLProximityNear:
                self.roomView.greencolor=0.3;
                //NSLog(@"Near");
                break;
        }
    }
}


-(void) locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region
{
    //NSLog(@"BEANCON %i",beacons.count);
    
    if(beacons.count>0)
    {
        self.clbean=[beacons objectAtIndex:0];
        
        NSNumber *major=self.clbean.major;
        NSNumber *minor=self.clbean.minor;
        
        CLLocationAccuracy accuracy=self.clbean.accuracy;
        
        if ([minor intValue]==18595)
        {
            
            [self performSelector:@selector(whereIsYourBuilding:) withObject:@"8F2"];
            //NSLog(@"1.major:%i minor:%i  accuracy:%f",[major intValue],[minor intValue],accuracy);
            //self.loc1=accuracy;
            
           // self.closerview1.text=[NSString stringWithFormat:@"minor %@ location A:%f",minor,accuracy];
        }else
        {
            [self performSelector:@selector(whereIsYourBuilding:) withObject:@"6F"];
            
            //48BE 6F
            /*
            if ([_currentGroupName isEqual:@"6F"])
            {
                
                switch([self.clbean proximity])
                {
                    case CLProximityUnknown:
                        self.roomView.greencolor=1;
                        NSLog(@"Unknow");
                        break;
                    case CLProximityFar:
                        self.roomView.greencolor=0.6;
                        NSLog(@"Far");
                        break;
                        
                    case CLProximityImmediate:
                        
                        self.roomView.greencolor=0;
                        NSLog(@"Immediate");
                        break;
                        
                    case CLProximityNear:
                        self.roomView.greencolor=0.3;
                        NSLog(@"Near");
                        break;
                }
                
                
            }
             */
            
        }
        
    }
    //NSLog(@"HELLO");
}

-(void) locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    
    NSLog(@"HI");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    if (self.gbean)
    {
        [self.locmanager stopRangingBeaconsInRegion:self.gbean];
        [self.locmanager stopMonitoringForRegion:self.gbean];
    }
    
    [self.locmanager stopUpdatingLocation];
    
    self.gbean=nil;
    self.locmanager.delegate=nil;
    self.locmanager=nil;
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locationsa
{
    CLLocation *lastloc=[locationsa lastObject];
    /*
    self.closerview1.text=[NSString stringWithFormat:@"latitude => %f ,long=> %f",lastloc.coordinate.latitude,lastloc.coordinate.longitude];
    */
   // NSLog(@"latitude => %f ,long=> %f",locations[0].coordinate.latitude,locations[0].coordinate.longitude);
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
