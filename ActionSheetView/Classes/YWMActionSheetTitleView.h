//
//  YWMActionSheetTitleView.h
//  YWM
//
//  Created by YWM on 2021/5/19.
//  Copyright © 2021 YWM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YWMActionSheetTitleView;

@protocol TYTActionSheetTitleViewDelegate <NSObject>

- (void)actionSheetTitleView:(YWMActionSheetTitleView *)actionView didSelecMenuIndex:(NSInteger)index;

@end

@interface YWMActionSheetTitleView : UIView

@property (nonatomic, weak) id<TYTActionSheetTitleViewDelegate> delegate;

@property (nonatomic, strong) UIColor *cancelTitleColor;
@property (nonatomic, assign) CGFloat cancelTitleSize;
@property (nonatomic, assign) CGFloat topTipsHeight;
@property (nonatomic, assign) CGFloat topTipsMargin;

@property (nonatomic, strong) UIColor *actionTitleColor;

- (instancetype)initActionSheetWithActionTitles:(NSArray *)titles;
- (instancetype)initActionSheetWithTopTips:(NSString *)toptips actionTitles:(NSArray *)titles;
- (instancetype)initActionSheetWithTopTips:(NSString *)toptips actionTitles:(NSArray *)titles actionSubTitles:(NSArray *)subtitles;
- (void)showActionSheetView;

@end

NS_ASSUME_NONNULL_END
