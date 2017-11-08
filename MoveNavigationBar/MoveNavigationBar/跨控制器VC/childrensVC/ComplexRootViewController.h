//
//  ComplexRootViewController.h
//  MoveNavigationBar
//
//  Created by Lyh on 2017/11/8.
//  Copyright © 2017年 xmhccf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavigationViewDelegate <NSObject>

- (void)changeNavigationViewShow:(BOOL)hidden;

@end

typedef enum orderType:NSInteger{
    TypeOne = 0,
    TypeTwo = 1,
    TypeThree = 2,

}showType;

@interface ComplexRootViewController : UIViewController

@property (nonatomic, weak) id<NavigationViewDelegate> delegate;

@end
