//
//  NYSheetView.h
//  NYActionSheetView
//
//  Created by NewYear on 15/8/26.
//  Copyright (c) 2015年 NewYear. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NYSheetView;
@protocol NYSheetViewDelegate <NSObject>

- (void)NYSheetView:(NYSheetView *)sheet clickButtonIndex:(NSInteger)index;

@end
@interface NYSheetView : UIView
@property (strong, nonatomic) NSArray *ButtonTitlesArray;
@property (strong, nonatomic) NSString *title;
@property (weak, nonatomic) id<NYSheetViewDelegate> delegate;
- (void)ShowMenuView;
- (NYSheetView *)initWithTitle:(NSString *)title buttonTitlesArray:(NSArray *)buttonTitlesArray delegate:(id<NYSheetViewDelegate>) delegate;
@end
