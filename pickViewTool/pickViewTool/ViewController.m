//
//  ViewController.m
//  pickViewTool
//
//  Created by 徐银 on 16/2/26.
//  Copyright © 2016年 徐银. All rights reserved.
//

#import "ViewController.h"
#import "PickerToolView.h"
#import "SelectResultAlert.h"
@interface ViewController ()

@property (nonatomic, strong) IBOutlet UIButton *button;
@property (nonatomic, strong) SelectResultAlert *alert;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.button addTarget:self action:@selector(showPickerView) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)showPickerView
{
    __weak typeof(self) ws = self;
    NSArray *data = @[@"支付宝",@"微信",@"银联",@"其它"];
    PickerToolView *picker = [[PickerToolView alloc]init];
    picker.dataSource = data;
    picker.didSelectItem = ^(NSInteger idx){
        //弹出alert
        if (idx != [data count]-1) {
            ws.alert =[[SelectResultAlert alloc]init];
            [ws.alert showSelectResultWithCallback:data[idx] callback:^(NSString *str) {
                [ws.button setTitle:str forState:UIControlStateNormal];
            }];

        }
    };
    picker.cancelSelect = ^(){
        NSLog(@"do nothing");
    };
    [picker showWithAnimation:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
