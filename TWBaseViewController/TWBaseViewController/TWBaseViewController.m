//
//  TWBaseViewController.m
//  TWBaseViewController
//
//  Created by HaKim on 16/2/22.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "TWBaseViewController.h"

static NSString* const defaultRightBtnTitle = @"返回";

@interface TWBaseViewController ()

@property (nonatomic, weak) UIButton *rigthBtn;

@end

@implementation TWBaseViewController

- (instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupDefaultSettings];
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public method
- (void)setRightBtnItem:(TWNavBtnItem *)rightBtnItem{
    _rightBtnItem = rightBtnItem;
    [self setupRightButton];
}

#pragma mark - private method

- (void)commonInit{

}

- (void)setupRightButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIFont *font = self.rightBtnItem.titleFont;
    btn.titleLabel.font = font;
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setTitleColor:self.rightBtnItem.normalTitleColor forState:UIControlStateNormal];
    [btn setTitle:self.rightBtnItem.title forState:UIControlStateNormal];
    [btn setTitle:self.rightBtnItem.title forState:UIControlStateHighlighted];
    
    UIImage *image = self.rightBtnItem.normalImage;
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *himage = self.rightBtnItem.hilightedImage;
    himage = [himage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:himage forState:UIControlStateHighlighted];
    
    [btn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    CGRect textFrame = CGRectMake(0, 6, 53, 30);
    btn.frame = textFrame;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, self.rightBtnItem.titleOffsetX, 0, 0);
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    flexSpacer.width = (self.rightBtnItem.leftOffetX - 16);  // right btn 的x坐标为10,
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:flexSpacer,leftItem, nil]];
}

#pragma mark - 导航栏上按钮action 时间
- (void)rightBtnClicked:(UIButton*)sender{
    if(self.rightBtnClickedBlock){
        self.rightBtnClickedBlock(sender);
    }
    
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - 默认值设置
- (void)setupDefaultSettings{
    self.view.backgroundColor = [UIColor orangeColor];
    TWNavBtnItem *rightBtnItem = [[TWNavBtnItem alloc]init];
//    rightBtnItem.leftOffetX = 8;
//    rightBtnItem.titleOffsetX = 5;
//    rightBtnItem.normalImage = [UIImage imageNamed:@"btn_back_n"];
//    rightBtnItem.hilightedImage = [UIImage imageNamed:@"btn_back_h"];
//    rightBtnItem.normalTitleColor = [UIColor redColor];
//    rightBtnItem.titleFont = [UIFont systemFontOfSize:15];
//    rightBtnItem.title = @"返回";
    self.rightBtnItem = rightBtnItem;
}
@end
