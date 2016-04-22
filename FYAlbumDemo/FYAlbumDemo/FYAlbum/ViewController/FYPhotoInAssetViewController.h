//
//  FYPhotoInAssetViewController.h
//  FYPlayer
//
//  Created by Charlie on 16/4/21.
//  Copyright © 2016年 www.fgyong.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define COLORRGB(a,b,c)  [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]
typedef void(^complateBlock)(NSArray *imagesArray) ;
@interface FYPhotoInAssetViewController : UIViewController

@property (nonatomic,strong) PHAssetCollection * assetCollection;

@property (nonatomic,assign) NSInteger maxSelected;

@property (nonatomic,copy) complateBlock complateBlock;

@end
