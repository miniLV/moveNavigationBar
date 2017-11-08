//
//  ComplexViewController.m
//  MoveNavigationBar
//
//  Created by Lyh on 2017/11/8.
//  Copyright © 2017年 xmhccf. All rights reserved.
//

#import "ComplexViewController.h"
#import "HZCarInsOrderConst.h"
#import "HZIasTableTitleView.h"
#import <Masonry.h>

#import "ChildrenOneViewController.h"
#import "ChildrenTwoViewController.h"
#import "ChildrenThreeViewController.h"
#import "ComplexRootViewController.h"

@interface ComplexViewController ()<NavigationViewDelegate>

@property (nonatomic, strong)NSMutableArray *titleBtnsArrrayM;

@end

@implementation ComplexViewController{

    //移动的绿色线条
    UIView *_greenLineView;
    
    UIScrollView *_contentScrollView;
    
    //自定义导航View
    UIView *_navigationView;
    
    UIView *_topBtnsView;
}



#pragma mark - lazy
-(NSMutableArray *)titleBtnsArrrayM{
    
    if (!_titleBtnsArrrayM) {
        
        _titleBtnsArrrayM = [NSMutableArray array];
    }
    return _titleBtnsArrrayM;
}

#pragma mark - lift cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //baseSetting
    [self setBaseSetting];
    
    //setupUI
    [self setupUI];
    
    //addAllChildrenControllers
    [self addBtnChildrenControllers];
    
    //clickFirstBtn
    [self clickTitleBtn:_titleBtnsArrrayM[0]];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}


- (void)setBaseSetting{
    
    self.title = @"test title";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - setupUI
- (void)setupUI{
    
    //1.顶部导航条View
    UIView *navigationView = [self createNavigationView:@"车险订单"];
    [self.view addSubview:navigationView];
    _navigationView = navigationView;
    
    //2.整个topView，包括按钮view && 红色提示view
    UIView *topView = [self createTopView];
    [self.view addSubview:topView];
    _topBtnsView = topView;
    
    //3.btnsView
    UIView *btnsView = [self createTopBtnsView];
    [topView addSubview:btnsView];
    
    //4.底部线条View
    UIView *greenLineView = [self createGreenLineView];
    [btnsView addSubview:greenLineView];
    _greenLineView = greenLineView;
    
    //5.粉色提示view
    HZIasTableTitleView *pinkTipsView = [self createPinkTipsView];
    [topView addSubview:pinkTipsView];
    
    //6.内容scrollView
    UIScrollView *scrollView = [self createContentScrollView];
    scrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:scrollView];
    _contentScrollView = scrollView;
}

- (UIScrollView *)createContentScrollView{
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, CarInsOrderContentScrollViewY, ScreenW, CarInsOrderContentScrollViewH);
    scrollView.contentSize = CGSizeMake(_titleBtnsArrrayM.count * ScreenW, 0);
    scrollView.scrollEnabled = NO;
    return scrollView;
}

- (HZIasTableTitleView *)createPinkTipsView{
    
    HZIasTableTitleView *tipsView = [HZIasTableTitleView createPinkTitleArrowView:@"您有2单“待出单”资料未完善，请前往完善" WithNum:@"2" WithViewY:44];
    
    //箭头按钮
    UIButton *arrowBtn = [[UIButton alloc]init];
    [tipsView addSubview:arrowBtn];
    
    [arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(tipsView);
        make.height.mas_equalTo(tipsView.bounds.size.height);
        make.width.mas_equalTo(20);
    }];
    
    [arrowBtn setImage:[UIImage imageNamed:@"灰箭"] forState:UIControlStateNormal];
    [arrowBtn addTarget:self action:@selector(clickPinkViewArrowBtn) forControlEvents:UIControlEventTouchUpInside];
    
    return tipsView;
    
}

- (UIView *)createNavigationView:(NSString *)titleStr{
    
    UIView *navigationView = [[UIView alloc]init];
    navigationView.frame = CGRectMake(0, topTimeToolH, ScreenW, navigationBarH);
    navigationView.backgroundColor = [UIColor whiteColor];
    
    //1.标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = titleStr;
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    titleLabel.textColor = HZ_1B1A1FColor;
    [navigationView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(navigationView);
        make.centerX.mas_equalTo(navigationView);
    }];
    
    
    //2.返回按钮
    UIButton *popBtn = [[UIButton alloc]init];
    [popBtn addTarget:self action:@selector(clickPopBtn) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:popBtn];
    [popBtn setBackgroundImage:[UIImage imageNamed:@"绿色箭左"] forState:UIControlStateNormal];
    [popBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(navigationView);
        make.left.mas_equalTo(DefaultMargin);
        make.width.mas_equalTo(9);
        make.height.mas_equalTo(15);
    }];
    
    //3.底部线条View
    UIView *bottomLineView = [[UIView alloc]init];
    bottomLineView.backgroundColor = HZ_ddddddColor;
    [navigationView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    return navigationView;
    
}

- (UIView *)createTopBtnsView{
    
    //1.basicTopView
    CGFloat btnsViewH = 44;
    
    UIView *btnsView = [[UIView alloc]init];
    btnsView.frame = CGRectMake(0, 0, ScreenW, btnsViewH);

    NSArray *titles = @[@"全部", @"测试1", @"测试2"];

    CGFloat btnW = ScreenW / titles.count;
    //2.addBtns

    for(int i = 0; i < titles.count ; i ++){
        
        CGFloat btnX = btnW * i;

        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(btnX, 0, btnW, btnsViewH);
        
        btn.tag = i;
        [btn addTarget:self action:@selector(clickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:HZ_888888Color forState:UIControlStateNormal];
        [btn setTitleColor:HZ_27CD91Color forState:UIControlStateSelected];
        [btn.titleLabel setFont:HZ_14FontSize];

        [btnsView addSubview:btn];
        
        //添加到按钮数组中
        [self.titleBtnsArrrayM addObject:btn];
        
    }
    
    return btnsView;
}


- (UIView *)createTopView{
    
    UIView *topView = [[UIView alloc]init];
    topView.frame = CGRectMake(0, DefaultNaviHeight, ScreenW, CarInsOrderTopViewH);
    
    return topView;
}


- (UIView *)createGreenLineView{
    
    UIView *greenLineView = [[UIView alloc]init];
    greenLineView.backgroundColor = HZ_27CD91Color;
    
    CGFloat greenLineViewW = ScreenW/3;
    CGFloat greenLineViewH = 2;
    CGFloat greenLineViewY = 44 - greenLineViewH;
    greenLineView.frame = CGRectMake(0, greenLineViewY, greenLineViewW, greenLineViewH);

    return greenLineView;
    
}

#pragma mark - 添加btn对应的控制器
- (void)addBtnChildrenControllers{
    
    ChildrenOneViewController *oneVC = [[ChildrenOneViewController alloc]init];
    [self addChildViewController:oneVC];
    oneVC.delegate = self;
    
    ChildrenTwoViewController *twoVC = [[ChildrenTwoViewController alloc]init];
    [self addChildViewController:twoVC];
    twoVC.delegate = self;
    
    ChildrenThreeViewController *threeVC = [[ChildrenThreeViewController alloc]init];
    [self addChildViewController:threeVC];
    twoVC.delegate = self;
    
    
}


#pragma mark - private Btn click
- (void)clickTitleBtn:(UIButton *)sender{
    
    //清除所有按钮的点击状态
    [self clearTitleBtnsSelected:self.titleBtnsArrrayM];
    
    sender.selected = YES;
    
    //线条移动
    [UIView animateWithDuration:0.5 animations:^{
        _greenLineView.center = CGPointMake(sender.center.x, _greenLineView.center.y);
    }];
    
    //scrollView - 滚动
    CGFloat viewX = sender.tag * ScreenW;
    _contentScrollView.contentOffset = CGPointMake(viewX, 0);
    
    [self addChildViewToScrollView:sender.tag];
}

///清除全部按钮的选择状态
- (void)clearTitleBtnsSelected:(NSArray *)array{
    
    for (int i = 0 ; i < array.count;  i ++) {
        
        UIButton *btn = array[i];
        btn.selected = NO;
    }
    
}

- (void)addChildViewToScrollView:(NSInteger)index{
    
    UIViewController *vc = self.childViewControllers[index];
    
    if (vc.view.superview) {
        
        //如果这个view已经创建了
        return;
    }
    CGFloat vcX = index * ScreenW;
    
    vc.view.frame = CGRectMake(vcX, 0, ScreenW, CarInsOrderContentScrollViewH);
    
    [_contentScrollView addSubview:vc.view];
}


- (void)clickPopBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickRightListBtn{
    
    MNLog(@"clickRightListBtn")
}


#pragma mark - private Delegate
-(void)changeNavigationViewShow:(BOOL)hidden{
    
    if (hidden) {
        //导航条隐藏
        
//        if (_navigationView.hidden) return;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            _navigationView.hidden = YES;
            
            //按钮View上移
            CGRect tempShowViewFrame =  _topBtnsView.frame;
            tempShowViewFrame.origin.y -= navigationBarH;
            _topBtnsView.frame = tempShowViewFrame;
            
            //修改scrollview
            CGRect tempScrollViewFrame = _contentScrollView.frame;
            tempScrollViewFrame.origin.y -= navigationBarH;
            tempScrollViewFrame.size.height += navigationBarH;
            _contentScrollView.frame = tempScrollViewFrame;
        }];
        
        
        
    }
    else{
        
//        if (_navigationView.hidden == NO) return;
        
        [UIView animateWithDuration:0.25 animations:^{
            _navigationView.hidden = NO;
            
            CGRect tempShowViewFrame =  _topBtnsView.frame;
            tempShowViewFrame.origin.y += navigationBarH;
            _topBtnsView.frame = tempShowViewFrame;
            
            //修改scrollview
            CGRect tempScrollViewFrame = _contentScrollView.frame;
            tempScrollViewFrame.origin.y += navigationBarH;
            tempScrollViewFrame.size.height -= navigationBarH;
            _contentScrollView.frame = tempScrollViewFrame;
            
        }];
        
    }
}

- (void)clickPinkViewArrowBtn{
    
    MNLog(@"HZClickPinkViewArrowBtn")
    
}


@end
