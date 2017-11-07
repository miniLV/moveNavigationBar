//
//  ViewController.m
//  MoveNavigationBar
//
//  Created by Lyh on 2017/11/7.
//  Copyright © 2017年 xmhccf. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}



- (IBAction)clickPushBtn:(id)sender {
    
    DemoViewController *demoVC = [[DemoViewController alloc]init];

    [self.navigationController pushViewController:demoVC animated:YES];
    
}

@end
