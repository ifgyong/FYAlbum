//
//  FYPhotoInAssetViewController.m
//  FYPlayer
//
//  Created by Charlie on 16/4/21.
//  Copyright © 2016年 www.fgyong.cn. All rights reserved.
//

#import "FYPhotoInAssetViewController.h"
#import "FYAlbumAssetCell.h"
#import "FadeOutView.h"

#define kCollectionCellHeight kScreenWidth/4

@interface FYPhotoInAssetViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
/**
 *  视图collectionview
 */
@property (nonatomic,strong) UICollectionView * collectionView;
/**
 *  数据源
 */
@property (nonatomic,strong) NSMutableArray *dataArray;
/**
 *  记录选择的index
 */
@property (nonatomic,strong) NSMutableArray * dataSelected;
@end

@implementation FYPhotoInAssetViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray =[NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)dataSelected{
    if (_dataSelected == nil) {
        _dataSelected =[NSMutableArray array];
    }
    return _dataSelected;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubView];
    [self fetassetList];
    
}
- (void)fetassetList{
    PHFetchOptions * ops =[[PHFetchOptions alloc]init];
    ops.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult <PHAsset *> * result =[PHAsset fetchAssetsInAssetCollection:self.assetCollection
                                                                      options:ops];
    [result enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataArray addObject:obj];
        [self.collectionView reloadData];
    }];
}
- (void)addSubView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((kScreenWidth-9)/4, (kScreenWidth-9)/4);
    layout.minimumInteritemSpacing = 1.5;
    layout.minimumLineSpacing = 1.5;
    layout.sectionInset = UIEdgeInsetsMake(3, 0, 3, 0);
    
    
    self.collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth , kScreenHeight - 45) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate   = self ;
    self.collectionView.backgroundColor =[UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"FYAlbumAssetCell" bundle:nil] forCellWithReuseIdentifier:@"AlbumCell"];
    
    [self.view addSubview:self.collectionView];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self setRightBarButtonItem];
    
    UIView * bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 45, kScreenWidth, 45)];
    bottomView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIButton * sendBtn =[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 65, 0, 60, 45)];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor colorWithRed:26/255.0 green:177/255.0 blue:10/255.0 alpha:1] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sendBtn];
    
}
- (void)setRightBarButtonItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(cancel)];
}
- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)done{
    
    NSMutableArray * mutArray =[NSMutableArray array];
    PHImageManager * manager =[PHImageManager defaultManager];
    PHImageRequestOptions * ops =[[PHImageRequestOptions alloc]init];
    ops.synchronous = YES;
    
    for (NSIndexPath * item in self.dataSelected) {
        PHAsset * asset = self.dataArray[item.row];
        [manager requestImageForAsset:asset
                           targetSize:PHImageManagerMaximumSize
                          contentMode:PHImageContentModeDefault
                              options:ops
                        resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                            [mutArray addObject:result];
                        }];
    }
    if (self.complateBlock) {
        self.complateBlock(mutArray);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return   self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PHAsset * asset =[self.dataArray objectAtIndex:indexPath.row];
    
    FYAlbumAssetCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumCell" forIndexPath:indexPath];
    cell.selectedStatus = [self contains:indexPath];
    
    PHImageManager * imageManager =[PHImageManager defaultManager];
    [imageManager requestImageForAsset:asset
                            targetSize:CGSizeMake(kCollectionCellHeight*2, kCollectionCellHeight*2)
                           contentMode:PHImageContentModeAspectFill options:nil
                         resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                             cell.imageView.image = result;
                         }];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FYAlbumAssetCell * cell =  (FYAlbumAssetCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([self moreThanMaxSelect] == NO && !cell.selectedStatus) {
            cell.selectedStatus = !cell.selectedStatus;
    }else if (cell.selectedStatus){
        cell.selectedStatus = !cell.selectedStatus;
    } else if ([self moreThanMaxSelect]){
        NSString * message =[NSString stringWithFormat:@"最多选择%ld张照片哦",(long)self.maxSelected];
        showFadeOutView(message, NO, 1);
    }
    [self updateSelectedAsset:indexPath selected:cell.selectedStatus];
}
- (void)updateSelectedAsset:(NSIndexPath *)indexPath selected:(BOOL)select{
    if (select) {
        if ([self contains:indexPath] == NO) {
            if (self.dataSelected.count < self.maxSelected) {
                [self.dataSelected addObject:indexPath];
                return;
            }
        }
    } else { // 删除index
            for (int i = (int) self.dataSelected.count-1; i >= 0; i --) {
                NSIndexPath * item = self.dataSelected[i];
                if (item.row == indexPath.row) {
                    [self.dataSelected removeObject:item];
                    break;
                }
            }
    }
}
- (BOOL)contains:(NSIndexPath *)indexPath{
    for (NSIndexPath * item in self.dataSelected) {
        if (item.row == indexPath.row) {
            return YES;
        }
    }
    return NO;
}
- (BOOL)moreThanMaxSelect{
    BOOL more = self.maxSelected <= self.dataSelected.count;
    return more ;
}
@end
