//
//  ComplexRootViewController.m
//  MoveNavigationBar
//
//  Created by Lyh on 2017/11/8.
//  Copyright © 2017年 xmhccf. All rights reserved.
//

#import "ComplexRootViewController.h"
#import "HZCarInsOrderConst.h"
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
//    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDatas)];
//    
//    _tableView = tableView;
//    
//    //监听tableView 的滚动方向 - 设置导航条的隐藏or显示
//    [tableView addObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
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
    
    [_tableView reloadData];
    
}

#pragma mark - <UITableViewDelegate>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        
        cell = [UITableViewCell new];
    }
    cell.textLabel.text = _contentStr;
    return cell;
}

@end
