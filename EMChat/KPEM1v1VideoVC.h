//
//  KPEM1v1VideoVC.h
//  EMChat
//
//  Created by pxh on 2019/5/16.
//  Copyright © 2019 pxh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Hyphenate/Hyphenate.h>
NS_ASSUME_NONNULL_BEGIN

@interface KPEM1v1VideoVC : UIViewController


/**
 初始化视频聊天
 */
+(void)initializeVideoCall;

/**
 开始视频聊天

 @param type 聊天类型
 @param name 用户名
 */
+(void)startVideoCallType:(EMCallType)type Name: (NSString* )name Block:(typeof(void(^)(EMCallSession *, EMError *)))block;

@end

NS_ASSUME_NONNULL_END
