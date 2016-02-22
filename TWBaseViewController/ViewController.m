//
//  ViewController.m
//  TWBaseViewController
//
//  Created by HaKim on 16/2/22.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "ViewController.h"
#import "TWBaseViewController.h"
#import "TWNavBtnItem.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    TWBaseViewController *vc = [[TWBaseViewController alloc]init];
    
    TWNavBtnItem *item = [[TWNavBtnItem alloc]init];
    vc.rightBtnItem = item;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
