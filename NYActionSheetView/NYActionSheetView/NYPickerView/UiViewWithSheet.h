//
//  UiviewWithSheet.h
//  基于uiview的sheet菜单
//
//  Created by NewYear on 15/8/26.
//  Copyright (c) 2015年 NewYear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UiViewWithSheet;
@protocol UiViewWithSheetDelegate <NSObject>

- (void)UiViewWithSheet:(UiViewWithSheet *)sheet clickButtonIndex:(NSInteger)index;

@end

@interface UiViewWithSheet : UIView

@property (strong, nonatomic) NSArray *ButtonTitlesArray;
@property (strong, nonatomic) NSString *title;
@property (weak, nonatomic) id<UiViewWithSheetDelegate> delegate;
- (void)ShowMenuView;
- (UiViewWithSheet *)initWithTitle:(NSString *)title buttonTitlesArray:(NSArray *)buttonTitlesArray delegate:(id<UiViewWithSheetDelegate>) delegate;
@end
