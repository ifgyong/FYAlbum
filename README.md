# FYAlbum
一个选择照片的选择器，简单易用。
使用平台 iOS8以上


# 使用之前需要导入Photo.framework 
# 使用例子

```
FYAlbumManager * manager =[FYAlbumManager shareAlbumManager];
    manager.maxSelect = 10; //一次性最多选择的相片数量
    manager.complate = ^(NSArray *array){//选完照片回调函数。
                //do something array obj is image.
                }};
    [manager showInView:self];

```

# Installation
Use cocoapods

```
pod 'FYAlbum'
```

# license
MIT
