//
//  MyView.m
//  AutoLayout
//
//  Created by mfw on 14-10-11.
//  Copyright (c) 2014年 MFW. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (id)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(0, 100); //controll设置了left以及right，故这里的width没效果
}

@end
