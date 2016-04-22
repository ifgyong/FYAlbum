//
//  UIImage+FYScreenShot.m
//  FYPlayer
//
//  Created by Charlie on 16/4/19.
//  Copyright © 2016年 www.fgyong.cn. All rights reserved.
//

#import "UIImage+FYScreenShot.h"
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (FYScreenShot)
+(UIImage *)getImage:(NSString *)videoURL atTimes:(NSInteger)attime

{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoURL] options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(attime * 600, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;
    
}
+(UIImage *)getImageUrlAset:(AVURLAsset *)videoURL atTimes:(NSInteger)attime;{
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:videoURL];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(attime * 600, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;
}
@end
