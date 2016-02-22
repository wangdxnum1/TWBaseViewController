//
//  TWNavBtnItem.m
//  TWBaseViewController
//
//  Created by HaKim on 16/2/22.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "TWNavBtnItem.h"

@implementation TWNavBtnItem

- (instancetype)init{
    if(self = [super init]){
        self.itemType = TWNavBtnItemType_ImageAndText;
        self.leftOffetX = 8;
        self.titleOffsetX = 5;
        self.normalImage = [UIImage imageNamed:@"btn_back_n"];
        self.hilightedImage = [UIImage imageNamed:@"btn_back_h"];
        self.normalTitleColor = [UIColor redColor];
        self.titleFont = [UIFont systemFontOfSize:15];
        self.title = @"返回";
    }
    return self;
}

@end
