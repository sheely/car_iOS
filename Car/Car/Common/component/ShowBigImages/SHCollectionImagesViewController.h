//
//  ShCollectionImagesViewController.h
//  crowdfunding-arcturus
//
//  Created by lqh77 on 14-5-27.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import "SHViewController.h"
// 新加 多个图片 轮流展示

#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface SHCollectionImagesViewController : SHViewController

{

    NSMutableArray  *big_imageArray;
    NSInteger currentIndex;
    
}

@property(nonatomic,weak)  NSMutableArray  *big_imageArray;
@property(nonatomic,weak)  IBOutlet UIScrollView  *listScrollView;
@property(nonatomic,assign) NSInteger currentIndex;


@end
