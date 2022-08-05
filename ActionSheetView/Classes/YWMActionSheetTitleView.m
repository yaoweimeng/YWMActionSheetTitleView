//
//  YWMActionSheetTitleView.m
//  YWM
//
//  Created by YWM on 2021/5/19.
//  Copyright © 2021 YWM. All rights reserved.
//

#import "YWMActionSheetTitleView.h"
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

@interface YWMActionSheetTitleView (){
    NSArray *_actionTitlesArray;
    NSArray *_actionSubtitlesArray;
    NSString *_toptips;
 }

@property (nonatomic, strong) UIView *bgCoverView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UILabel *actionSheetToptips;
@property (nonatomic, strong) UIView *actionSheetView;

@end

@implementation YWMActionSheetTitleView

- (instancetype)initActionSheetWithTopTips:(NSString *)toptips actionTitles:(NSArray *)titles
{
    _toptips = toptips;
    _topTipsHeight = 80;
    _actionTitlesArray = titles;
    return [self init];
}

- (instancetype)initActionSheetWithTopTips:(NSString *)toptips actionTitles:(NSArray *)titles actionSubTitles:(NSArray *)subtitles
{
    _toptips = toptips;
    _topTipsHeight = 40;
    _actionTitlesArray = titles;
    _actionSubtitlesArray = subtitles;
    return [self init];
}

- (instancetype)initActionSheetWithActionTitles:(NSArray *)titles
{
   _actionTitlesArray = titles;
    return [self init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self) {
       self.frame = [UIScreen mainScreen].bounds;
       [[UIApplication sharedApplication].keyWindow addSubview:self];
       self.bgCoverView = [[UIView alloc] initWithFrame:self.frame];
       self.bgCoverView.backgroundColor = [UIColor clearColor];
       self.bgCoverView.alpha = 0.7;
       self.bgCoverView.userInteractionEnabled = YES;
       [self addSubview:self.bgCoverView];
       [self.bgCoverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureCloseView:)]];
       
       self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
       self.cancelButton.backgroundColor = [UIColor whiteColor];
       [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
       [self.cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
       self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
       [self.cancelButton.titleLabel sizeToFit];
       self.cancelButton.layer.cornerRadius = 7.5;
       self.cancelButton.layer.masksToBounds = YES;
       [self.cancelButton addTarget:self action:@selector(closeActionSheet:) forControlEvents:UIControlEventTouchUpInside];
       [self addSubview:self.cancelButton];
       
       self.actionSheetView = [[UIView alloc] init];
       self.actionSheetView.backgroundColor = [UIColor whiteColor];
       self.actionSheetView.layer.cornerRadius = 7.5;
       self.actionSheetView.layer.masksToBounds = YES;
       [self addSubview:self.actionSheetView];
       
       if (_toptips) {
           self.actionSheetToptips = [[UILabel alloc] init];
           self.actionSheetToptips.text = _toptips;
           self.actionSheetToptips.textAlignment = NSTextAlignmentCenter;
           self.actionSheetToptips.numberOfLines = 0;
           self.actionSheetToptips.font = [UIFont systemFontOfSize:13];
           self.actionSheetToptips.textColor = [UIColor lightGrayColor];
           [self.actionSheetToptips sizeToFit];
           [self.actionSheetView addSubview:self.actionSheetToptips];
       }
       
       [self buildActionSheetMenu];
   }
   return self;
}

- (void)buildActionSheetMenu
{
    self.cancelButton.frame = CGRectMake(12, Screen_Height + [self actionViewHeight], Screen_Width - 24, 45);
    self.actionSheetView.frame = CGRectMake(12, CGRectGetMinY(self.cancelButton.frame) - [self actionViewHeight], Screen_Width - 24, [self actionViewHeight]);
    
    if (self.actionSheetToptips) {
        [self.actionSheetToptips mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.actionSheetView).offset(19.5);
            make.left.equalTo(self.actionSheetView).offset(10);
            make.right.equalTo(self.actionSheetView).offset(-10);
        }];
    }
    
    for (NSInteger i = 0; i < _actionTitlesArray.count; i++) {
        UIButton *actionSheetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        actionSheetBtn.backgroundColor = [UIColor whiteColor];
        [actionSheetBtn setTitle:_actionTitlesArray[i] forState:UIControlStateNormal];
        [actionSheetBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [actionSheetBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        actionSheetBtn.tag = i;
        [actionSheetBtn addTarget:self action:@selector(acitonSheetMenu:) forControlEvents:UIControlEventTouchUpInside];
        [self.actionSheetView addSubview:actionSheetBtn];
        
        
        [actionSheetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.actionSheetView);
            make.right.equalTo(self.actionSheetView);
            make.bottom.mas_equalTo(self.actionSheetView).offset(-(i * 50 + i * 0.5));
            make.height.equalTo(@50);
        }];
        
        NSString *subTitle = [_actionSubtitlesArray objectAtIndex:i];
        if (subTitle) {
            UILabel *descLabel = [[UILabel alloc] init];
            descLabel.textColor = [UIColor grayColor];
            descLabel.font = [UIFont systemFontOfSize:12];
            descLabel.text = subTitle;
            [actionSheetBtn addSubview:descLabel];
            
            [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(actionSheetBtn.titleLabel.mas_right).offset(2);
                make.centerY.equalTo(actionSheetBtn);
            }];
        }
    
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.actionSheetView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.right.equalTo(self.actionSheetView);
            make.bottom.equalTo(actionSheetBtn.mas_top).offset(0.5);
        }];
    }
}

- (void)setActionTitleColor:(UIColor *)actionTitleColor
{
    _actionTitleColor = actionTitleColor;
    
    for (UIView *subView in self.actionSheetView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            [(UIButton *)subView setTitleColor:actionTitleColor forState:UIControlStateNormal];
        }
    }
}

- (void)setCancelTitleColor:(UIColor *)cancelTitleColor
{
    _cancelTitleColor = cancelTitleColor;
    
    [self.cancelButton setTitleColor:cancelTitleColor forState:UIControlStateNormal];
}

- (void)setCancelTitleSize:(CGFloat)cancelTitleSize
{
    _cancelTitleSize = cancelTitleSize;
    
    [self.cancelButton.titleLabel setFont:[UIFont systemFontOfSize:_cancelTitleSize]];
}

- (void)setTopTipsMargin:(CGFloat)topTipsMargin
{
    _topTipsMargin = topTipsMargin;
    if (_topTipsMargin) {
        [self.actionSheetToptips mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.actionSheetView).offset(_topTipsMargin);
            make.centerX.equalTo(self.actionSheetView);
        }];
    }
}

- (void)showActionSheetView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.cancelButton.frame = CGRectMake(12, Screen_Height - 17 - 45, Screen_Width - 24, 45);
        self.actionSheetView.frame = CGRectMake(12, CGRectGetMinY(self.cancelButton.frame) - [self actionViewHeight] - 5, Screen_Width - 24, [self actionViewHeight]);
    }];
}

- (void)tapGestureCloseView:(UITapGestureRecognizer *)gesture
{
    [self closeActionSheet:nil];
}

- (void)closeActionSheet:(UIButton *)closeButton
{
    [UIView animateWithDuration:0.3 animations:^{
        self.cancelButton.frame = CGRectMake(12, Screen_Height + [self actionViewHeight], Screen_Width - 24, 45);
        self.actionSheetView.frame = CGRectMake(12, CGRectGetMinY(self.cancelButton.frame) - [self actionViewHeight], Screen_Width - 24, [self actionViewHeight]);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)acitonSheetMenu:(UIButton *)menuButton
{
    [self closeActionSheet:nil];
    if ([self.delegate respondsToSelector:@selector(actionSheetTitleView:didSelecMenuIndex:)])
        [self.delegate actionSheetTitleView:self didSelecMenuIndex:menuButton.tag];
}

- (CGFloat)actionViewHeight {
    return (50 * _actionTitlesArray.count) + (0.5 * _actionTitlesArray.count) + _topTipsHeight;
}

@end
