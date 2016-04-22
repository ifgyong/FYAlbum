//
//  FYPhotoCollectionsViewController.h
//  FYPlayer
//
//  Created by Charlie on 16/4/21.
//  Copyright © 2016年 www.fgyong.cn. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "FYPhotoInAssetViewController.h"

typedef void(^complateBlock)(NSArray *imagesArray) ;

@interface FYPhotoCollectionsViewController : UIViewController

@property (nonatomic,assign) NSInteger maxSelected;
@property (nonatomic,copy) complateBlock complate;

- (void)complateBlock:(complateBlock)block;

@end
