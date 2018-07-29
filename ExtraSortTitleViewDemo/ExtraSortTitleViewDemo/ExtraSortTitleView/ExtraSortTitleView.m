//
//  ExtraSortTitleView.m
//  ExtraSortTitleViewDemo
//
//  Created by 叶达逸 on 2018/7/29.
//  Copyright © 2018年 叶达逸. All rights reserved.
//

#import "ExtraSortTitleView.h"
#import "UIView+ExtraViewExtension.h"

@interface ExtraSortTitleView()
@property (nonatomic,strong) ExtraSortTitleViewStyle *style;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *titlesLabelArr;
@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,assign) NSInteger currentIndex;
@end

@implementation ExtraSortTitleView
- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = self.style.bottomLineColor;
        _bottomLine.height = self.style.bottomLineHeight;
        _bottomLine.y = self.bounds.size.height - self.style.bottomLineHeight;
    }
    
    return _bottomLine;
}

- (NSMutableArray *)titlesLabelArr
{
    if (!_titlesLabelArr) {
        _titlesLabelArr = [NSMutableArray array];
    }
    return _titlesLabelArr;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.scrollsToTop = false;
    }
    return _scrollView;
}
- (instancetype)initWithDefaultStyleAndFrame:(CGRect)frame AndTitles:(NSArray *)titles{
    
    return [self initWithFrame:frame AndStyle:[[ExtraSortTitleViewStyle alloc] init] AndTitles:titles];
    
}
- (instancetype)initWithFrame:(CGRect)frame AndStyle:(ExtraSortTitleViewStyle *)style AndTitles:(NSArray *)titles{
    _style = style;
    _titles = titles;
    
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
        [self setupTitleLabels];
        [self setupLabelsFrame];
        [self setupBottomLine];
        self.currentIndex = 0;
    }
    
    return self;
}

- (void)setupTitleLabels{
    
    for (int i = 0; i < self.titles.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.tag = i;
        label.text = self.titles[i];
        label.textColor = i == 0 ? self.style.selectColor : self.style.normalColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:self.style.fontSize];
        [self.scrollView addSubview:label];
        [self.titlesLabelArr addObject:label];
        
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClick:)];
        [label addGestureRecognizer:tgr];
        label.userInteractionEnabled = YES;
    }
}

- (void)setupLabelsFrame{
    CGFloat labelH = self.style.titleHeight;
    CGFloat labelY = 0;
    CGFloat labelW = 0;
    CGFloat labelX = 0;
    
    for (int i = 0; i < self.titlesLabelArr.count; i++) {
        UILabel *titleLabel = self.titlesLabelArr[i];
        if (self.style.isScrollEnable) { // 可以滚动
            
            NSString *title = self.titles[i];
            
            labelW = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.style.titleHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleLabel.font} context:nil].size.width;
            UILabel *preLabel = i == 0 ? nil : self.titlesLabelArr[i-1];
            labelX = i == 0 ? self.style.titleMargin * 0.5 : (preLabel.frame.origin.x + preLabel.frame.size.width + self.style.titleMargin);
        } else { // 不可以滚动
            labelW = self.bounds.size.width / self.titlesLabelArr.count;
            labelX = labelW * i;
        }
        titleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
//        NSLog(@"%@",NSStringFromCGRect(titleLabel.frame));
        
    }
    if (self.style.isScrollEnable) {
        UILabel *lsatTitleLabel = self.titlesLabelArr.lastObject;
        self.scrollView.contentSize =  CGSizeMake(lsatTitleLabel.frame.origin.x + lsatTitleLabel.frame.size.width + self.style.titleMargin * 0.5, self.bounds.size.height);
    }
    
}

- (void)setupBottomLine{
    // 判断是否需要显示BottomLine
    if(!self.style.isShowBottomLine) {
        return;
    }
    
    // 2.将bottomLine添加到scrollView中
    [self.scrollView addSubview:self.bottomLine];
    
    // 3.设置bottomLine的frame中的属性
    UILabel *titleLabel = self.titlesLabelArr[0];
    
    if (self.style.isBottomLineEqualLabelTextlength) {
        CGFloat labelTextW = [titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.style.titleHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleLabel.font} context:nil].size.width;
        
        self.bottomLine.x = (titleLabel.x + (titleLabel.width - labelTextW) / 2) - self.style.bottomLineAdjustmentlength / 2;
        self.bottomLine.width = labelTextW + self.style.bottomLineAdjustmentlength;
    }else{
        self.bottomLine.x = titleLabel.x - self.style.bottomLineAdjustmentlength / 2;
        self.bottomLine.width = titleLabel.width + self.style.bottomLineAdjustmentlength;
    }
}

- (void)titleLabelClick:(UITapGestureRecognizer *)tapGes
{
    if ([tapGes.view.class isEqual:[UILabel class]]) {
        UILabel *targetLabel = (UILabel *)tapGes.view;
        if (self.currentIndex != targetLabel.tag) {
            
            UILabel *sourceLabel = (UILabel *)self.titlesLabelArr[self.currentIndex];
            sourceLabel.textColor = self.style.normalColor;
            targetLabel.textColor = self.style.selectColor;
            
            self.currentIndex = targetLabel.tag;
            if ([self.delegate respondsToSelector:@selector(titleLabelClickedWithCurrentIndex:)]) {
                [self.delegate titleLabelClickedWithCurrentIndex:self.currentIndex];
            }
            
            [self adjustLabelPosition:targetLabel];
            
            if (self.style.isShowBottomLine) {
                [UIView animateWithDuration:self.style.animateWithDuration animations:^{
                    
                    if (self.style.isBottomLineEqualLabelTextlength) {
                        CGFloat labelTextW = [targetLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.style.titleHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:targetLabel.font} context:nil].size.width;
                        self.bottomLine.x = (targetLabel.x + (targetLabel.width - labelTextW) / 2) - self.style.bottomLineAdjustmentlength / 2;
                        self.bottomLine.width = labelTextW + self.style.bottomLineAdjustmentlength;
                    }else{
                        
                        self.bottomLine.x = targetLabel.frame.origin.x - self.style.bottomLineAdjustmentlength / 2;
                        self.bottomLine.width = targetLabel.frame.size.width + self.style.bottomLineAdjustmentlength;
                    }
                }];
            }
        }
    }
}

// 调整居中。及动画
- (void)adjustLabelPosition:(UILabel *)targetLabel
{
    if (self.style.isScrollEnable == NO) {
        return;
    }
    
    UILabel *sourceLabel = (UILabel *)self.titlesLabelArr.lastObject;
    if (self.bounds.size.width >= sourceLabel.x + sourceLabel.width) {
        return;
    }
    
    CGFloat offsetX = targetLabel.center.x - self.bounds.size.width * 0.5;
    
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    if (offsetX > self.scrollView.contentSize.width - self.scrollView.bounds.size.width) {
        offsetX = self.scrollView.contentSize.width - self.scrollView.bounds.size.width;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:self.style.animateWithDuration];
    self.scrollView.contentOffset = CGPointMake(offsetX, 0);
    [UIView commitAnimations];
}

@end
