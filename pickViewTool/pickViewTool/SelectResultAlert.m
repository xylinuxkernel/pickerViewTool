//
//  SelectResultAlert.m
//  pickViewTool
//
//  Created by 徐银 on 16/2/26.
//  Copyright © 2016年 徐银. All rights reserved.
//

#import "SelectResultAlert.h"

@implementation SelectResultAlert

- (void)showSelectResultWithCallback:(NSString *)message callback: (void (^)(NSString *))callback
{
    _callback = callback;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付方式" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[alert textFieldAtIndex:0] setDelegate:self];
    [[alert textFieldAtIndex:0] setPlaceholder:@"请输入支付金额"];
    [alert show];
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView NS_DEPRECATED_IOS(2_0, 9_0)
{
    return [alertView textFieldAtIndex:0].text.length > 0;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSString *moneyStr = [alertView textFieldAtIndex:0].text;
        _callback([NSString stringWithFormat:@"支付金额为:%.2f",[moneyStr floatValue]]);
      
    }
}

@end
