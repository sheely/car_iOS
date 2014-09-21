//
//  UIBarButtonItemAddtion.h
//  Zambon
//
//  Created by sheely on 13-9-7.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIBarButtonItem (sheely)

- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;

- (id)initWithImage:(UIImage *)image target:(id)target action:(SEL)action;

- (id)initWithCancel:(id)target action:(SEL)action;

- (id)initWithSubmit:(id)target action:(SEL)action;

- (id)initWithImage:(UIImage *)image title:(NSString*) title target:(id)target action:(SEL)action;
@end
