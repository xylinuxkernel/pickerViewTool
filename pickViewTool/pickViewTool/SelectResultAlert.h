//
//  SelectResultAlert.h
//  pickViewTool
//
//  Created by 徐银 on 16/2/26.
//  Copyright © 2016年 徐银. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectResultAlert : NSObject<UITextFieldDelegate,UIAlertViewDelegate>
{
    void (^_callback)(NSString *);
}
- (void)showSelectResultWithCallback:(NSString *)message callback: (void (^)(NSString *))callback;

@end
