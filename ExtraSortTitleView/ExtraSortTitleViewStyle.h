//
//  ExtraSortTitleViewStyle.h
//  ExtraSortTitleViewDemo
//
//  Created by 叶达逸 on 2018/7/29.
//  Copyright © 2018年 叶达逸. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ExtraSortTitleViewStyle : NSObject
@property (nonatomic,assign) CGFloat titleHeight;
@property (nonatomic,assign) CGFloat bottomLineHeight;
@property (nonatomic,strong) UIColor *normalColor;
@property (nonatomic,strong) UIColor *selectColor;
@property (nonatomic,strong) UIColor *bottomLineColor;
@property (nonatomic,assign) CGFloat fontSize;
// 是否可以滚动 如果设置no  则 frame的宽度会被等分  使用场景为宽度较大 但标题 数量较少的情况
@property (nonatomic,assign) BOOL isScrollEnable;
@property (nonatomic,assign) CGFloat titleMargin;
// 动画时间。 0则没有动画
@property (nonatomic,assign) NSTimeInterval animateWithDuration;
// 是否显示下划线
@property (nonatomic,assign) BOOL isShowBottomLine;
// 显示的下划线 长度是否和文字长度一致。
@property (nonatomic,assign) BOOL isBottomLineEqualLabelTextlength;
// 下划线 长度左右调整 默认为 0    长度会被平均加在左右两侧
@property (nonatomic,assign) CGFloat bottomLineAdjustmentlength;
@end
