//
//  KPEM1v1VideoVC.m
//  EMChat
//
//  Created by pxh on 2019/5/16.
//  Copyright © 2019 pxh. All rights reserved.
//

#import "KPEM1v1VideoVC.h"

@interface KPEM1v1VideoVC ()

@end

@implementation KPEM1v1VideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

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

@end
