//
//  FYAlbumAssetCell.h
//  FYPlayer
//
//  Created by Charlie on 16/4/21.
//  Copyright © 2016年 www.fgyong.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYAlbumAssetCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@property (weak, nonatomic) IBOutlet UIView *seletcView;

@property (weak, nonatomic) IBOutlet UIImageView *seletcImageView;

@property (nonatomic,assign) BOOL selectedStatus;
@end
