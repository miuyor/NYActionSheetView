# NYActionSheetView

<!--[![baidu]](http://baidu.com)  -->
<!--[baidu]:http://www.baidu.com/img/bdlogo.gif "百度Logo"  -->

[![第一个]](https://github.com/miuyor/NYActionSheetView/raw/master/imagesFolder/3.png)
[第一个]:http://www.baidu.com/img/bdlogo.gif

1.The choice of horizontal view
-----

![image](https://github.com/miuyor/NYActionSheetView/raw/master/imagesFolder/0.png)
methods
----
    NYPickerView *pickerView = [[NYPickerView alloc]initPickerViewWithSuperView:self.view dataArr:self.selectArr selectStringIndex:0];
    pickerView.delegate = self;
    
    - (void)nyPickerView:(NYPickerView *)nyPickerView clickButtonWithIndex:(NSInteger)index {
        NSLog(@"click**%ld**",index);
    }


2.The choice of longitudinal view
------

![image](https://github.com/miuyor/NYActionSheetView/raw/master/imagesFolder/0.png)
methods
----
     NYSheetView *menuView = [[NYSheetView alloc]initWithTitle:@"请选择下面选项" buttonTitlesArray:self.selectArr delegate:self];
    [self.view addSubview:menuView];
    [menuView ShowMenuView];
    
    - (void)NYSheetView:(NYSheetView *)sheet clickButtonIndex:(NSInteger)index{
         NSLog(@"click**%ld**",index);
    }
