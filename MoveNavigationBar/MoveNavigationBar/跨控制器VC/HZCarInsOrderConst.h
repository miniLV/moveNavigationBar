//
//  HZCarInsOrderConst.h
//  HCCF
//
//  Created by Lyh on 2017/11/6.
//  Copyright © 2017年 xmhccf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HZCarInsOrderConst : NSObject

//topView ： btnsVeiw + 红色提示View
extern const CGFloat CarInsOrderTopViewH;

//顶部工具条高度
extern const CGFloat topTimeToolH;

//顶部自定义导航View高度
extern const CGFloat navigationBarH;



///内容scrollview的Y
#define CarInsOrderContentScrollViewY (DefaultNaviHeight + CarInsOrderTopViewH)

///内容scrollView的高度
#define CarInsOrderContentScrollViewH (ScreenH - CarInsOrderContentScrollViewY)




@end
