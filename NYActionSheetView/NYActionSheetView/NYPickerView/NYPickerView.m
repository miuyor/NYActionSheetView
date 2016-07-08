//
//  NYPickerView.m
//  HomeDecoration
//
//  Created by NewYear on 16/3/14.
//  Copyright © 2016年 Orange5s. All rights reserved.
//

#import "NYPickerView.h"
#define ScreenWidth   ([[UIScreen mainScreen]bounds].size.width)
#define ScreenHeight ([[UIScreen mainScreen]bounds].size.height)

@interface NYPickerView()
@property (strong, nonatomic) UIView *superView;
@property (strong, nonatomic) UIView *selectView;
@property (assign, nonatomic) NSInteger selectIndex;
@property (strong, nonatomic) NSArray *dataStrings;
@property (strong, nonatomic) NSMutableArray *btns;
@end
@implementation NYPickerView

- (instancetype)initPickerViewWithSuperView:(UIView *)superView dataArr:(NSArray *)dataArr selectStringIndex:(NSInteger)selectIndex{
    self = [super init];
    if (self) {
        //初始化
        [superView.window addSubview:self];
        _selectIndex = selectIndex;
        _dataStrings = [[NSArray alloc]initWithArray:dataArr];
        _superView = superView;
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor colorWithHue:0x00/255.0 saturation:0x00/255.0 brightness:0x00/255.0 alpha:0.5];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHideView:)];
        [self addGestureRecognizer:tap];

        self.selectView = [self createSelectView];
        [self addSubview:self.selectView];
            NSInteger row = _dataStrings.count%3==0?_dataStrings.count/3:_dataStrings.count/3+1;
            NSInteger height = 20+row*55;
        [UIView animateWithDuration:0.4 animations:^{
            self.selectView.frame = CGRectMake(0, ScreenHeight-height, ScreenWidth, height);
        }];
    }
    
    return self;
}

#pragma mark --- SelectView
/**
 *  @author NY, 16-03-15 10:03:18
 *
 *  @brief 创建视图
 *
 */
- (UIView *)createSelectView {

    NSInteger row = _dataStrings.count%3==0?_dataStrings.count/3:_dataStrings.count/3+1;
    NSInteger height = 20+row*55;
    UIView *selectedView ;
    selectedView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, height)];
    selectedView.backgroundColor = [UIColor colorWithRed:0xed/255.0 green:0xed/255.0 blue:0xed/255.0 alpha:1.0];
    UIButton *button;

    CGFloat width = (ScreenWidth - 80)/3;
    CGFloat butWidth = (ScreenWidth - width*(_dataStrings.count>2?3:_dataStrings.count))/((_dataStrings.count>2?3:_dataStrings.count)+1);
    _btns = [[NSMutableArray alloc]init];

    for (int i = 0; i < _dataStrings.count; i++) {
        int wi = i%3;
        button = [[UIButton alloc]initWithFrame:CGRectMake((width + butWidth)*wi + butWidth, 20+(55*(i/3)) , width , 35)];
        button.tag = i;
        if (i == _selectIndex) {

            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button.layer setBorderColor:[[UIColor colorWithRed:0xf0/255.0 green:0x60/255.0 blue:0x00/255.0 alpha:1 ] CGColor]];
            button.backgroundColor = [UIColor colorWithRed:0xf0/255.0 green:0x60/255.0 blue:0x00/255.0 alpha:1 ];
        }else{
            
            [button setTitleColor:[UIColor colorWithRed:0xf0/255.0 green:0x60/255.0 blue:0x00/255.0 alpha:1 ] forState:UIControlStateNormal];
            [button.layer setBorderColor:[[UIColor colorWithRed:0xdd/255.0 green:0xdd/255.0 blue:0xdd/255.0 alpha:1 ] CGColor]];
            button.backgroundColor = [UIColor whiteColor];
        }
        [button.layer setMasksToBounds:YES];
        [button.layer setBorderWidth:0.5];
        [button.layer setCornerRadius:2.5];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"selectBtn_def"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(clickStateButton:) forControlEvents:UIControlEventTouchUpInside];
        [selectedView addSubview:button];
        [button setTitle:self.dataStrings[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_btns addObject:button];
    }
    return selectedView;
}

#pragma mark --- 点击修改性别button
/**
 *  @author NY, 16-03-15 10:03:19
 *
 *  @brief 传回点击按钮后的下标
 *
 *  @param index 点击的下标
 */
- (void)clickStateButton:(UIButton *)sender{
    //改变选择上个btn的状态
    if (_selectIndex <_btns.count) {
        UIButton *btn = _btns[_selectIndex];
        [btn setTitleColor:[UIColor colorWithRed:0x88/255.0 green:0x88/255.0 blue:0x88/255.0 alpha:1] forState:UIControlStateNormal];
        [btn.layer setBorderColor:[[UIColor colorWithRed:0xdd/255.0 green:0xdd/255.0 blue:0xdd/255.0 alpha:1 ] CGColor]];
        btn.backgroundColor = [UIColor whiteColor];
    }
    
    //改变当前选择btn的状态
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sender.layer setBorderColor:[[UIColor colorWithRed:0xf0/255.0 green:0x60/255.0 blue:0x00/255.0 alpha:1] CGColor]];
    sender.backgroundColor = [UIColor colorWithRed:0xf0/255.0 green:0x60/255.0 blue:0x00/255.0 alpha:1];
    
    //实现代理
    if (_delegate && [_delegate respondsToSelector:@selector(nyPickerView:clickButtonWithIndex:)]) {
        
        [_delegate nyPickerView:self clickButtonWithIndex:sender.tag];
    }
    
    [self hideBaseViewAndSelectedView];

    
}
#pragma mark --- 隐藏
/**
 *  @author NY, 16-03-15 10:03:20
 *
 *  @brief 隐藏视图
 *
 */
- (void)tapHideView:(UIGestureRecognizer *)tap {
    
    [self hideBaseViewAndSelectedView];
    
}

- (void)hideBaseViewAndSelectedView {
    
    [UIView animateWithDuration:0.4 animations:^{
        
        self.backgroundColor = [UIColor clearColor];
        NSInteger row = _dataStrings.count%3==0?_dataStrings.count/3:_dataStrings.count/3+1;
        NSInteger height = 45 + row*55;
        self.selectView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, height);
        
    } completion:^(BOOL finished) {
        
        [self.selectView removeFromSuperview];
        self.selectView = nil;
        [self removeFromSuperview];
        
    }];
    
}


@end
