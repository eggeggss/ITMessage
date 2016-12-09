// UIViewController+ECSlidingViewController.m
// ECSlidingViewController 2
//
// Copyright (c) 2013, Michael Enriquez (http://enriquez.me)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "UIViewController+ECSlidingViewController.h"

@implementation UIViewController (ECSlidingViewController)

- (ECSlidingViewController *)slidingViewController {
    UIViewController *viewController = self.parentViewController ? self.parentViewController : self.presentingViewController;
    while (!(viewController == nil || [viewController isKindOfClass:[ECSlidingViewController class]])) {
        viewController = viewController.parentViewController ? viewController.parentViewController : viewController.presentingViewController;
    }
    
    return (ECSlidingViewController *)viewController;
}

-(void) PresentView:(NSString *)storyid andTitle:(NSString *)title
{
    UIBarButtonItem *anchorRightButton = [[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStylePlain target:self action:@selector(anchorRight)];
    
    UIViewController *newcontroller=[[self storyboard] instantiateViewControllerWithIdentifier:storyid];
    
    //newcontroller.title=obj.chname;
    
    newcontroller.navigationItem.title = title;//@"Layout Demo";
    
    newcontroller.navigationItem.leftBarButtonItem  = anchorRightButton;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newcontroller];
    
    UIColor *color=[UIColor colorWithRed:54/255.0 green:48/255.0 blue:48/255.0 alpha:1];
    
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


@end
