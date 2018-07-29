//
//  ExtraSortTitleView.h
//  ExtraSortTitleViewDemo
//
//  Created by 叶达逸 on 2018/7/29.
//  Copyright © 2018年 叶达逸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExtraSortTitleViewStyle.h"

@protocol ExtraSortTitleViewDelegate <NSObject>

- (void)titleLabelClickedWithCurrentIndex:(NSInteger)currentIndex;

@end

@interface ExtraSortTitleView : UIView

@property (nonatomic, weak) id<ExtraSortTitleViewDelegate> delegate;

- (instancetype)initWithDefaultStyleAndFrame:(CGRect)frame AndTitles:(NSArray *)titles;

- (instancetype)initWithFrame:(CGRect)frame AndStyle:(ExtraSortTitleViewStyle *)style AndTitles:(NSArray *)titles;

@end
