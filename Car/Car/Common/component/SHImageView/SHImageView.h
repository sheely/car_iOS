//
//  SHImageView.h
//  Zambon
//
//  Created by sheely on 13-9-18.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHImageView.h"
#import "Core.h"
@class SHImageView;

@protocol SHImageViewDelegate<NSObject>

- (void) imageViewDidLoadFinished:(SHImageView*) imageview;

@end

@interface SHImageView : UIImageView <SHTaskDelegate>
{
    UIActivityIndicatorView * mIndicatorview ;
}
@property (nonatomic,strong) SHTask* urlTask;
@property (nonatomic,assign) id<SHImageViewDelegate> delegate;
@property (nonatomic,copy) NSString * mark;

- (void)setUrl:(NSString *)url_ args:(NSString*) idvalue;
- (void)setUrl:(NSString *)url_;
@end
