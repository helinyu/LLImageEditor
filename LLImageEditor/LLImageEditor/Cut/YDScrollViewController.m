//
//  YDScrollViewController.m
//  LLImageEditor
//
//  Created by Aka on 2018/9/25.
//  Copyright © 2018年 Aka. All rights reserved.
//

#import "YDScrollViewController.h"
#import <Masonry.h>

@interface YDScrollViewController ()<UIScrollViewDelegate>

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
    _scrollView.delegate = self;
    _scrollView.maximumZoomScale = NSUIntegerMax;
    _scrollView.bouncesZoom = YES;
    _scrollView.scrollEnabled = YES;
    
    _imageView = [UIImageView new];
    [_scrollView addSubview:_imageView];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self->_imageView.superview);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(self.view.mas_height);
    }];
    _imageView.image = [UIImage imageNamed:@"100sh.jpg"];
    
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll");
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2) {
    NSLog(@"scrollViewDidZoom");
}

@end
