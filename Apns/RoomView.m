//
//  RoomView.m
//  ITMessage
//
//  Created by RogerRoan on 2016/5/16.
//  Copyright © 2016年 RogerRoan. All rights reserved.
//

#import "RoomView.h"
@interface RoomView()

@end

@implementation RoomView



-(void) changePoint:(MyRoom *) room
{
    self.myroom=nil;
    self.myroom=room;
    
     //CGFloat *r=CGColorGetComponents([[UIColor redColor] CGColor]);
     //CGFloat *g=CGColorGetComponents([[UIColor greenColor] CGColor]);
    //CGFloat *b=CGColorGetComponents([[UIColor blueColor] CGColor]);

    _greencolor=1;
    
    CGContextSetRGBFillColor(context, 255/255 , _greencolor, 0, 1);
    
    
    //CGContextSetRGBFillColor(context, 255/255 , 0, 0, 1);
    CGContextAddEllipseInRect(context,room.rect);
    CGContextDrawPath(context, kCGPathFill);
    
    //[self setNeedsDisplay];
    
}

-(void) changeImage:(UIImage *) img
{
    
    CGImageRef imgref=img.CGImage;
    self.img=img;
    [self setNeedsDisplay];
}

-(void) initObj:(CGRect)rect
{
    _greencolor=1;
    
    context = UIGraphicsGetCurrentContext();
    
    UIImage *image=[UIImage imageNamed:@"6F"];
    
    [self changeImage:image];
    
    
    self->mytimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshUIView:) userInfo:nil repeats:YES];
    
}

-(void) refreshUIView:(NSTimer *)timer
{
    //[self changeColor];
    [self setNeedsDisplay];
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   UITouch *touchs= [touches anyObject];
   
   CGPoint loc= [touchs locationInView:self];
    
    NSLog(@"X=%f Y=%f",loc.x,loc.y);
    
}

- (void)drawRect:(CGRect)rect {
    
    if(!self->b_init)
    {
        [self initObj:rect];
        self->b_init=YES;
    }
    
    CGContextSaveGState(context);
    
    [self.img drawInRect:CGRectMake(0, 0, 318,395.5)];
    
    //NSLog(@"test %f, %f",rect.size.width ,rect.size.height);
    
    CGContextSetRGBFillColor(context, 1, _greencolor, 0, 1);
    CGContextAddEllipseInRect(context,self.myroom.rect);
    CGContextDrawPath(context, kCGPathFill);
    
    
    CGContextRestoreGState(context);
    
    // Drawing code
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
