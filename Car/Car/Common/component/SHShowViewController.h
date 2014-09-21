//
//  SHShowViewController.h
//  Zambon
//
//  Created by sheely on 13-9-5.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import "SHViewController.h"

@interface SHShowViewController : SHViewController
{
    UILabel * mLabel;
}
@property  (nonatomic,strong)IBOutlet UILabel * labTitle;
@property (nonatomic,strong) NSString * title;
@end
