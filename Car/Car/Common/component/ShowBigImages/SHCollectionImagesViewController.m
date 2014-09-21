//
//  ShCollectionImagesViewController.m
//  crowdfunding-arcturus
//
//  Created by lqh77 on 14-5-27.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import "SHCollectionImagesViewController.h"

@interface SHCollectionImagesViewController ()

@end

@implementation SHCollectionImagesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"图片集";
    
   currentIndex = [[self.intent.args valueForKey:@"currentIndex"] intValue];
    
    big_imageArray=[self.intent.args valueForKey:@"images"];
  
    _listScrollView.userInteractionEnabled=YES;
    [self createAllSmallIcon];
    
  //  [csView pageTurn:currentIndex];
}


-(void)createAllSmallIcon{

    if ([big_imageArray count]>12) {
        
        int n= [big_imageArray count]/3+1;
        
        [_listScrollView  setContentSize:CGSizeMake(320, 20+(85+20)*n)];
        
    }else{
    
       // [_listScrollView  setContentSize:CGSizeMake(320, 20+(85+10)*4)];
         [_listScrollView  setContentSize:CGSizeMake(320, 568)];

    }
 
   
    // 1.创建多个UIImageView
    UIImage *placeholder = [UIImage imageNamed:@"timeline_image_loading.png"];
    CGFloat width = 85;
    CGFloat height = 85;
    CGFloat margin = 10;
    CGFloat startX = (self.view.frame.size.width - 3 * width - 2 * margin) * 0.5;
    CGFloat startY = 20;
    for (int i = 0; i<[big_imageArray count]; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [_listScrollView addSubview:imageView];
        
        // 计算位置
        int row = i/3;
        int column = i%3;
        CGFloat x = startX + column * (width + margin);
        CGFloat y = startY + row * (height + margin);
        imageView.frame = CGRectMake(x, y, width, height);
        
        // 下载图片
        [imageView setImageURLStr:big_imageArray[i] placeholder:placeholder];
        
        // 事件监听
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
    }


}


- (void)tapImage:(UITapGestureRecognizer *)tap
{
    int count = big_imageArray.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = [big_imageArray[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        //photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
        photo.srcImageView=_listScrollView.subviews[i];
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark BestView Delegate Data=source

- (NSInteger)numberOfPages
{
    
    return [big_imageArray count];
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    
    SHImageView  *imageView=[[SHImageView alloc]  initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
 
    [imageView setUrl:[big_imageArray objectAtIndex:index]];
   
    
    return imageView;
}



@end
