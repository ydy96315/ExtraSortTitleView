//
//  ExtraSortTitleViewStyle.m
//  ExtraSortTitleViewDemo
//
//  Created by 叶达逸 on 2018/7/29.
//  Copyright © 2018年 叶达逸. All rights reserved.
//

#import "ExtraSortTitleViewStyle.h"

@implementation ExtraSortTitleViewStyle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleHeight = 40;
        self.bottomLineHeight = 2;
        self.normalColor = [UIColor blackColor];
        self.selectColor = [UIColor redColor];
        self.bottomLineColor = [UIColor redColor];
        self.fontSize = 14;
        self.isScrollEnable = YES;
        self.titleMargin = 20;
        self.isShowBottomLine = YES;
        self.isBottomLineEqualLabelTextlength = NO;
        self.bottomLineAdjustmentlength = 0;
        self.animateWithDuration = 0.25;
    }
    return self;
}
@end
