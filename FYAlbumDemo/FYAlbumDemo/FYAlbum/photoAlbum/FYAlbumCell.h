//
//  FYAlbumCell.h
//  FYPlayer
//
//  Created by Charlie on 16/4/20.
//  Copyright © 2016年 www.fgyong.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYAlbumCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headView;
@end
