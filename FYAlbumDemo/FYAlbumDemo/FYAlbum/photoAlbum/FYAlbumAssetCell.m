//
//  FYAlbumAssetCell.m
//  FYPlayer
//
//  Created by Charlie on 16/4/21.
//  Copyright © 2016年 www.fgyong.cn. All rights reserved.
//

#import "FYAlbumAssetCell.h"

@implementation FYAlbumAssetCell

- (void)awakeFromNib {
     
}

- (void)setSelectedStatus:(BOOL)selectedStatus{
        _selectedStatus             = selectedStatus;
        self.seletcImageView.hidden = !selectedStatus;
        self.seletcView.hidden      = !selectedStatus;
}
@end
