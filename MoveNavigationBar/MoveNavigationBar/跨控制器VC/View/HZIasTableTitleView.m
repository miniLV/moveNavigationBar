//
//  HZIasTableTitleView.m
//  HCCF
//
//  Created by Lyh on 2017/9/27.
//  Copyright © 2017年 xmhccf. All rights reserved.
//

#import "HZIasTableTitleView.h"
#import <Masonry.h>
#import "NSAttributedString+HZsetColor.h"

@implementation HZIasTableTitleView


+ (HZIasTableTitleView *)createPinkTitleArrowView:(NSString *)title WithNum:(NSString *)num WithViewY:(CGFloat)viewY{
    
    HZIasTableTitleView *titleView = [[HZIasTableTitleView alloc]init];
    titleView.frame = CGRectMake(0, viewY, ScreenW, 30);
    titleView.backgroundColor = HZ_FFE8E8Color;
    
    //1.提示图片
    UIImageView *tipsIV = [[UIImageView alloc]init];
    tipsIV.image = [UIImage imageNamed:@"提示"];
    [titleView addSubview:tipsIV];
    
    [tipsIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(titleView);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(12);
        
    }];
    
    //2.label
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.textColor = HZ_383838Color;
    contentLabel.font = HZ_10FontSize;

    NSAttributedString *attr = [NSAttributedString getAnyDigitAttrNum:title attrDic:nil startIndex:2 withNum:num];
    contentLabel.attributedText = attr;
    
    [titleView addSubview:contentLabel];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(titleView);
        make.left.mas_equalTo(tipsIV.mas_right).mas_equalTo(5);
    }];
    

    return titleView;
}

@end
