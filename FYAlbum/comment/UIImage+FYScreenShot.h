//
//  UIImage+FYScreenShot.h
//  FYPlayer
//
//  Created by Charlie on 16/4/19.
//  Copyright © 2016年 www.fgyong.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface UIImage (FYScreenShot)
/**
 *  获取视频的截图
 *
 *  @param videoURL 视频 的url
 *  @param attime   截图地址
 *
 *  @return
 */
+(UIImage *)getImage:(NSString *)videoURL atTimes:(NSInteger)attime;

/**
 *  获取视频的截图
 *
 *  @param videoURL 视频 的url
 *  @param attime   截图地址
 *
 *  @return
 */
+(UIImage *)getImageUrlAset:(AVURLAsset *)videoURL atTimes:(NSInteger)attime;
@end
