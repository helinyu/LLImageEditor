//
//  ViewController.m
//  LLImageEditor
//
//  Created by Aka on 2018/9/19.
//  Copyright © 2018年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "YDCutViewController.h"
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic, weak) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    _btn = btn;
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(100.f);
    }];
    [_btn setTitle:@"标题" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(onTapAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onTapAction:(UIButton *)btn {
    YDCutViewController *vc = [YDCutViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
