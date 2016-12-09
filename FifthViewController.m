//
//  FifthViewController.m
//  ITMessage
//
//  Created by RogerRoan on 2016/4/22.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import "FifthViewController.h"

@interface FifthViewController ()



@end

@implementation FifthViewController

- (IBAction)btn_wv_refresh:(id)sender {
    
    [self.wv reload];
    
}


- (IBAction)btn_wv_back:(id)sender {
    
    [self.wv goBack];
}


- (IBAction)btn_wv_next:(id)sender {
    
    [self.wv goForward];
}


-(void) activeprogress
{
    
    UIActivityIndicatorView *indictor=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    self.alert=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
    
    self.alert.center=CGPointMake(self.view.center.x, self.view.center.y);
    
    UILabel *lb=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.alert.frame.size.width-10, 50)];
    
    lb.text=@"Loading";
    
    lb.textAlignment=NSTextAlignmentCenter;
    
    lb.font=[UIFont boldSystemFontOfSize:17];
    
    
    indictor.center=CGPointMake(self.alert.bounds.size.width/2,self.alert.bounds.size.height-50);
    
    [indictor startAnimating];
    [self.alert addSubview:indictor];
    
    
    self.progress=[[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    
    self.progress.frame=CGRectMake(15, indictor.center.y+20, self.alert.frame.size.width-10, 8);
    
    [self.alert addSubview:self.progress];
    
    [self.alert addSubview:lb];
    
    float theInterval=1.0/5.0;
    self.timer=[NSTimer scheduledTimerWithTimeInterval:theInterval target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    self.alert.backgroundColor=[UIColor orangeColor];
    
    self.alert.layer.cornerRadius=20;
    
    self.alert.alpha=0.5;
    
    [self.view addSubview:self.alert];
    
}

-(void) run
{
    if(self.progress.progress!=1.0)
    {
        self.progress.progress=self.progress.progress+0.1;
    }else
    {
        /*
        [self.timer invalidate];
        self.timer=nil;
        
        [self.alert removeFromSuperview];
         */
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *del=[UIApplication sharedApplication].delegate;
    
    self.db=del.db;
    
    
    
    //NSURL *url2=[NSURL URLWithString:@"http://eggeggss.ddns.net/appservice2/report1.aspx"];
    
    NSURL *url2=[NSURL URLWithString:@"http://eggeggss.ddns.net/appservice2/ReportLogin.aspx"];
    
    /*
    NSURL *url2=[NSURL URLWithString:@"http://eggeggss.ddns.net/sse/DiskReads.html"];
    */
    
    NSURLRequest *request2=[NSURLRequest requestWithURL:url2];
    [self.wv loadRequest:request2];
    self.wv.scalesPageToFit=YES;
    
    //self.wv.hidden=NO;
    self.wv.hidden=YES;
    
    self.wv.delegate=self;
    
    
    [self activeprogress];
    
    // Do any additional setup after loading the view.
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
    
    if(self.alert !=nil)
    {
       NSLog(@"start load");
    }
}
/*
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    
    return YES;
}
*/

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    self.wv.alpha=0;
    self.wv.hidden = YES;
    
    [UIView animateWithDuration:1 animations:^{
        
        self.wv.hidden = NO;
        
        self.wv.alpha=1;
        
        
            } completion:^(BOOL finished) {
                /*
                [self.alert removeFromSuperview];
                
                self.alert=nil;
                 */
                [self.timer invalidate];
                 self.timer=nil;
                [self.alert removeFromSuperview];
                self.alert=nil;
                
                NSString *user_id_javascript=[NSString stringWithFormat:@"SetUserId('%@')",self.db.userobj.user_id];// self.db.userobj.user_id;
                   NSString *user_pass_javascript=[NSString stringWithFormat:@"SetPassWord('%@')",self.db.userobj.user_name];//
                [self.wv stringByEvaluatingJavaScriptFromString:user_id_javascript];
                [self.wv stringByEvaluatingJavaScriptFromString:user_pass_javascript];
                
    }];
    
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error->%@",error.description);
   //[self.activeview stopAnimating];
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.wv loadRequest:nil];
    [self.wv removeFromSuperview];
    self.wv = nil;
    self.wv.delegate = nil;
    [self.wv stopLoading];
    
    NSLog(@"diddisappear");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    NSLog(@"didReceiveMemoryWarning");
   
    
    [self.wv reload];
    
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
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
