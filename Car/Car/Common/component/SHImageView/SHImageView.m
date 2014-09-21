//
//  SHImageView.m
//  Zambon
//
//  Created by sheely on 13-9-18.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import "SHImageView.h"

@implementation SHImageView
@synthesize urlTask = _urlTask;

- (id)init
{
    if(self = [super init]){
        [self initComponent];
    }
    return self;
}

- (void)awakeFromNib
{
    [self initComponent];
}

- (void)initComponent
{
    mIndicatorview = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)UIActivityIndicatorViewStyleWhite];
    [self addSubview:mIndicatorview];
    mIndicatorview.hidesWhenStopped = YES;
    mIndicatorview.frame = CGRectMake(self.frame.size.width/2  - 10, self.frame.size.height/2 - 10, 20, 20);
    mIndicatorview.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)setUrl:(NSString *)url_ args:(NSString*) idvalue
{
    
    SHPostTaskM* taskDefaultImag= [[SHPostTaskM alloc]init];
    taskDefaultImag.URL = url_;
    [taskDefaultImag.postArgs setValue:idvalue forKey:@"id"];
    taskDefaultImag.cachetype = CacheTypeTimes;
    self.urlTask = taskDefaultImag;
    
}

- (void)setUrlTask:(SHTask *)urlTask
{
    _urlTask = urlTask;
    if(_urlTask){
        [mIndicatorview startAnimating];
        _urlTask.delegate = self;
        [_urlTask start];
    }else{
        _urlTask.delegate = Nil;
    }
}

- (void)setUrl:(NSString *)url_
{
    SHHttpTask* taskDefaultImag= [[SHHttpTask alloc]init];
    taskDefaultImag.URL = url_;
    taskDefaultImag.cachetype = CacheTypeTimes;
    self.urlTask = taskDefaultImag;
}

- (void)taskDidFinished:(SHTask *)task
{
    if([task.result isKindOfClass:[NSDictionary class]] || [task.result isKindOfClass:[NSMutableDictionary class]]){
        NSDictionary * result = (NSDictionary*)task.result;
        NSString * base64 =[result valueForKey:@"image"];
        //[base64 cStringUsingEncoding:NSASCIIStringEncoding];
        NSData * data = [Base64 decode:base64];
        self.mark = [result valueForKey:@"description"];
        self.image = [[UIImage alloc]initWithData:data];
        if (self.delegate && [self.delegate respondsToSelector:@selector(imageViewDidLoadFinished:)]) {
            [self.delegate imageViewDidLoadFinished:self];
        }
    }else if ([task.result isKindOfClass:[NSDate class]] || [task.result isKindOfClass:[NSMutableData class]]){
        
  
        
        self.image = [[UIImage alloc]initWithData:(NSData *)task.result];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(imageViewDidLoadFinished:)]) {
            [self.delegate imageViewDidLoadFinished:self];
        }
    }else{
        @try{
            self.image = [[UIImage alloc]initWithData:(NSData *)task.result];
            if (self.delegate && [self.delegate respondsToSelector:@selector(imageViewDidLoadFinished:)]) {
                [self.delegate imageViewDidLoadFinished:self];
            }
        }
        @catch (NSException * e) {
            
        }
    }
    [mIndicatorview stopAnimating];
}
- (void) taskDidFailed:(SHTask *)task
{
    [mIndicatorview stopAnimating];
}
@end
