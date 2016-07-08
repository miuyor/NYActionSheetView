//
//  UiviewWithSheet.m
//  基于uiview的sheet菜单
//
//  Created by NewYear on 15/8/26.
//  Copyright (c) 2015年 NewYear. All rights reserved.
//

#import "UiViewWithSheet.h"
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface UiViewWithSheet ()

@property (strong, nonatomic) UIView *baseView;
@property (strong, nonatomic) UIView *menuView;
@property (strong, nonatomic) UIButton *button;


@end
@implementation UiViewWithSheet

#pragma mark --- 懒加载数据
/*
 设置默认button的个数和title
 */
- (NSArray *)ButtonTitlesArray {
    if (!_ButtonTitlesArray) {
        _ButtonTitlesArray = @[@"你",@"我",@"他",@"取消"];
    }
    return _ButtonTitlesArray;
}
/*
 设置默认button的字体和背景颜色
 */

#pragma mark -- 初始化title和ButtonTitlesArray

- (UiViewWithSheet *)initWithTitle:(NSString *)title buttonTitlesArray:(NSArray *)buttonTitlesArray delegate:(id<UiViewWithSheetDelegate>) delegate {
    self = [super init];
    if (self) {
        self.title = title;
        self.ButtonTitlesArray = buttonTitlesArray;
        self.delegate = delegate;
    }
    
    return self;
}


#pragma mark --- 点击了显示菜单按钮

- (void)ShowMenuView {
    NSLog(@"显示菜单按钮");
    
    if (!self.baseView.superview) {
        self.baseView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight)];
        self.baseView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHideView:)];
        [self.baseView addGestureRecognizer:tap];
        [self.window addSubview:self.baseView];
        if (!self.menuView) {
            self.menuView = [self createMenuView];
            [self.baseView addSubview:self.menuView];
        }
        [UIView animateWithDuration:0.4 animations:^{
            self.baseView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        }];
    }
}

#pragma mark --- 创建菜单视图和按钮

- (UIView *)createMenuView {
    
    NSInteger height;
    int btnStartHeight;
    UIView *menuView;
    //设置title
    if (!self.title) {
        height = self.ButtonTitlesArray.count *(45 +10) + 25;
        menuView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - height , ScreenWidth, height)];
        btnStartHeight = 20;
    }else {
        height = self.ButtonTitlesArray.count *(45 +10) + 45;
        menuView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - height , ScreenWidth, height)];
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, ScreenWidth, 30)];
        titleLable.font = [UIFont systemFontOfSize:16];
        [titleLable setTextAlignment:NSTextAlignmentCenter];
        [titleLable setText:self.title];
        [titleLable setTextColor:[UIColor redColor]];
        [menuView addSubview:titleLable];
        btnStartHeight = 45;
    }
    menuView.backgroundColor = [UIColor whiteColor];
    
    //设置button的高度和每个默认button的字体和背景颜色和backgroundImage还有button的title
    for (int i = 0; i < self.ButtonTitlesArray.count; i++) {
        
        self.button = [[UIButton alloc]init];
        self.button.frame = CGRectMake(25, btnStartHeight + i*(45+10), ScreenWidth - 50, 45);
        self.button.titleLabel.font = [UIFont systemFontOfSize:18];
        self.button.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        
        [self.button addTarget:self action:@selector(clickSheetButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImage *image;
        
        if (i == self.ButtonTitlesArray.count - 1) {
            [self.button setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            image = [[UIImage imageNamed:@"Cancel_btn.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:15];
        }else {
            image = [[UIImage imageNamed:@"photo_btn.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:15];
            [self.button setTitleColor:[UIColor colorWithRed:0x00/255.0 green:0x00/255.0 blue:0x00/255.0 alpha:1] forState:UIControlStateNormal];
        }
        
        [self.button setBackgroundImage:image forState:UIControlStateHighlighted];
        [self.button setBackgroundImage:image forState:UIControlStateNormal];
        
        self.button.tag = i ;
        [self.button setTitle:self.ButtonTitlesArray[i] forState:UIControlStateNormal];
        [menuView addSubview:self.button];

    }
    return menuView;
}

#pragma mark --- 点击菜单中的按钮触发的方法

- (void)clickSheetButton:(UIButton *)sender {
    
    NSLog(@"点击了**%@**",self.ButtonTitlesArray[sender.tag]);
    
    if (_delegate && [_delegate respondsToSelector:@selector(UiViewWithSheet:clickButtonIndex:)]) {
        
        [_delegate UiViewWithSheet:self clickButtonIndex:sender.tag];
    }
    
    [self hideBaseViewAndSelectedView];
    
}

#pragma mark -- 隐藏视图

- (void)tapHideView:(UIGestureRecognizer *)tap {
    
    [self hideBaseViewAndSelectedView];
    
}

- (void)hideBaseViewAndSelectedView {
    
    [UIView animateWithDuration:0.4 animations:^{
        self.baseView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);
        self.menuView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);
    } completion:^(BOOL finished) {
        
        [self.baseView removeFromSuperview];
        self.baseView = nil;
        self.menuView = nil;
        [self removeFromSuperview];
    }];
    
}
@end
