//
//  HZIasTableTitleView.h
//  HCCF
//
//  Created by Lyh on 2017/9/27.
//  Copyright © 2017年 xmhccf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZIasTableTitleView : UIView




/**
 创建粉色的提示view - 带数字 和箭头

 @param title 标题内容
 @param num 显示的数字
 @param viewY view的Y值
 @return HZIasTableTitleView
 */
+ (HZIasTableTitleView *)createPinkTitleArrowView:(NSString *)title WithNum:(NSString *)num WithViewY:(CGFloat)viewY;
@end
