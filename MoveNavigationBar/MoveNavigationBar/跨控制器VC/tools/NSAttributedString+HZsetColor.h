//
//  NSAttributedString+HZsetColor.h
//  HCCF
//
//  Created by Lyh on 2017/10/24.
//  Copyright © 2017年 xmhccf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (HZsetColor)


/**
 为n位字符串赋值颜色

 @param tempStr 传进来的整个字符串
 @param attrDic 富文本属性
 @param startIndex NSRange起始坐标
 @param num 要设置颜色改变的num
 @return 富文本字符串
 */
+ (NSAttributedString *_Nullable)getAnyDigitAttrNum:(NSString *_Nullable)tempStr attrDic:(nullable NSDictionary *)attrDic startIndex:(NSInteger)startIndex withNum:(NSString *_Nullable)num;

@end
