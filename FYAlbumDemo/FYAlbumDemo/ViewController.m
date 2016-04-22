//
//  ViewController.m
//  FYAlbumDemo
//
//  Created by Charlie on 16/4/21.
//  Copyright © 2016年 www.fgyong.cn. All rights reserved.
//

#import "ViewController.h"
#import "FYPhotoCollectionsViewController.h"
#import "FYAlbumManager.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,copy) UIScrollView * scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * btn =[[UIButton alloc]initWithFrame:CGRectMake(10, 100, kScreenWidth - 20, 40)];
    [btn setTitle:@"添加照片" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn  setClipsToBounds:YES];
    btn .layer.cornerRadius = 5;
    btn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    btn.layer.borderWidth = 1;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
     _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(10, 200, kScreenWidth - 20, 200)];
    [self.view addSubview:_scrollView];
}
- (void)click{
    FYAlbumManager * manager =[FYAlbumManager shareAlbumManager];
    manager.maxSelect = 10;
    manager.complate = ^(NSArray *array){
                _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame) * array.count, 200);
                _scrollView.pagingEnabled = YES;
                for (int i = 0; i < array.count; i ++) {
                    UIImageView  * view =[[UIImageView alloc]initWithImage:array[i]];
                    view.frame = CGRectMake(i * (kScreenWidth-20), 0, kScreenWidth, 200);
                    view.contentMode = UIViewContentModeScaleAspectFill;
                    view.clipsToBounds = YES;
                    [_scrollView addSubview:view];
                }};
    [manager showInView:self];
}

@end
