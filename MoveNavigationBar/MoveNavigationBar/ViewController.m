//
//  ViewController.m
//  MoveNavigationBar
//
//  Created by Lyh on 2017/11/7.
//  Copyright © 2017年 xmhccf. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"
#import "ComplexViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


#pragma mark - IBButton 点击方法
- (IBAction)clickSingleVCPushBtn:(id)sender {
    
    DemoViewController *demoVC = [[DemoViewController alloc]init];

    [self.navigationController pushViewController:demoVC animated:YES];
    
}


- (IBAction)clickComplexVCPushBtn:(id)sender {
    
    ComplexViewController *complexVC = [[ComplexViewController alloc]init];
    [self.navigationController pushViewController:complexVC animated:YES];
    
}

- (IBAction)clickMJRefreshVCBtn:(id)sender {
}


@end
