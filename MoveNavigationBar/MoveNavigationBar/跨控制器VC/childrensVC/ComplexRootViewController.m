//
//  ComplexRootViewController.m
//  MoveNavigationBar
//
//  Created by Lyh on 2017/11/8.
//  Copyright © 2017年 xmhccf. All rights reserved.
//

#import "ComplexRootViewController.h"
#import "HZCarInsOrderConst.h"
#import <MJRefresh/MJRefresh.h>
@interface ComplexRootViewController ()<UITableViewDelegate, UITableViewDataSource>

-(showType)type;

@end

@implementation ComplexRootViewController{

    UITableView *_tableView;
    
    NSString *_contentStr;
}

-(showType)type{

    return TypeOne;
}

- (void)viewDidLoad{

    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadDatas];
    
    
}

#pragma mark - setupUI
- (void)setupUI{
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.frame = CGRectMake(0, 0, ScreenW, CarInsOrderContentScrollViewH);
    tableView.delegate = self;
    tableView.dataSource = self;

    [self.view addSubview:tableView];
    _tableView = tableView;

    
    //下拉刷新
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDatas)];

//    //监听tableView 的滚动方向 - 设置导航条的隐藏or显示
    [tableView addObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
}

#pragma mark - loadDatas
- (void)loadDatas{

    switch (self.type) {
        case TypeOne:{
            _contentStr = @"typeOne ----";
            break;
        }
        case TypeTwo:{
            _contentStr = @"TypeTwo ----";
            break;
        }
        case TypeThree:{
            _contentStr = @"TypeThree ----";
            break;
        }
        default:
            break;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        [_tableView.mj_header endRefreshing];
    });

    [_tableView reloadData];
    
}

#pragma mark - <UITableViewDelegate>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 200;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        
        cell = [UITableViewCell new];
    }
    cell.textLabel.text = _contentStr;
    return cell;
}

#pragma mark - <KVO>
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    CGFloat oldOffsetY = [change[NSKeyValueChangeOldKey] CGPointValue].y;
    CGFloat newOffsetY = [change[NSKeyValueChangeNewKey] CGPointValue].y;
    CGFloat deltaY = newOffsetY - oldOffsetY;
    
    
    if(deltaY >= 80) {  //向上滚动
        
        if (_tableView.frame.size.height == ScreenH - (topTimeToolH + CarInsOrderTopViewH )) {
            return;
        }
        
        if ([_delegate respondsToSelector:@selector(changeNavigationViewShow:)]) {
            
            [_delegate changeNavigationViewShow:YES];
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            
            //tableView要变高
            CGRect tempTableViewFrame = _tableView.frame;
            tempTableViewFrame.size.height += navigationBarH;
            _tableView.frame = tempTableViewFrame;
            
        }];
        
    }
    else if (deltaY <= -50){
        
        if (_tableView.frame.size.height == ScreenH - (topTimeToolH + CarInsOrderTopViewH + navigationBarH)) {
            return;
        }
        
        if ([_delegate respondsToSelector:@selector(changeNavigationViewShow:)]) {
            
            [_delegate changeNavigationViewShow:NO];
            
        }
        [UIView animateWithDuration:0.25 animations:^{
            
            //tableView要变矮
            CGRect tempTableViewFrame = _tableView.frame;
            tempTableViewFrame.size.height -= navigationBarH;
            _tableView.frame = tempTableViewFrame;
            
        }];
    }
    
}

@end
