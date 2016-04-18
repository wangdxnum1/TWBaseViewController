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

@property (nonatomic, weak) UIButton *rightBtn;
@property (nonatomic, weak) UIButton *leftBtn;
@end

@implementation TWBaseViewController

- (instancetype)init{
    if(self = [super init]){
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self setupDefaultSettings];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public method
- (void)setLeftBtnItem:(TWNavBtnItem *)leftBtnItem{
    _leftBtnItem = leftBtnItem;
    if(leftBtnItem){
        [self setupLeftButton];
    }else{
        [self.leftBtn removeFromSuperview];
    }
}

- (void)setRightBtnItem:(TWNavBtnItem *)rightBtnItem{
    _rightBtnItem = rightBtnItem;
    
    if(rightBtnItem){
        [self setupRightButton];
    }else{
        [self.rightBtn removeFromSuperview];
        self.navigationItem.leftBarButtonItem = nil;
    }
}

#pragma mark - private method

- (void)setupLeftButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIFont *font = self.leftBtnItem.titleFont;
    btn.titleLabel.font = font;
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setTitleColor:self.leftBtnItem.normalTitleColor forState:UIControlStateNormal];
    [btn setTitle:self.leftBtnItem.title forState:UIControlStateNormal];
    [btn setTitle:self.leftBtnItem.title forState:UIControlStateHighlighted];
    self.leftBtn = btn;
    UIImage *image = self.leftBtnItem.normalImage;
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *himage = self.leftBtnItem.hilightedImage;
    himage = [himage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:himage forState:UIControlStateHighlighted];
    
    [btn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    CGRect textFrame = CGRectMake(0, 6, 12.5, 21);
    btn.frame = textFrame;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, self.leftBtnItem.titleOffsetX, 0, 0);
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    flexSpacer.width = (self.leftBtnItem.offetX - 16);  // left btn 的x坐标为10,
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:flexSpacer,leftItem, nil]];
    
    //btn.backgroundColor = [UIColor randomColor];
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
    self.rightBtn = btn;
    UIImage *image = self.rightBtnItem.normalImage;
    if(image){
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [btn setImage:image forState:UIControlStateNormal];
    }
    
    UIImage *himage = self.rightBtnItem.hilightedImage;
    himage = [himage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if(himage){
        [btn setImage:himage forState:UIControlStateHighlighted];
    }
    
    [btn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    CGSize textSize = CGSizeZero;
    
    if(self.rightBtnItem.size.width == 0 || self.rightBtnItem.size.height == 0){
        CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
        UIColor *foregroundColor = self.rightBtnItem.normalTitleColor;
        NSDictionary *attributes = @{NSFontAttributeName : font,
                                     NSForegroundColorAttributeName: foregroundColor};
        NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        CGRect textFrame = [self.rightBtnItem.title boundingRectWithSize:size
                                                                options:options
                                                             attributes:attributes
                                                                context:nil];
        textSize = textFrame.size;
        
    }else{
        textSize = self.rightBtnItem.size;
    }
    
    
    CGRect textFrame = CGRectMake(0, 6, textSize.width + 5, textSize.height);
    if(_rightBtnItem.itemType == TWNavBtnItemType_Image){
        textFrame.size.width = textSize.width;
    }
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    btn.frame = textFrame;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, self.rightBtnItem.titleOffsetX, 0, 0);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    flexSpacer.width = (self.rightBtnItem.offetX - 16);  // right btn 的x坐标为10,
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:flexSpacer,rightItem, nil]];
    //btn.backgroundColor = [UIColor randomColor];
}

#pragma mark - 导航栏上按钮action 时间
- (void)leftBtnClicked:(UIButton*)sender{
    // 如果子类设置了block，就让子类负责返回操作，不然，执行默认操作
    if(self.leftBtnClicked){
        self.leftBtnClicked(sender);
        return;
    }
    
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)rightBtnClicked:(UIButton*)sender{
    if(self.rightBtnClicked){
        self.rightBtnClicked(sender);
    }
}

- (void)setupCustomTitle:(NSString*)title;
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName : titleLabel.font};
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    
    titleLabel.frame = [title boundingRectWithSize:size
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:attributes
                                           context:nil];;
    titleLabel.text = title;
    self.navigationItem.titleView = titleLabel;
}

#pragma mark - 默认值设置
- (void)setupDefaultSettings{
    //self.view.backgroundColor = [UIColor orangeColor];
    TWNavBtnItem *leftBtnItem = [[TWNavBtnItem alloc]init];
//    rightBtnItem.leftOffetX = 8;
//    rightBtnItem.titleOffsetX = 5;
//    rightBtnItem.normalImage = [UIImage imageNamed:@"btn_back_n"];
//    rightBtnItem.hilightedImage = [UIImage imageNamed:@"btn_back_h"];
//    rightBtnItem.normalTitleColor = [UIColor redColor];
//    rightBtnItem.titleFont = [UIFont systemFontOfSize:15];
//    rightBtnItem.title = @"返回";
    self.leftBtnItem = leftBtnItem;
}
@end
