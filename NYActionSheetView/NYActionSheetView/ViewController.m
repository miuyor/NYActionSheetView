//
//  ViewController.m
//  NYActionSheetView
//
//  Created by NewYear on 16/7/8.
//  Copyright © 2016年 NewYear. All rights reserved.
//

#import "ViewController.h"
#import "NYPickerView.h"
@interface ViewController ()<NYPickerViewDelegate,NYSheetViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *horSelectBtn;
@property (strong, nonatomic) NSArray *selectArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
}
//生成横向选择视图
- (IBAction)clickHorSelectBtn:(id)sender {
    NYPickerView *pickerView = [[NYPickerView alloc]initPickerViewWithSuperView:self.view dataArr:self.selectArr selectStringIndex:0];
    pickerView.delegate = self;
}
//生成纵向选择视图
- (IBAction)clickVerSelectBtn:(id)sender {
    NYSheetView *menuView = [[NYSheetView alloc]initWithTitle:@"请选择下面选项" buttonTitlesArray:self.selectArr delegate:self];
    [self.view addSubview:menuView];
    [menuView ShowMenuView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- NYPickerViewDelegate
- (void)nyPickerView:(NYPickerView *)nyPickerView clickButtonWithIndex:(NSInteger)index {
    //选择后做处理
    NSLog(@"点击了**%ld**",index);
}
#pragma mark -- NYPickerViewDelegate

- (void)NYSheetView:(NYSheetView *)sheet clickButtonIndex:(NSInteger)index{
    //选择后做处理
    NSLog(@"点击了**%ld**",index);
}


- (NSArray *)selectArr {
    if (!_selectArr) {
        _selectArr = [[NSArray alloc]init];
        _selectArr = @[@"选择1",@"选择2",@"选择3",@"选择4",@"选择5",@"选择6"];
    }
    return _selectArr;
}
@end
