//
//  FadeOutView.h
//  iddressbook
//
//  Created by 谌启亮 on 10-11-26.
//  Copyright 2010 Digisys Information. All rights reserved.
//

#import <UIKit/UIKit.h>

void showFadeOutView(NSString *text, BOOL success, NSTimeInterval d);
void showFadeOutText(NSString *text, CGFloat offsetY,  NSTimeInterval interval);
void showFadeoutImageWithText(NSString *text, UIImage *image, NSTimeInterval interval);

@interface FadeOutView : UIWindow {
    UIImageView *imageView;
    UILabel *label;
    NSTimeInterval delay;
}

- (id)init;
- (id)initWithText:(NSString*)text isSuccess:(BOOL)success delay:(NSTimeInterval)d;
- (id)initWithText:(NSString *)text offsetY:(CGFloat)offsetY delay:(NSTimeInterval)interval;
- (id)initWithText:(NSString*)text image:(UIImage*)image delay:(NSTimeInterval)d;
- (void)show;


@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *label;

@end
