//
//  KPEM1v1VideoVC.m
//  EMChat
//
//  Created by pxh on 2019/5/16.
//  Copyright © 2019 pxh. All rights reserved.
//

#import "KPEM1v1VideoVC.h"

@interface KPEM1v1VideoVC ()<EMCallManagerDelegate>

@end

@implementation KPEM1v1VideoVC


/**
 初始化视频聊天
 */
+(void)initializeVideoCall{
    EMCallOptions *options = [[EMClient sharedClient].callManager getCallOptions];
    //当对方不在线时，是否给对方发送离线消息和推送，并等待对方回应
    options.isSendPushIfOffline = NO;
    //设置视频分辨率：自适应分辨率、352 * 288、640 * 480、1280 * 720
    options.videoResolution = EMCallVideoResolutionAdaptive;
    //最大视频码率，范围 50 < videoKbps < 5000, 默认0, 0为自适应，建议设置为0
    options.maxVideoKbps = 0;
    //最小视频码率
    options.minVideoKbps = 0;
    //是否固定视频分辨率，默认为NO
    options.isFixedVideoResolution = NO;
    [[EMClient sharedClient].callManager setCallOptions:options];
}

/**
 开始视频聊天
 
 @param type 聊天类型
 @param name 用户名
 */
+(void)startVideoCallType:(EMCallType)type Name: (NSString* )name Block:(typeof(void(^)(EMCallSession *, EMError *)))block{
    [[EMClient sharedClient].callManager startCall:EMCallTypeVideo remoteName:name ext:nil completion:^(EMCallSession *aCallSession, EMError *aError) {
        block(aCallSession,aError);
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/*!
 *  \~chinese
 *  用户A拨打用户B，用户B会收到这个回调
 *
 *  @param aSession  会话实例
 *
 *  \~english
 *  User B will receive this callback after user A dial user B
 *
 *  @param aSession  Session instance
 */
- (void)callDidReceive:(EMCallSession *)aSession{
    
}

/*!
 *  \~chinese
 *  通话通道建立完成，用户A和用户B都会收到这个回调
 *
 *  @param aSession  会话实例
 *
 *  \~english
 *  Both user A and B will receive this callback after connection is established
 *
 *  @param aSession  Session instance
 */
- (void)callDidConnect:(EMCallSession *)aSession{
    
}

/*!
 *  \~chinese
 *  用户B同意用户A拨打的通话后，用户A会收到这个回调
 *
 *  @param aSession  会话实例
 *
 *  \~english
 *  User A will receive this callback after user B accept A's call
 *
 *  @param aSession
 */
- (void)callDidAccept:(EMCallSession *)aSession{
    
}

/*!
 *  \~chinese
 *  1. 用户A或用户B结束通话后，双方会收到该回调
 *  2. 通话出现错误，双方都会收到该回调
 *
 *  @param aSession  会话实例
 *  @param aReason   结束原因
 *  @param aError    错误
 *
 *  \~english
 *  1.The another peer will receive this callback after user A or user B terminate the call.
 *  2.Both user A and B will receive this callback after error occur.
 *
 *  @param aSession  Session instance
 *  @param aReason   Terminate reason
 *  @param aError    Error
 */
- (void)callDidEnd:(EMCallSession *)aSession
            reason:(EMCallEndReason)aReason
             error:(EMError *)aError{
    
}

/*!
 *  \~chinese
 *  用户A和用户B正在通话中，用户A中断或者继续数据流传输时，用户B会收到该回调
 *
 *  @param aSession  会话实例
 *  @param aType     改变类型
 *
 *  \~english
 *  User A and B is on the call, A pause or resume the data stream, B will receive the callback
 *
 *  @param aSession  Session instance
 *  @param aType     Type
 */
- (void)callStateDidChange:(EMCallSession *)aSession
                      type:(EMCallStreamingStatus)aType{
    
}

/*!
 *  \~chinese
 *  用户A和用户B正在通话中，用户A的网络状态出现不稳定，用户A会收到该回调
 *
 *  @param aSession  会话实例
 *  @param aStatus   当前状态
 *
 *  \~english
 *  User A and B is on the call, A network status is not stable, A will receive the callback
 *
 *  @param aSession  Session instance
 *  @param aStatus   Current status
 */
- (void)callNetworkDidChange:(EMCallSession *)aSession
                      status:(EMCallNetworkStatus)aStatus{
    
}

/*!
 *  \~chinese
 *  建立通话时，自定义语音类别
 *
 *  @param aCategory  会话语音类别
 *
 *  \~english
 *  Custom audio catrgory when setting up a call
 *
 *  @param aCategory  Audio catrgory
 */
- (void)callDidCustomAudioSessionCategoryOptionsWithCategory:(NSString *)aCategory{
    
}


@end
