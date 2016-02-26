//
//  PickerToolView.h
//  pickViewTool
//
//  Created by 徐银 on 16/2/26.
//  Copyright © 2016年 徐银. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  自定义底部弹出选择控件
 */

@interface PickerToolView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
//选择title
@property (nonatomic, copy) NSString *title;
//选择控件
@property (nonatomic, strong) UIPickerView *pickerView;
//数据源
@property (nonatomic, strong) NSArray *dataSource;
//当前选择索引
@property (nonatomic, assign) NSInteger currentIndex;
//当前是否展现
@property (nonatomic, assign, readonly) BOOL isShow;

//选择后回调处理
@property (nonatomic, copy) void (^didSelectItem)(NSInteger idx);
//取消选择回调
@property (nonatomic, copy) void (^cancelSelect)(void);

- (void)showWithAnimation:(BOOL)animation;
- (void)dismissWithAnimation:(BOOL)animation;
@end
