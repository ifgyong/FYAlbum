//
//  FadeOutView.m
//  iddressbook
//
//  Created by 谌启亮 on 10-11-26.
//  Copyright 2010 Digisys Information. All rights reserved.
//

#import "FadeOutView.h"
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#import <QuartzCore/QuartzCore.h>

void showFadeOutView(NSString *text, BOOL success, NSTimeInterval d){
    FadeOutView *fadeOutView = [[FadeOutView alloc] initWithText:text isSuccess:success delay:d];
    [fadeOutView show];
}

void showFadeOutText(NSString *text, CGFloat offsetY,  NSTimeInterval interval) {
    FadeOutView *fadeOutView = [[FadeOutView alloc] initWithText:text offsetY:offsetY delay:interval];
    [fadeOutView show];
}

void showFadeoutImageWithText(NSString *text, UIImage *image, NSTimeInterval interval) {
    FadeOutView *fadeOutView = [[FadeOutView alloc] initWithText:text image:image delay:interval];
    [fadeOutView show];
}

@implementation FadeOutView
@synthesize label,imageView;

- (id)initWithText:(NSString *)text offsetY:(CGFloat)offsetY delay:(NSTimeInterval)interval{
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)]) {
        self.windowLevel = UIWindowLevelAlert;
//        CGSize textSize = [text sizeWithFont:[UIFont boldSystemFontOfSize:13] constrainedToSize:CGSizeMake(kScreenWidth, 20) lineBreakMode:NSLineBreakByWordWrapping];
        
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(kScreenWidth, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13]} context:nil].size;
        
        int labelWidth = textSize.width+20;
        delay = interval;
        if (offsetY == 0) {
            offsetY = 380;
        }
        self.imageView = NULL;
        self.label = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-labelWidth)/2, offsetY, labelWidth, 30)];
        label.numberOfLines = 1;
        label.backgroundColor = [UIColor blackColor];
        label.alpha = 0.75;
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label.layer.cornerRadius = 5;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:13];
        label.text = text;
        label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:label];
    }
    return self;
}

- (id)init{
    return [self initWithText:nil isSuccess:YES delay:1];
}

- (id)initWithText:(NSString*)text image:(UIImage*)image delay:(NSTimeInterval)d {
    if ((self = [super initWithFrame:CGRectMake(0, 0, 140, 130)])) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
        self.layer.cornerRadius = 5;
        self.windowLevel = UIWindowLevelAlert;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 140, 60)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = image;
        imageView.autoresizingMask = UIViewContentModeLeft|UIViewContentModeRight;
        delay = d;
        //imageView.contentMode = UIViewContentModeCenter;
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 120, 48)];
        label.numberOfLines = 2;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:12];
        label.text = text;
        label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:imageView];
        [self addSubview:label];
    }
    return self;
}


- (id)initWithText:(NSString*)text isSuccess:(BOOL)success delay:(NSTimeInterval)d {
    if ((self = [super initWithFrame:CGRectMake(0, 0, 160, 60)])) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
        self.layer.cornerRadius = 5;
        self.windowLevel = UIWindowLevelAlert;
        //self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 140, 60)];
        //imageView.backgroundColor = [UIColor clearColor];
        if (success) {
            //imageView.image = [UIImage imageNamed:@"tishi_xiaolian.png"];
        }
        else {
            //imageView.image = [UIImage imageNamed:@"tishi_shiwanglian.png"];
        }
        delay = d;
        imageView.contentMode = UIViewContentModeCenter;
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 140, 60)];
        label.numberOfLines = 2;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:14];
        label.text = text;
        label.adjustsFontSizeToFitWidth = YES;
        //[self addSubview:imageView];
        [self addSubview:label];
    }
    return self;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)fadeOut{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        //[self release];
    }];
}


- (void)show{
    self.hidden = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(fadeOut) object:nil];
    [self performSelector:@selector(fadeOut) withObject:nil afterDelay:delay];
    self.frame = CGRectMake(0, 0, 160, 60);
    self.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(fadeOut) object:nil];
    [self fadeOut];
}

- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

@end
