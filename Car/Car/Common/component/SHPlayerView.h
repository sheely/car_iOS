//
//  SHPlayerView.h
//  Car
//
//  Created by sheely.paean.Nightshade on 14/11/9.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHView.h"
#import <AVFoundation/AVFoundation.h>

@interface SHPlayerView : SHView<AVAudioPlayerDelegate>
{
    AVAudioPlayer * player;
}
- (void)setUrl:(NSString *)url_;
@property (strong,nonatomic) SHHttpTask* urlTask;
@property (strong, nonatomic) IBOutlet UIButton *btnPlay;
- (IBAction)btnPlayOnTouch:(id)sender;
@end
