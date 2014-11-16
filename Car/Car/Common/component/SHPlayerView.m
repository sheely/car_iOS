//
//  SHPlayerView.m
//  Car
//
//  Created by sheely.paean.Nightshade on 14/11/9.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHPlayerView.h"
#import <AVFoundation/AVFoundation.h>

@implementation SHPlayerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
    if(self.btnPlay == nil){
        self.btnPlay = [[UIButton alloc]initWithFrame:self.bounds];
        [self.btnPlay addTarget:self action:@selector(btnPlayOnTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnPlay setImage: [UIImage imageNamed:@"icon_play_com.png" ] forState:UIControlStateNormal];
        [self addSubview:self.btnPlay];
    }
}

- (void)setUrl:(NSString *)url_
{
    SHHttpTask* taskDefaultImag= [[SHHttpTask alloc]init];
    taskDefaultImag.URL = url_;
    taskDefaultImag.cachetype = CacheTypeTimes;
    self.urlTask = taskDefaultImag;
    self.urlTask.delegate = self;
    [self.urlTask start];
}

- (void)taskDidFinished:(SHTask *)task
{
    
//    if ([task.result isKindOfClass:[NSDate class]] || [task.result isKindOfClass:[NSMutableData class]]){
    
    NSError * outError;
    player = [[AVAudioPlayer alloc] initWithData:(NSData*)task.result error:&outError];
    player.volume = 1.0;
    player.delegate = self;
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategorySoloAmbient error: nil];
    [player prepareToPlay];
}
- (void) taskDidFailed:(SHTask *)task
{
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.btnPlay setImage: [UIImage imageNamed:@"icon_play_com.png" ] forState:UIControlStateNormal];
}

- (IBAction)btnPlayOnTouch:(id)sender {
    if(player.isPlaying){
        [self.btnPlay setImage: [UIImage imageNamed:@"icon_play_com.png" ] forState:UIControlStateNormal];

        [player stop];
    }else{
        [self.btnPlay setImage: [UIImage imageNamed:@"icon_stop_com.png" ] forState:UIControlStateNormal];

        [player play];
    }
}
@end
