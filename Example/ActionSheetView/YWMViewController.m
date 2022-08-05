//
//  YWMViewController.m
//  ActionSheetView
//
//  Created by yaoweimeng225@163.com on 08/05/2022.
//  Copyright (c) 2022 yaoweimeng225@163.com. All rights reserved.
//

#import "YWMViewController.h"
#import "YWMActionSheetTitleView.h"
@interface YWMViewController ()<TYTActionSheetTitleViewDelegate>
@property (nonatomic, strong) YWMActionSheetTitleView *actionTitleView;
@end

@implementation YWMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _actionTitleView = [[YWMActionSheetTitleView alloc] initActionSheetWithTopTips:@"您的账号未设置密码，请使用手机验证码登录或设置密码" actionTitles:@[@"验证码登录", @"去设置密码"]];
    _actionTitleView.delegate = self;
    [_actionTitleView showActionSheetView];
}
- (void)actionSheetTitleView:(YWMActionSheetTitleView *)actionView didSelecMenuIndex:(NSInteger)index{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
