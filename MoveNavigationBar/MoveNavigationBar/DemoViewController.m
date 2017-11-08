//
//  DemoViewController.m
//  MoveNavigationBar
//
//  Created by Lyh on 2017/11/7.
//  Copyright © 2017年 xmhccf. All rights reserved.
//

#import "DemoViewController.h"
#import <Masonry.h>
@interface DemoViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DemoViewController{
    
    UITableView *_tableView;
    
    //导航View
    UIView *_navigationView;
    
    //showView
    UIView *_showView;
}

static CGFloat toolBarH = 20;
static CGFloat navigationBarH = 44;
static CGFloat showViewH = 50;

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    //1.basicSetting
    [self basicSetting];
    
    //2.setupUI
    [self setupUI];
    

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    //移除kvo
    [_tableView removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset))];
}

- (void)basicSetting{

    self.title = @"Demo控制器";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - setupUI
- (void)setupUI{

    //1.toolView
    UIView *toolView = [self createToolView];
    [self.view addSubview:toolView];
    
    //2.navigationBarView
    UIView *navigationBarView = [self createTopView];
    [self.view addSubview:navigationBarView];
    _navigationView = navigationBarView;
    
    //3.showView
    UIView *showView = [self createShowView];
    [self.view addSubview:showView];
    _showView = showView;
    
    //4.tableView
    UITableView *tableView = [[UITableView alloc]init];
    CGFloat tableViewY = navigationBarH + toolBarH + showViewH;
    CGFloat tableViewH = ScreenH - tableViewY;
    tableView.frame = CGRectMake(0, tableViewY, ScreenW, tableViewH);
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    //5.tableView添加KVO监听滑动方向
    [_tableView addObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
}

- (UIView *)createToolView{

    //2.导航条View
    UIView *navigationView = [[UIView alloc]init];
    navigationView.backgroundColor = [UIColor orangeColor];
    navigationView.frame = CGRectMake(0, toolBarH, ScreenW, navigationBarH);
    
    //2.1title
    UILabel *label = [[UILabel alloc]init];
    [navigationView addSubview:label];
    label.text = @"Demo控制器";
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(navigationView);
        make.centerY.mas_equalTo(navigationView);
    }];
    
    //2.2 返回按钮
    UIButton *popBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [popBtn addTarget:self action:@selector(popClick) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:popBtn];
    
    [popBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(navigationView);
    }];

    return navigationView;
}
- (UIView *)createTopView{

    //1.整个topView
    UIView *topView = [[UIView alloc]init];
    topView.frame = CGRectMake(0, 0, ScreenW, toolBarH);
    topView.backgroundColor = [UIColor lightGrayColor];
    
    
    return topView;
    
}

- (UIView *)createShowView{

    UIView *showView = [[UIView alloc]init];
    showView.frame = CGRectMake(0, navigationBarH + toolBarH, ScreenW, showViewH);
    showView.backgroundColor = [UIColor darkGrayColor];
    
    return  showView;
    
}

- (void)popClick{

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <UITableViewDelegate>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        
        cell = [UITableViewCell new];
    }
    cell.textLabel.text = @"test123";
    return cell;
}

#pragma mark - <KVO>
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{

    CGFloat oldOffsetY = [change[NSKeyValueChangeOldKey] CGPointValue].y;
    CGFloat newOffsetY = [change[NSKeyValueChangeNewKey] CGPointValue].y;
    CGFloat deltaY = newOffsetY - oldOffsetY;
    

    if(deltaY >= 15) {  //向上滚动
        NSLog(@"向上滚动 - hidden");
        if (_navigationView.hidden == YES) {
            return;
        }
        [UIView animateWithDuration:0.25 animations:^{
            
            _navigationView.hidden = YES;
            
            CGRect tempShowViewFrame =  _showView.frame;
            tempShowViewFrame.origin.y -= navigationBarH;
            _showView.frame = tempShowViewFrame;
            
            CGRect tempTableViewFrame = _tableView.frame;
            tempTableViewFrame.origin.y -= navigationBarH;
            tempTableViewFrame.size.height += navigationBarH;
            _tableView.frame = tempTableViewFrame;
            
        }];
        
    }
    else if (deltaY <= -15){
    
        if (_navigationView.hidden == NO) {
            return;
        }
        NSLog(@"向下滚动 - show");
        [UIView animateWithDuration:0.25 animations:^{
            
            _navigationView.hidden = NO;
            
            CGRect tempShowViewFrame =  _showView.frame;
            tempShowViewFrame.origin.y += navigationBarH;
            _showView.frame = tempShowViewFrame;
            
            CGRect tempTableViewFrame = _tableView.frame;
            tempTableViewFrame.origin.y += navigationBarH;
            tempTableViewFrame.size.height -= navigationBarH;
            _tableView.frame = tempTableViewFrame;
            
        }];
    }

}

@end
