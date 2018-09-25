//
//  YDCutViewController.m
//  LLImageEditor
//
//  Created by Aka on 2018/9/19.
//  Copyright © 2018年 Aka. All rights reserved.
//

#import "YDCutViewController.h"
#import <Masonry.h>

@interface YDCutViewController ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *focusImgView;

@property (nonatomic, strong) UIBarButtonItem *editorBtn;

@property (nonatomic, strong) UIView *editorView;
@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) UIImageView *editorImgView;
//所有的线条 （8条线条 = 4大 + 4条小） 4个角

@property (nonatomic, strong) UIView *outsideTopLine;
@property (nonatomic, strong) UIView *outsideLeftLine;
@property (nonatomic, strong) UIView *outsideRightLine;
@property (nonatomic, strong) UIView *outsideBottomLine;
//宽度 1

@property (nonatomic, strong) UIView *innerTopLine;
@property (nonatomic, strong) UIView *innerBottomLine;
@property (nonatomic, strong) UIView *innerLeftLine;
@property (nonatomic, strong) UIView *innerRightLine;
//宽度 0.5

@property (nonatomic, assign) CGFloat imgCurWidth;
@property (nonatomic, assign) CGFloat imgCurHeight;

@end

@implementation YDCutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *bgView = [UIView new];
    [self.view addSubview:bgView];
    _bgView = bgView;
    _bgView.backgroundColor= [UIColor blackColor];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIImageView *focusImgView = [UIImageView new];
    [_bgView addSubview:focusImgView];
    _focusImgView =focusImgView;
    _focusImgView.contentMode = UIViewContentModeScaleAspectFit;
    _focusImgView.image = [UIImage imageNamed:@"100sh.jpg"];
    [_focusImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self->_bgView);
    }];
    
    _editorBtn = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(onEditorAction:)];
    self.navigationItem.rightBarButtonItem = _editorBtn;
}

- (void)onEditorAction:(UIButton *)sender {
    NSLog(@"sender ");
   
    [self onCreateCustomView];
    [self onSetEditorView];
    self.focusImgView.hidden = YES;
    [self onSetSideLine];
}

- (void)onCreateCustomView {
    _editorView = [UIView new];
    _editorImgView = [UIImageView new];
    
    _outsideTopLine = [UIView new];
    _outsideBottomLine = [UIView new];
    _outsideLeftLine = [UIView new];
    _outsideRightLine = [UIView new];
    _innerTopLine = [UIView new];
    _innerBottomLine = [UIView new];
    _innerLeftLine = [UIView new];
    _innerRightLine = [UIView new];
    
}

- (void)onSetSideLine {
    [_editorView addSubview:_outsideRightLine];
    [_editorView addSubview:_outsideTopLine];
    [_editorView addSubview:_outsideLeftLine];
    [_editorView addSubview:_outsideBottomLine];
    [_editorView addSubview:_innerLeftLine];
    [_editorView addSubview:_innerRightLine];
    [_editorView addSubview:_innerTopLine];
    [_editorView addSubview:_innerBottomLine];
    
    [_outsideTopLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self->_editorView);
        make.height.mas_equalTo(3.f);
    }];
    
    [_outsideBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self->_editorView);
        make.height.mas_equalTo(3.f);
    }];
    
    [_outsideLeftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(self->_editorView);
        make.width.mas_equalTo(3.f);
    }];
    
    [_outsideRightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self->_editorView);
        make.width.mas_equalTo(3.f);
    }];
    
    [_innerTopLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.editorView).multipliedBy(1.f/3.f);
        make.left.right.equalTo(self.editorView);
        make.height.mas_equalTo(4.f);
    }];
    
    [_innerLeftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.editorView).multipliedBy(1.f/3.f);
        make.top.bottom.equalTo(self.editorView);
        make.width.mas_equalTo(4.f);
    }];
    
    [_innerBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.editorView);
        make.bottom.equalTo(self.editorView).multipliedBy(2.f/3.f);
        make.height.mas_equalTo(4.f);
    }];

    [_innerRightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(4.f);
        make.right.equalTo(self.editorView).multipliedBy(2.f/3.f);
        make.top.bottom.equalTo(self.editorView);
    }];
    
    _outsideTopLine.backgroundColor = [UIColor redColor];
    _outsideBottomLine.backgroundColor = [UIColor redColor];
    _outsideRightLine.backgroundColor = [UIColor redColor];
    _outsideLeftLine.backgroundColor = [UIColor redColor];
   
    _innerTopLine.backgroundColor = [UIColor blueColor];
    _innerLeftLine.backgroundColor = [UIColor grayColor];
    
    _innerBottomLine.backgroundColor = [UIColor greenColor];
    _innerRightLine.backgroundColor = [UIColor orangeColor];
}

- (void)onSetEditorView {
    [self.view addSubview:_editorView];
    
    [_editorView addSubview:_editorImgView];
    _editorImgView.image = [UIImage imageNamed:@"100sh.jpg"];
    [_editorImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.editorView);
    }];
    CGFloat imgWidth = _editorImgView.image.size.width/[UIScreen mainScreen].scale;
    CGFloat imgHeight = _editorImgView.image.size.height/ [UIScreen mainScreen].scale;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat actualWidth = 0;
    CGFloat actualHeight = 0;
    if (imgHeight>0 && imgWidth >0) {
        if (imgWidth <screenWidth && imgWidth < screenHeight) {
            actualWidth = imgWidth;
            actualHeight = imgHeight;
        }
        else if (imgWidth >=screenWidth && imgHeight >=screenHeight) {
            CGFloat imgRatio = imgHeight/imgWidth;
            CGFloat screenRatio = screenHeight/screenWidth;
            if (imgRatio >= screenRatio) { // 高度较长
                actualHeight = screenHeight;
                actualWidth = imgWidth *(screenHeight/imgHeight);
            }
            else {
                actualWidth = screenWidth;
                actualHeight = imgHeight *(screenWidth/imgWidth);
            }
        }
        else if (imgWidth >= screenWidth && imgHeight < screenHeight) {
            actualWidth = screenWidth;
            actualHeight = imgHeight *(screenWidth/imgWidth);
        }
        else if (imgWidth <screenWidth && imgHeight >= screenHeight){
            actualHeight = screenHeight;
            actualWidth = imgWidth *(screenHeight / imgHeight);
        }
        else {}
    }
    [_editorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(actualWidth);
        make.height.mas_equalTo(actualHeight);
    }];
}

@end
