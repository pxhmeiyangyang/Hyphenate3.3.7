//
//  KPEM1v1VideoVC.swift
//  EMChat
//
//  Created by pxh on 2019/5/17.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

/// 环信视频聊天界面
class KPEM1v1VideoVC: UIViewController {

    /// 视图 frame
    var viewRect = CGRect.zero
    
    var _callSession: EMCallSession!
    var callSession: EMCallSession!{
        set{
            _callSession = newValue
            localVideo()
        }
        get{
            return _callSession
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCallingView()
        viewRect = self.view.bounds
        EMClient.shared()?.callManager.add?(self, delegateQueue: nil)
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    /// 加载通话界面
    private func addCallingView(){
        let callingView = KPEMCallingView.init(type: .caller)
        self.view.addSubview(callingView)
        callingView.delegate = self
        callingView.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenRect.height)
            make.height.equalTo(kScreenRect.width)
            make.center.equalToSuperview()
        }
    }
    
    /// 本地视频
    private func localVideo(){
        let width: CGFloat = 80.0
        let height = viewRect.height / viewRect.height * width
        callSession.localVideoView = EMCallLocalView.init(frame: CGRect.init(x: viewRect.width - 90, y: 10, width: width, height: height))
        self.view.addSubview(callSession.localVideoView)
        self.view.bringSubview(toFront: callSession.localVideoView)
    }
    
    /// 接受通话调用
    ///
    /// - Parameter aSession: 通话对象
    private func receiveAnswer(aSession: EMCallSession){
        self.callSession = aSession
        //同意接听视频通话之后
        aSession.remoteVideoView = EMCallRemoteView.init(frame: CGRect.init(x: 0, y: 0, width: viewRect.width, height: viewRect.height))
        aSession.remoteVideoView.scaleMode = EMCallViewScaleModeAspectFill
        self.view.addSubview(aSession.remoteVideoView)
    }
    
    /// 挂断
    private func hangup(){
        guard let callId = self.callSession.callId,
            let manager = EMClient.shared()?.callManager else { return }
        let options = manager.getCallOptions?()
        options?.enableCustomizeVideoData = false
        let error = manager.endCall?(callId, reason: EMCallEndReasonHangup)
        if let _ = error {
            print("挂断失败")
        }
    }
    
    /// 应答
    private func answer(){
        let error = EMClient.shared()?.callManager.answerIncomingCall?(self.callSession.callId)
        guard error != nil else {
            return
        }
        print("=====应答失败\(error.debugDescription)")
    }
    
    
    deinit {
        //移除实时通话回调
        EMClient.shared()?.callManager.remove?(self)
    }
}
// MARK: - KPEMCallingViewDelegate
extension KPEM1v1VideoVC: KPEMCallingViewDelegate{
    func action(index: Int) {
        switch index {
        case 2000: //取消
            self.hangup()
        case 2001: //接听
            self.answer()
        case 2002: //切换
            break
        default:
            break
        }
    }
}
// MARK: - EMCallManagerDelegate
extension KPEM1v1VideoVC: EMCallManagerDelegate{
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
    func callDidReceive(_ aSession: EMCallSession!) {
        
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
    func callDidConnect(_ aSession: EMCallSession!) {
        
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
    func callDidAccept(_ aSession: EMCallSession!) {
        self.receiveAnswer(aSession: aSession)
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
    func callDidEnd(_ aSession: EMCallSession!, reason aReason: EMCallEndReason, error aError: EMError!) {
        
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
    func callStateDidChange(_ aSession: EMCallSession!, type aType: EMCallStreamingStatus) {
        
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
    func callNetworkDidChange(_ aSession: EMCallSession!, status aStatus: EMCallNetworkStatus) {
    
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
    func callDidCustomAudioSessionCategoryOptions(withCategory aCategory: String!) {
        
    }
}
