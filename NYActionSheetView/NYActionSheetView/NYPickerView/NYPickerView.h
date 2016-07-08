//
//  NYPickerView.h
//  HomeDecoration
//
//  Created by NewYear on 16/3/14.
//  Copyright © 2016年 Orange5s. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NYSheetView.h"
@class NYPickerView;
@protocol NYPickerViewDelegate <NSObject>

@optional
/**
 *  @author NY, 16-03-15 10:03:19
 *
 *  @brief 传回点击按钮后的下标
 *
 *  @param index 点击的下标
 */
- (void)nyPickerView:(NYPickerView *)nyPickerView clickButtonWithIndex:(NSInteger)index;

@end

@interface NYPickerView : UIView

@property (strong, nonatomic) id<NYPickerViewDelegate> delegate;
/**
 *  @author NY, 16-03-15 09:03:35
 *
 *  @brief 初始化
 *
 *  @param superView   绑定的View
 *  @param dataArr     传入的数组
 *  @param selectIndex 初始选择的下标
 */
- (instancetype)initPickerViewWithSuperView:(UIView *)superView dataArr:(NSArray *)dataArr selectStringIndex:(NSInteger)selectIndex;

@end
