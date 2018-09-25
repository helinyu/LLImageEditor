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

#import "YDScrollViewController.h"

@interface ViewController ()

@property (nonatomic, weak) UIButton *btn;
@property (nonatomic, weak) UIButton *scrollViewBtn;

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
    
    UIButton *scrollBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:scrollBtn];
    _scrollViewBtn = scrollBtn;
    [_scrollViewBtn setTitle:@"滑动" forState:UIControlStateNormal];
    [_scrollViewBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_scrollViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100.f);
        make.top.equalTo(self.view).offset(150.f);
    }];
    [_scrollViewBtn addTarget:self action:@selector(onScrollViewAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onTapAction:(UIButton *)btn {
    YDCutViewController *vc = [YDCutViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onScrollViewAction:(UIButton *)btn {
    YDScrollViewController *vc = [YDScrollViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
