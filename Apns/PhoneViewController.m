//
//  PhoneViewController.m
//  ITMessage
//
//  Created by RogerRoan on 2016/6/8.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import "PhoneViewController.h"

@interface PhoneViewController ()
@property (strong,nonatomic) UIToolbar *toolbar;
@property (strong,nonatomic) CALayer *ca_btn_ph;
@property (strong,nonatomic) CALayer *ca_btn_sms;
@end

@implementation PhoneViewController
- (IBAction)btn_phone_action:(id)sender {
    
    [self callPhone:self.member.phone_number];
}
- (IBAction)btn_sms_action:(id)sender {
    [self sentSMS:self.member.phone_number andContent:@""];
}


//delegate
-(void) messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
}


-(void) sentSMS:(NSString *) number andContent:(NSString *) msg
{
    MFMessageComposeViewController *controller=[[MFMessageComposeViewController alloc] init];
    
    if ([MFMessageComposeViewController canSendText])
    {
        controller.body=msg;
        controller.recipients=[[NSArray<NSString *> alloc] initWithObjects:self.member.phone_number, nil];
        
        controller.messageComposeDelegate=self;
        [self presentViewController:controller animated:YES completion:^{
            
        }];
        
    }
}
-(void) callPhone:(NSString *) phone
{
    NSString *number=[NSString stringWithFormat:@"tel:%@",phone];
    
    NSURL *url=[[NSURL alloc] initWithString:number];
    
    [[UIApplication sharedApplication] openURL:url];
    
}


-(void)ResizeToolBar :(UIInterfaceOrientation)toInterfaceOrientation
{
    //UIToolbar *toolbar=nil;

    if (_toolbar!=nil)
    {
        [_toolbar removeFromSuperview];
        _toolbar=nil;
    }
    
    
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {
        //畫面傾置
        _toolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.height, 70)];
        
        //NSLog(@"2");
    }
    else if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        //畫面直立
       _toolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
       // NSLog(@"1");
    }
    else{
        //NSLog(@"3");
    }
    
    [self.view addSubview:_toolbar];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ca_btn_ph=self.btn_Phone.layer;
    self.ca_btn_sms=self.btn_Sms.layer;
    
    //NSLog(@"viewDidLoad");
    // Do any additional setup after loading the view.
}
-(void) viewWillAppear:(BOOL)animated
{
    [self.ca_btn_ph setBorderColor:[UIColor darkGrayColor].CGColor];
    
    [self.ca_btn_ph setBorderWidth:1.0f];
    
    [self.ca_btn_sms setBorderColor:[UIColor darkGrayColor].CGColor];
    
    [self.ca_btn_sms setBorderWidth:1.0f];
    
    
    _lb_userName.text=[_member.user_name uppercaseString];
    _lb_userName.textAlignment=NSTextAlignmentCenter;
    
    _lb_phoneno.text=_member.phone_number;
    _lb_phoneno.textAlignment=NSTextAlignmentCenter;
    
    _lb_phoneno.textColor=[UIColor purpleColor];
    
    [_btn_Phone setTitle:@"Call Phone" forState:UIControlStateNormal];
    _btn_Phone.backgroundColor=[UIColor yellowColor];
    
    //[_btn_Phone setAlpha:0.4];
    [_btn_Phone layer].cornerRadius=20;
    
    
    _btn_Sms.backgroundColor=[UIColor greenColor];
    
    [_btn_Sms layer].cornerRadius=20;
    
    [_btn_Sms setTitle:@"SMS" forState:UIControlStateNormal];
    //NSLog(@"viewWillAppear");
    
   // NSLog(@"phone =>%@",_member.user_name);
    
    //[self ResizeToolBar:UIInterfaceOrientationPortrait];
    
}
/*
-(void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    if(size.width>size.height)
    {
    

        [self ResizeToolBar:UIInterfaceOrientationLandscapeRight];
        NSLog(@"1");
    }else
    {
        [self ResizeToolBar:UIInterfaceOrientationPortrait];
        
        NSLog(@"2");
    }
}
*/
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
