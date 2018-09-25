//
//  YDScrollViewController.m
//  LLImageEditor
//
//  Created by Aka on 2018/9/25.
//  Copyright © 2018年 Aka. All rights reserved.
//

#import "YDScrollViewController.h"
#import <Masonry.h>

@interface YDScrollViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
//100sh.jpg

@end

@implementation YDScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    _scrollView = [UIScrollView new];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _scrollView.backgroundColor = [UIColor grayColor];
    
    _imageView = [UIImageView new];
    [self.view addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self->_scrollView);
        make.width.height.mas_equalTo(self.view.bounds.size.width);
    }];
    _imageView.image = [UIImage imageNamed:@"100sh.jpg"];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    NSLog(@"viewDidLayoutSubviews");
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"viewWillLayoutSubviews");
}

@end
