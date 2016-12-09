//
//  FirstViewController.m
//  ITMessage
//
//  Created by RogerRoan on 2016/4/20.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *wv1;
//@property (weak, nonatomic) IBOutlet UIWebView *wv2;
@property (weak, nonatomic) IBOutlet UIWebView *wv3;
@property(strong,nonatomic) UIAlertController *alert;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    
    if (appDelegate.db ==nil)
    {
        appDelegate.db=[[DataBase alloc] initDataBase];
    }
    
    DataBase *db=appDelegate.db;
    
    CGSize size=[Util GetScreenSize];
    
   
    
    NSLog(@"Device:%f",size.height);
    NSLog(@"Device:%@",[Util DeviceModel]);
    //NSLog(@"reg_id %@",reg_id);
    /*
    UIColor *color=[UIColor colorWithRed:54/255.0 green:48/255.0 blue:48/255.0 alpha:1];
    */
    UIColor *color=[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1];
    
    self.navigationController.navigationBar.barTintColor = color;
  
    if([db findUserInfo]==NO)
    {
         _alert =[UIAlertController alertControllerWithTitle:@"系統登入" message:@"為辨識使用者身份,請輸入您的資訊" preferredStyle:UIAlertControllerStyleAlert];
        
        [_alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder=@"請輸入工號";
            
            textField.keyboardType=UIKeyboardTypeASCIICapable;
            
            [textField setAutocapitalizationType:UITextAutocapitalizationTypeWords];
            
            textField.tag=0;
            //UIControlEventEditingDidEndOnExit
            [textField addTarget:self action:@selector(KeyEnd:) forControlEvents:UIControlEventEditingDidEnd];
            
        }];
        
        [_alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder=@"English Name";
            
            textField.keyboardType=UIKeyboardTypeASCIICapable;
            
            [textField setAutocapitalizationType:UITextAutocapitalizationTypeWords];
            textField.tag=1;
            
            [textField addTarget:self action:@selector(KeyEnd:) forControlEvents:UIControlEventEditingDidEnd];
        }];
        
        
        
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"Login" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            NSString *user_id=_alert.textFields[0].text;
            NSString *user_name=_alert.textFields[1].text;
            
            appDelegate.user_id=user_id;
            appDelegate.user_name=user_name;
            
            [db insertUserInfo:user_id andUserName:user_name];
            
            [db updateUserInfo:appDelegate.reg_id];
            
            [db selectUserInfo];
            //alert.actions[0].enabled=NO;
            //action.enabled=NO;
            //NSLog(@"user_id=> %@, user_name=> %@ reg_id=> %@",user_id,user_name,appDelegate.reg_id);
            
        }];
        //action.enabled=NO;
        
        [_alert addAction:action];
        
        [self presentViewController:_alert animated:YES completion:^{
            _alert.actions[0].enabled=NO;
        }];
    }
    
    //NSHomeDirectory()
    
    
    [db selectUserInfo];
    /*
    NSLog(@"select -> user_name =%@ ,user_id=%@, reg_id=%@  ",db.userobj.user_name,db.userobj.user_id,db.userobj.reg_id);
    */
    //http://www.arcadyan.com
    NSURL *url=[NSURL URLWithString:@"http://eggeggss.ddns.net/appservice2/arccalendar.aspx"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.wv1 loadRequest:request];
    self.wv1.scalesPageToFit=YES;
    self.wv1.transform=CGAffineTransformMakeScale(1, 1);
    
    
    NSURL *url3=[NSURL URLWithString:@"http://eggeggss.ddns.net/appservice2/Rota.aspx"];
    NSURLRequest *request3=[NSURLRequest requestWithURL:url3];
    [self.wv3 loadRequest:request3];
    self.wv3.scalesPageToFit=YES;
    
    self.wv3.transform=CGAffineTransformMakeScale(1.2, 1.7);
    
    /*
    NSURL *url2=[NSURL URLWithString:@"http://www.dgpa.gov.tw/nds.html"];
    NSURLRequest *request2=[NSURLRequest requestWithURL:url2];
    [self.wv2 loadRequest:request2];
    self.wv2.scalesPageToFit=YES;
    */
    self->magee_list=[[NSArray<NSString *> alloc] initWithObjects:@"福委會 2016年員工旅遊意向調查開始囉",@"智易科技 : 上下班行車安全宣導",@"【MIS公告】2016/03/07 Arc-Traveler 暫停止服務",@"【福委會】Q1按摩活動報名預告~~~~~" ,nil];
    
    self->magee_index=0;
    
    self.marquee.textColor=[UIColor whiteColor];
    
    [self.marquee setText:@"系統資訊"];
    
    self.marquee.textAlignment = NSTextAlignmentCenter;
    
    self->timer=[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(runmagee:) userInfo:nil repeats:YES];
    
    
    for (NSLayoutConstraint *con in self.wv3.constraints)
    {
        if([con.identifier isEqual:@"h1"])
        {
            if (size.height<=568)
            {
              con.constant=150;
            }else
            {
              con.constant=200;
            }
            //NSLog(@"h1");
            
        }
    }
        //NSLog(@"content=>%@",bcont);
    //NSLog(@"%@",filedata.description);
}



-(void) viewWillAppear:(BOOL)animated
{
        //[self.wv1 layer].cornerRadius=20;
}

-(void) viewDidAppear:(BOOL)animated
{
    
}

-(void) KeyEnd:(UITextField *) textfield
{
    if(textfield.tag==0)
    {
        if([textfield.text isEqualToString:@""]==NO)
        {
            _alert.actions[0].enabled=YES;
        }
        
    }
    //NSLog(@"keyEnd %@ , %i",textfield.text,textfield.tag);
}

-(void) runmagee:(NSTimer *)timer
{
    if((self->magee_index) >(self->magee_list.count -1))
    {
        self->magee_index=0;
    }
    
    [self.marquee setText:[self->magee_list objectAtIndex:self->magee_index]];
    
    [self.marquee setAlpha:0.0];
    
    [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear animations:^{
        self->magee_index++;
        // [self.newsMessageLabel setCenter:CGPointMake(160, 163)];
        [self.marquee setAlpha:1.0];
    } completion:^(BOOL finished) {
        if (finished) {
            //  [self performSelector:@selector(labelMoving) withObject:nil afterDelay:2.0];
        }
    }
     ];
    
    //NSLog(@"1");
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
