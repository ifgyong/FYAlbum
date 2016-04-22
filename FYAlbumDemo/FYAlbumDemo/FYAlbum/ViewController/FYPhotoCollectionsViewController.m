//
//  FYPhotoCollectionsViewController.m
//  FYPlayer
//
//  Created by Charlie on 16/4/21.
//  Copyright © 2016年 www.fgyong.cn. All rights reserved.
//

 
//
#import <Photos/Photos.h>
#import "UIImage+FYScreenShot.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "FYAlbumCell.h"
#import "FYPhotoCollectionsViewController.h"
#import "FadeOutView.h"

@interface FYPhotoCollectionsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation FYPhotoCollectionsViewController
- (void)dealloc{
    
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight )];
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"FYAlbumCell" bundle:nil] forCellReuseIdentifier:@"cell" ];
    }
    return _tableView;
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self setTitle:@"相册"];
    [self setRightBarButtonItem];
    [self addObserver];
    [self videos];
    
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
- (void)addObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self
           forKeyPath:@"dataArray"
              options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
              context:nil];
}
- (void)editTableView{
    
    [self.tableView  setEditing:!self.tableView.editing animated:YES];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"dataArray"]) {
        [self.tableView reloadData];
    }
}
- (void)videos{
    
    PHAuthorizationStatus status =[PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined ) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                NSLog(@"access");
                [self getAlbumList];
            } else {
                showFadeOutView(@"在设置里面设置可以读取相册权限哦", NO, 1);
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    } else {
        [self getAlbumList];
    }
    //PHAssetCollectionSubtypeSmartAlbumVideos
}
- (void)getAlbumList{
    [self addLibalumType:PHAssetCollectionTypeSmartAlbum
                 subType:PHAssetCollectionSubtypeAlbumRegular];
    [self addLibalumType:PHAssetCollectionTypeAlbum
                 subType:PHAssetCollectionSubtypeSmartAlbumUserLibrary];
}
- (void)addLibalumType:(PHAssetCollectionType)type  subType:(PHAssetCollectionSubtype)subtype{
    PHFetchResult * result =[PHAssetCollection fetchAssetCollectionsWithType:type
                                                                     subtype:subtype
                                                                     options:nil ];
    [result enumerateObjectsUsingBlock:^(PHAssetCollection *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.localizedTitle ) {
            NSLog(@"biaoshi:%@",obj.localizedTitle);
        }
        PHFetchResult <PHAsset *> * result =[PHAsset  fetchAssetsInAssetCollection:obj
                                                                           options:nil];
        if (result.count) {
            [[self mutableArrayValueForKey:@"dataArray"] addObject:obj];
        }
    }];
    
}
- (NSString *)transformAblumTitle:(NSString *)title
{
    if ([title isEqualToString:@"Slo-mo"]) {
        return @"慢动作";
    } else if ([title isEqualToString:@"Recently Added"]) {
        return @"最近添加";
    } else if ([title isEqualToString:@"Favorites"]) {
        return @"最爱";
    } else if ([title isEqualToString:@"Recently Deleted"]) {
        return @"最近删除";
    } else if ([title isEqualToString:@"Videos"]) {
        return @"视频";
    } else if ([title isEqualToString:@"All Photos"]) {
        return @"所有照片";
    } else if ([title isEqualToString:@"Selfies"]) {
        return @"自拍";
    } else if ([title isEqualToString:@"Screenshots"]) {
        return @"屏幕快照";
    } else if ([title isEqualToString:@"Camera Roll"]) {
        return @"相机胶卷";
    } else if ([title isEqualToString:@"Panoramas"]) {
        return @"全景照片";
    } else if ([title isEqualToString:@"My Photo Stream"]){
        return @"我的照片";
    }
    
    return title;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 102.5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FYAlbumCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //  PHAsset * localasset = _dataArray[indexPath.row];
    PHAssetCollection *localasset = _dataArray[indexPath.row];
    PHImageManager * imageManager =[PHImageManager defaultManager];
    PHImageRequestOptions * request =[[PHImageRequestOptions alloc]init];
    request.synchronous = NO;
    
    PHFetchResult <PHAsset *> * result =[PHAsset fetchAssetsInAssetCollection:localasset
                                                                      options:nil];
    
    
    
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            PHAsset * asset = obj;
            
            [imageManager requestImageForAsset:asset
                                    targetSize:CGSizeMake(200, 200)
                                   contentMode:PHImageContentModeAspectFill
                                       options:request
                                 resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                     cell.imageView.image = result;
                                 }];
        }
    }];
    NSString * title = [self transformAblumTitle:localasset.localizedTitle];
    
    cell.timeLabel.text = [NSString stringWithFormat:@"%@", title];
    cell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)result.count];
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PHAssetCollection * collection = _dataArray[indexPath.row];
    FYPhotoInAssetViewController * assetList=[[FYPhotoInAssetViewController alloc]init];
    assetList.assetCollection = collection;
    assetList.maxSelected = self.maxSelected;
    assetList.complateBlock = self.complate;
    [self.navigationController pushViewController:assetList animated:YES];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}
- (UITableViewCellEditingStyle )tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)complateBlock:(complateBlock)block{
    self.complate = block;
}
@end

