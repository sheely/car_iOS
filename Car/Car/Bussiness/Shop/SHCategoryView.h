//
//  SHCategoryView.h
//  Car
//
//  Created by sheely.paean.Nightshade on 10/28/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHView.h"

@interface SHCategoryView : SHView

@property (nonatomic,assign)BOOL selected;
@property (weak, nonatomic) IBOutlet UIButton *btnTitle;
@end
