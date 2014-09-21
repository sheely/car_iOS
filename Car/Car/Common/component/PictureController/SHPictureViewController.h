//
//  SHPictureViewController.h
//  Zambon
//
//  Created by sheely on 13-12-3.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import "SHViewController.h"

@interface SHPictureViewController : SHViewController
{
    __weak IBOutlet SHImageView *mImageView;
}

- (IBAction)btnImageOnTOuch:(id)sender;

@property (weak, nonatomic) IBOutlet SHImageView *imgView;
- (void)showIn:(UIView *)view;
@end
