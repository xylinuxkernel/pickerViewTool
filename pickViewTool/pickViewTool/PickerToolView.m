//
//  PickerToolView.m
//  pickViewTool
//
//  Created by 徐银 on 16/2/26.
//  Copyright © 2016年 徐银. All rights reserved.
//

#import "PickerToolView.h"

@interface PickerToolView ()

@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, assign) BOOL isShow;

@end

@implementation PickerToolView

- (id)initWithFrame:(CGRect)frame
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    frame = CGRectMake(0, bounds.size.height, bounds.size.width, bounds.size.height-64);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        CGRect toolbarFrame = CGRectMake(0, frame.size.height-260, bounds.size.width, 44);
        UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:toolbarFrame];
        pickerToolbar.barStyle = UIBarStyleDefault;
        [pickerToolbar sizeToFit];
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(cancel:)];
        
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                       target:nil
                                                                                       action:nil];
        //@"修改"
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:self
                                                                action:@selector(editDone:)];
        /// 固定偏移
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        left.width = 10;
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        right.width = 10;
        NSArray *barItems = [NSArray arrayWithObjects:left,cancel,flexibleSpace, done,right , nil];
        
        [pickerToolbar setItems:barItems animated:YES];
        [self addSubview:pickerToolbar];
        
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.frame = CGRectMake(0, frame.size.height-216, bounds.size.width, 216);
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [self addSubview:_pickerView];
        
        self.currentIndex = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapAction:(UIButton *)btn
{
    if (_isShow)
    {
        [self dismissWithAnimation:YES];
    }
}

- (void)setDataSource:(NSArray *)dataSource
{
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
        if (self.pickerView) {
            [self.pickerView reloadAllComponents];
        }
    }
}

- (void)setTitle:(NSString *)title
{
    if (_title != title)
    {
        _title = [title copy];
        
        self.titleLabel.text = title;
    }
}

- (UILabel *)titleLabel
{
    if (!_titleLable)
    {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width-120)/2,
                                                                self.frame.size.height-246,
                                                                120,
                                                                20)];
        _titleLable.font = [UIFont systemFontOfSize:16];
        _titleLable.textColor = [UIColor colorWithWhite:0.2 alpha:1.0];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLable];
    }
    
    return _titleLable;
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    if (_currentIndex != currentIndex)
    {
        _currentIndex = currentIndex;
        if (_currentIndex < self.dataSource.count)
        {
            [self.pickerView selectRow:0 inComponent:0 animated:YES];
        }
    }
}

#pragma mark -
#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.dataSource count];;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [self.dataSource objectAtIndex:row];
}

#pragma mark -
#pragma mark UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    if (row < [self.dataSource count])
    {
        [self.dataSource objectAtIndex:row];
    }
}

#pragma mark private methods
- (void)cancel:(id)sender
{
    if (self.cancelSelect)
    {
        self.cancelSelect();
    }
    
    [self dismissWithAnimation:YES];
}

- (void)editDone:(id)sender
{
    self.currentIndex = [self.pickerView selectedRowInComponent:0];
    
    if (self.didSelectItem) {
        self.didSelectItem(self.currentIndex);
    }
    [self dismissWithAnimation:YES];
}

- (void)showWithAnimation:(BOOL)animation
{
    if (!self.isShow)
    {
        self.isShow = YES;
        
        if (![self superview]) {
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            [window addSubview:self];
        }
        
        CGRect frame = [[UIScreen mainScreen] bounds];
        CGPoint point = CGPointMake(frame.size.width/2, (frame.size.height+64)/2);
        if (animation)
        {
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.center = point;
                             }];
        }
        else
        {
            self.center = point;
        }
    }
}

- (void)dismissWithAnimation:(BOOL)animation
{
    if (self.isShow)
    {
        self.isShow = NO;
        
        if ([self superview])
        {
            CGRect frame = [[UIScreen mainScreen] bounds];
            CGPoint point = CGPointMake(frame.size.width/2, frame.size.height+self.frame.size.height/2);
            
            if (animation)
            {
                [UIView animateWithDuration:0.3
                                 animations:^{
                                     self.center = point;
                                 } completion:^(BOOL finished) {
                                     [self removeFromSuperview];
                                 }];
            }
            else
            {
                [self removeFromSuperview];
            }
        }
    }
}

@end

