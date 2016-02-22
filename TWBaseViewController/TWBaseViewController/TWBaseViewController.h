//
//  TWBaseViewController.h
//  TWBaseViewController
//
//  Created by HaKim on 16/2/22.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWNavBtnItem.h"

typedef void(^TWBaseViewControllerRightBtnClickedBlock) (UIButton *sender);

@interface TWBaseViewController : UIViewController

// 返回按钮回调的block
@property (nonatomic, copy)TWBaseViewControllerRightBtnClickedBlock rightBtnClickedBlock;

// 自定义设置
@property (nonatomic, strong) TWNavBtnItem *rightBtnItem;

@end
