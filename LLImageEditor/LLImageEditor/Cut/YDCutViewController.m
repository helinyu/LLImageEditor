//
//  YDCutViewController.m
//  LLImageEditor
//
//  Created by Aka on 2018/9/19.
//  Copyright © 2018年 Aka. All rights reserved.
//

#import "YDCutViewController.h"
#import <Masonry.h>

@interface YDCutViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *focusImgView;

@property (nonatomic, strong) UIBarButtonItem *editorBtn;

@property (nonatomic, strong) UIScrollView *editorView;
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

// 有关四个阴影部分
@property (nonatomic, strong) UIView *topShadow;
@property (nonatomic, strong) UIView *leftShadow;
@property (nonatomic, strong) UIView *rightShadow;
@property (nonatomic, strong) UIView *bottomShadow;

@property (nonatomic, assign) CGFloat imgCurWidth;
@property (nonatomic, assign) CGFloat imgCurHeight;
@property (nonatomic, assign) CGFloat screenContentWidth;
@property (nonatomic, assign) CGFloat screenContentHeight;

//corner
@property (nonatomic, strong) UIView *cornerLeftTopLeftView;
@property (nonatomic, strong) UIView *cornerLeftTopTopView;

@property (nonatomic, strong) UIView *cornerTopRightTopView;
@property (nonatomic, strong) UIView *cornerTopRightRightView;

@property (nonatomic, strong) UIView *cornerLeftBottomLeftView;
@property (nonatomic, strong) UIView *cornerLeftBottomBottomView;

@property (nonatomic, strong) UIView *cornerRightBottomRightView;
@property (nonatomic, strong) UIView *cornerRightBottomBottomView;

@end

@implementation YDCutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *focusImgView = [UIImageView new];
    [self.view addSubview:focusImgView];
    _focusImgView =focusImgView;
    _focusImgView.contentMode = UIViewContentModeScaleAspectFit;
    _focusImgView.image = [UIImage imageNamed:@"100sh.jpg"];
    [_focusImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _editorBtn = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(onEditorAction:)];
    self.navigationItem.rightBarButtonItem = _editorBtn;
}

- (void)onEditorAction:(UIButton *)sender {
    
    [self onCreateCustomView];
    [self onSetEditorView];
    [self caculateImgWidthAndLength];
    [self setShadows];
    [self setTouchImgView];
    [self onSetSideLine];
    [self setCorners];
    
    self.focusImgView.hidden = YES;
}

- (void)setCorners {
    _cornerLeftTopTopView = [UIView new];
    [self.view addSubview:_cornerLeftTopTopView];
    [_cornerLeftTopTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.outsideTopLine.mas_top);
        make.left.equalTo(self.outsideLeftLine);
        make.width.mas_equalTo(40.f);
        make.height.mas_equalTo(10.f);
    }];
    _cornerLeftTopTopView.backgroundColor = [UIColor purpleColor];

    _cornerLeftTopLeftView = [UIView new];
    _cornerLeftTopLeftView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_cornerLeftTopLeftView];
    [_cornerLeftTopLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.outsideLeftLine.mas_left).offset(-10.f);
        make.top.equalTo(self.outsideTopLine).offset(-10.f);
    }];
    
    _cornerTopRightTopView = [UIView new];
    _cornerTopRightTopView.backgroundColor = [UIColor purpleColor];
    [_cornerTopRightTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.outsideTopLine).offset(10.f);
        make.top.equalTo(self.outsideTopLine).offset(-10.f);
    }];
    
}

- (void)setShadows {
    self.topShadow = [UIView new];
    self.leftShadow = [UIView new];
    self.rightShadow = [UIView new];
    self.bottomShadow = [UIView new];
    [self.view addSubview:self.topShadow];
    [self.view addSubview:self.leftShadow];
    [self.view addSubview:self.bottomShadow];
    [self.view addSubview:self.rightShadow];
    self.topShadow.backgroundColor =
    self.bottomShadow.backgroundColor=
    self.leftShadow.backgroundColor =
    self.rightShadow.backgroundColor = [UIColor blackColor];
    [self.topShadow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.width.mas_equalTo(self.imgCurWidth);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_centerY).offset(-self->_imgCurHeight/2.f);
    }];
    [self.bottomShadow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_centerY).offset(self->_imgCurHeight/2.f);
        make.bottom.equalTo(self.view);
        make.width.mas_equalTo(self.imgCurWidth);
        make.centerX.equalTo(self.view);
    }];
    [self.leftShadow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.right.equalTo(self.view.mas_centerX).offset(-self->_imgCurWidth/2.f);
    }];
    [self.rightShadow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.view);
        make.left.equalTo(self.view.mas_centerX).offset(self->_imgCurWidth/2.f);
    }];
}

- (void)onCreateCustomView {
    _editorView = [UIScrollView new];
    _editorView.delegate = self;
    _editorView.maximumZoomScale = NSUIntegerMax;
    _editorView.bouncesZoom = YES;
    _editorView.scrollEnabled = YES;
    
    _editorImgView = [UIImageView new];
    _editorImgView.contentMode = UIViewContentModeScaleAspectFit;
    
    _outsideTopLine = [UIView new];
    _outsideBottomLine = [UIView new];
    _outsideLeftLine = [UIView new];
    _outsideRightLine = [UIView new];
    _innerTopLine = [UIView new];
    _innerBottomLine = [UIView new];
    _innerLeftLine = [UIView new];
    _innerRightLine = [UIView new];
}

- (void)caculateImgWidthAndLength {
    CGFloat imgWidth = _editorImgView.image.size.width/[UIScreen mainScreen].scale;
    CGFloat imgHeight = _editorImgView.image.size.height/ [UIScreen mainScreen].scale;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width -40.f;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height -40.f;
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
    self.imgCurWidth = actualWidth;
    self.imgCurHeight = actualHeight;
}


- (void)onSetSideLine {
    [self.view addSubview:_outsideRightLine];
    [self.view addSubview:_outsideTopLine];
    [self.view addSubview:_outsideLeftLine];
    [self.view addSubview:_outsideBottomLine];
    [self.view addSubview:_innerLeftLine];
    [self.view addSubview:_innerRightLine];
    [self.view addSubview:_innerTopLine];
    [self.view addSubview:_innerBottomLine];
    
    [_outsideTopLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_centerY).offset(-self->_imgCurHeight/2.f);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(self->_imgCurWidth);
        make.height.mas_equalTo(3.f);
    }];
    
    [_outsideBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_centerY).offset(self->_imgCurHeight/2.f);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(self->_imgCurWidth);
        make.height.mas_equalTo(3.f);
    }];

    [_outsideLeftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view.mas_centerX).offset(-self->_imgCurWidth/2.f);
        make.height.mas_equalTo(self->_imgCurHeight);
        make.width.mas_equalTo(3.f);
    }];

    [_outsideRightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(self->_imgCurWidth/2.f);
        make.centerY.equalTo(self.view);
        make.height.mas_equalTo(self->_imgCurHeight);
        make.width.mas_equalTo(3.f);
    }];

    [_innerTopLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(-self.imgCurHeight/6.f);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(self->_imgCurWidth);
        make.height.mas_equalTo(4.f);
    }];

    [_innerBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(self.imgCurHeight/6.f);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(self.imgCurWidth);
        make.height.mas_equalTo(4.f);
    }];

    [_innerLeftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(-self.imgCurWidth/6.f);
        make.centerY.equalTo(self.view);
        make.height.mas_equalTo(self.imgCurHeight);
        make.width.mas_equalTo(4.f);
    }];

    [_innerRightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(self.imgCurWidth/6.f);
        make.centerY.equalTo(self.view);
        make.height.mas_equalTo(self.imgCurHeight);
        make.width.mas_equalTo(4.f);
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
    _editorImgView.image = [UIImage imageNamed:@"100sh.jpg"];
    _editorImgView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setTouchImgView {
    [_editorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    [_editorView addSubview:_editorImgView];
    [_editorImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self->_editorView).offset(20.f);
        make.right.bottom.equalTo(self->_editorView).offset(-20.f);
        make.width.mas_equalTo(self.view.bounds.size.width-40.f);
        make.height.mas_equalTo(self.view.bounds.size.height -40.f);
        make.center.equalTo(self->_editorView);
    }];
}

#pragma mark -- scroll view delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _editorImgView;
}

@end
