//
//  FYAlbumManager.h
//  FYAlbumDemo
//
//  Created by Charlie on 16/4/21.
//  Copyright © 2016年 www.fgyong.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^complateBlock)(NSArray *imagesArray) ;
@interface FYAlbumManager : NSObject <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/**
 *  可以选择的最大数量
 */
@property (nonatomic,assign) NSInteger maxSelect;
/**
 *  选择完照片回调
 */

@property (nonatomic,copy) complateBlock complate;
+ (instancetype)shareAlbumManager;

- (void)showInView:(UIViewController *)view;
@end
