//
//  ViewController.m
//  ShapeLayerDemo
//
//  Created by 薛彪 on 16/6/1.
//  Copyright © 2016年 薛彪. All rights reserved.
//  用CAShapeLayer和UIBezierPath实现模仿微信下拉刷新的眼睛的动画

#import "ViewController.h"

static const CGFloat layerCenterY = 120.0f;

#define SCREEN_WIDTH                ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT               ([[UIScreen mainScreen] bounds].size.height)


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate
>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView * layerBgView;
@property (assign, nonatomic) CGFloat oldOffSet;
@property (strong, nonatomic) CAShapeLayer *eyeFirstLightLayer;
@property (strong, nonatomic) CAShapeLayer *eyeSecondLightLayer;
@property (strong, nonatomic) CAShapeLayer *eyeballLayer;
@property (strong, nonatomic) CAShapeLayer *topEyesocketLayer;
@property (strong, nonatomic) CAShapeLayer *bottomEyesocketLayer;

@end

@implementation ViewController
////
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_tableView];
    
    [self setupAnimation];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     static NSString * cellId = @"CellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"ShapeLayer Test";
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


- (UIView *)layerBgView {
    if (!_layerBgView) {
        _layerBgView = [[UIView alloc] init];
        _layerBgView.frame = CGRectMake(0,0,70,40);
        _layerBgView.center = CGPointMake(SCREEN_WIDTH/2,layerCenterY);
        [self.view addSubview:_layerBgView];
    }
    return _layerBgView;
}

- (CAShapeLayer *)eyeFirstLightLayer {
    if (!_eyeFirstLightLayer) {
        _eyeFirstLightLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.layerBgView.frame) / 2, CGRectGetHeight(self.layerBgView.frame) / 2);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:CGRectGetWidth(self.layerBgView.frame) * 0.2
                                                        startAngle:(230.f / 180.f) * M_PI
                                                          endAngle:(265.f / 180.f) * M_PI
                                                         clockwise:YES];
        _eyeFirstLightLayer.borderColor = [UIColor blackColor].CGColor;
        _eyeFirstLightLayer.lineWidth = 5.f;
        _eyeFirstLightLayer.path = path.CGPath;
        _eyeFirstLightLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeFirstLightLayer.strokeColor = [UIColor whiteColor].CGColor;
    }
    return _eyeFirstLightLayer;
}

- (CAShapeLayer *)eyeSecondLightLayer {
    if (!_eyeSecondLightLayer) {
        _eyeSecondLightLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.layerBgView.frame) / 2, CGRectGetHeight(self.layerBgView.frame) / 2);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:CGRectGetWidth(self.layerBgView.frame) * 0.2
                                                        startAngle:(211.f / 180.f) * M_PI
                                                          endAngle:(220.f / 180.f) * M_PI
                                                         clockwise:YES];
        _eyeSecondLightLayer.borderColor = [UIColor blackColor].CGColor;
        _eyeSecondLightLayer.lineWidth = 5.f;
        _eyeSecondLightLayer.path = path.CGPath;
        _eyeSecondLightLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeSecondLightLayer.strokeColor = [UIColor whiteColor].CGColor;
        
    }
    return _eyeSecondLightLayer;
}

- (CAShapeLayer *)eyeballLayer {
    if (!_eyeballLayer) {
        _eyeballLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.layerBgView.frame) / 2, CGRectGetHeight(self.layerBgView.frame) / 2);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:CGRectGetWidth(self.layerBgView.frame) * 0.3
                                                        startAngle:(0.f / 180.f) * M_PI
                                                          endAngle:(360.f / 180.f) * M_PI
                                                         clockwise:YES];
        _eyeballLayer.borderColor = [UIColor blackColor].CGColor;
        _eyeballLayer.lineWidth = 1.f;
        _eyeballLayer.path = path.CGPath;
        _eyeballLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeballLayer.strokeColor = [UIColor whiteColor].CGColor;
        _eyeballLayer.anchorPoint = CGPointMake(0.5, 0.5);
        
    }
    return _eyeballLayer;
}

- (CAShapeLayer *)topEyesocketLayer {
    if (!_topEyesocketLayer) {
        _topEyesocketLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.layerBgView.frame) / 2, CGRectGetHeight(self.layerBgView.frame) / 2);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, CGRectGetHeight(self.layerBgView.frame) / 2)];
        [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.layerBgView.frame), CGRectGetHeight(self.layerBgView.frame) / 2)
                     controlPoint:CGPointMake(CGRectGetWidth(self.layerBgView.frame) / 2, center.y - center.y - 28)];
        _topEyesocketLayer.borderColor = [UIColor blackColor].CGColor;
        _topEyesocketLayer.lineWidth = 1.f;
        _topEyesocketLayer.path = path.CGPath;
        _topEyesocketLayer.fillColor = [UIColor clearColor].CGColor;
        _topEyesocketLayer.strokeColor = [UIColor whiteColor].CGColor;
    }
    return _topEyesocketLayer;
}

- (CAShapeLayer *)bottomEyesocketLayer {
    if (!_bottomEyesocketLayer) {
        _bottomEyesocketLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.layerBgView.frame) / 2, CGRectGetHeight(self.layerBgView.frame) / 2);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, CGRectGetHeight(self.layerBgView.frame) / 2)];
        [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.layerBgView.frame), CGRectGetHeight(self.layerBgView.frame) / 2)
                     controlPoint:CGPointMake(CGRectGetWidth(self.layerBgView.frame) / 2, center.y + center.y + 28)];
        _bottomEyesocketLayer.borderColor = [UIColor blackColor].CGColor;
        _bottomEyesocketLayer.lineWidth = 1.f;
        _bottomEyesocketLayer.path = path.CGPath;
        _bottomEyesocketLayer.fillColor = [UIColor clearColor].CGColor;
        _bottomEyesocketLayer.strokeColor = [UIColor whiteColor].CGColor;
        
    }
    return _bottomEyesocketLayer;
}

- (void)setupAnimation {
    self.eyeFirstLightLayer.lineWidth = 0.f;
    self.eyeSecondLightLayer.lineWidth = 0.f;
    self.eyeballLayer.opacity = 0.f;
    self.bottomEyesocketLayer.strokeStart = 0.5f;
    self.bottomEyesocketLayer.strokeEnd = 0.5f;
    self.topEyesocketLayer.strokeStart = 0.5f;
    self.topEyesocketLayer.strokeEnd = 0.5f;
    
    [self.layerBgView.layer addSublayer:self.eyeFirstLightLayer];
    [self.layerBgView.layer addSublayer:self.eyeSecondLightLayer];
    [self.layerBgView.layer addSublayer:self.eyeballLayer];
    [self.layerBgView.layer addSublayer:self.topEyesocketLayer];
    [self.layerBgView.layer addSublayer:self.bottomEyesocketLayer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _tableView) {
        [self animationWith:_tableView.contentOffset.y];
    }
}

- (void)animationWith:(CGFloat)y {
    CGFloat flag =   - 65.f;
    if (y < flag) {
        if (self.eyeFirstLightLayer.lineWidth < 5.f) {
            self.eyeFirstLightLayer.lineWidth += 1.f;
            self.eyeSecondLightLayer.lineWidth += 1.f;
        }
    }
    
    if(y < flag - 20) {
        if (self.eyeballLayer.opacity <= 1.0f) {
            self.eyeballLayer.opacity += 0.1f;
        }
        
    }
    
    if (y < flag - 40) {
        if (self.topEyesocketLayer.strokeEnd < 1.f && self.topEyesocketLayer.strokeStart > 0.f) {
            self.topEyesocketLayer.strokeEnd += 0.1f;
            self.topEyesocketLayer.strokeStart -= 0.1f;
            self.bottomEyesocketLayer.strokeEnd += 0.1f;
            self.bottomEyesocketLayer.strokeStart -= 0.1f;
        }
    }
    
    if (y > flag - 40) {
        if (self.topEyesocketLayer.strokeEnd > 0.5f && self.topEyesocketLayer.strokeStart < 0.5f) {
            self.topEyesocketLayer.strokeEnd -= 0.1f;
            self.topEyesocketLayer.strokeStart += 0.1f;
            self.bottomEyesocketLayer.strokeEnd -= 0.1f;
            self.bottomEyesocketLayer.strokeStart += 0.1f;
        }
    }
    
    if (y > flag - 20) {
        if (self.eyeballLayer.opacity >= 0.0f) {
            self.eyeballLayer.opacity -= 0.1f;
        }
    }
    
    if (y > flag) {
        if (y > _oldOffSet && y < 0) { //如果当前位移大于缓存位移，说明scrollView向上滑动
            self.layerBgView.frame = CGRectMake(self.layerBgView.frame.origin.x,-y,70,40);
        } else {
            self.layerBgView.frame = CGRectMake(0,0,70,40);
            self.layerBgView.center = CGPointMake(SCREEN_WIDTH/2,layerCenterY);
        }
        _oldOffSet = y;
        if (self.eyeFirstLightLayer.lineWidth > 0.f) {
            self.eyeFirstLightLayer.lineWidth -= 1.f;
            self.eyeSecondLightLayer.lineWidth -= 1.f;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
