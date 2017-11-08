//
//  NSAttributedString+HZsetColor.m
//  HCCF
//
//  Created by Lyh on 2017/10/24.
//  Copyright © 2017年 xmhccf. All rights reserved.
//

#import "NSAttributedString+HZsetColor.h"
@implementation NSAttributedString (HZsetColor)

///为n位数字 - 赋值-颜色,几位根据传进来的 num 的长度判断，起始位置
+ (NSAttributedString *)getAnyDigitAttrNum:(NSString *)tempStr attrDic:(nullable NSDictionary *)attrDic startIndex:(NSInteger)startIndex withNum:(NSString *)num{
    
    if (!attrDic) {
        attrDic = @{NSForegroundColorAttributeName:HZ_ff5c5cColor};
    }
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:tempStr];
    
    NSRange range1 = NSMakeRange(startIndex, num.length);
    [attrString addAttributes:attrDic range:range1];
    
    return attrString;
}

@end
