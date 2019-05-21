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

    /// 切换到语音控制参数
    private var _onlyVoice: Bool = false
    private var onlyVoice: Bool{
        set{
            _onlyVoice = newValue
            if newValue {
                callingView?.voiceBTN.isHidden = true
            }
        }
        get{
            return _onlyVoice
        }
    }
    
    /// 视图 frame
    var viewRect = CGRect.zero
    
    var callSession: EMCallSession?
    
    /// 控制界面
    lazy var controlView: KPEMVideoControlView = {
        let view = KPEMVideoControlView.init(type: KPEMVideoControlView.ControlType.video)
        self.view.addSubview(view)
        view.delegate = self
        view.isHidden = true
        return view
    }()
    
    /// 呼叫控制界面
    private var callingView: KPEMCallingView?
    
    /// 视频通话类型
    private var callType: KPEMCallingView.callType = .caller
    
    convenience init(type: KPEMCallingView.callType) {
        self.init()
        self.callType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCallingView()
        viewRect = self.view.bounds
        EMClient.shared()?.callManager.add?(self, delegateQueue: nil)
        deploySubviews()
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    /// 加载通话界面
    private func addCallingView(){
        let callingView = KPEMCallingView.init(type: self.callType)
        self.view.addSubview(callingView)
        callingView.delegate = self
        callingView.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenRect.height)
            make.height.equalTo(kScreenRect.width)
            make.center.equalToSuperview()
        }
    }
    
    /// 本地视频
    private func localVideo(aSession: EMCallSession){
        self.callSession = aSession
        aSession.localVideoView = EMCallLocalView.init()
        aSession.localVideoView.scaleMode = EMCallViewScaleModeAspectFill
        aSession.localVideoView?.layer.cornerRadius = 5
        aSession.localVideoView?.layer.masksToBounds = true
        self.view.addSubview(aSession.localVideoView)
        aSession.localVideoView.snp.makeConstraints { (make) in
            make.width.equalTo(90)
            make.height.equalTo(160)
            make.right.equalTo(-10)
            make.bottom.equalTo(-10)
        }
    }
    
    /// 配置子视图
    private func deploySubviews(){
        controlView.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenRect.height)
            make.height.equalTo(kScreenRect.width)
            make.center.equalToSuperview()
        }
    }
    
    /// 接受通话调用
    ///
    /// - Parameter aSession: 通话对象
    private func receiveAnswer(aSession: EMCallSession){
        self.controlView.isHidden = false
        let videoView = KPEMChatHelper.receiveVideoCall(aSession: aSession)
        self.view.addSubview(videoView)
        videoView.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI_2))
        videoView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(kScreenH)
            make.height.equalTo(kScreenW)
        }
        self.view.bringSubview(toFront: controlView)
        self.localVideo(aSession: aSession)
    }
    
    /// 挂断
    private func hangup(){
        KPEMChatHelper.hangupVideoCall(aSession: self.callSession)
    }
    
    /// 应答
    private func answer(){
        guard let callSession = self.callSession else { return }
        let error = EMClient.shared()?.callManager.answerIncomingCall?(callSession.callId)
        guard error != nil else {
            return
        }
        print("=====应答失败\(error.debugDescription)")
    }
    /// 退出
    private func quit(){
        self.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        self.callSession?.localVideoView.removeFromSuperview()
        self.callSession?.remoteVideoView.removeFromSuperview()
        //移除实时通话回调
        EMClient.shared()?.callManager.remove?(self)
    }
}

// MARK: - KPEMVideoControlViewDelegate
extension KPEM1v1VideoVC: KPEMVideoControlViewDelegate{
    func action(sender: UIButton, type: KPEMVideoControlView.ControlEvent?) {
        guard let type = type else { return }
        switch type {
        case .changeVoice:
            break
        case .rollback:
            sender.isSelected = !sender.isSelected
            KPEMChatHelper.switchCamera(aSession: self.callSession, position: sender.isSelected)
        case .mute:
            sender.isSelected = !sender.isSelected
            KPEMChatHelper.videoMute(aSession: self.callSession, isMute: sender.isSelected)
        case .hangup:
            self.hangup()
        case .picture:
            KPEMChatHelper.takeRemoteVideoPicture()
        case .record:
            sender.isSelected = !sender.isSelected
            KPEMChatHelper.recorderVideo(isRecorder: sender.isSelected)
        case .cancel:
            break
        case .monitor2Video:
            break
        case .rollLeft:
            break
        case .rollLeftDown:
            break
        case .rollRight:
            break
        case .rollRightDown:
            break
        }
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
            self.onlyVoice = true
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
        self.quit()
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
