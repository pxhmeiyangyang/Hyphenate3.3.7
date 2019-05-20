//
//  KPEMMonitoringVC.swift
//  EMChat
//
//  Created by pxh on 2019/5/17.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

/// 环信聊天 监控界面
class KPEMMonitoringVC: UIViewController {
    
    /// 通话对象
    private var callSession: EMCallSession?
    
    /// 视屏界面
    lazy var videoView: UIView = {
        let view = UIView()
        self.view.addSubview(view)
        view.backgroundColor = UIColor.black
        return view
    }()
    
    /// 简单控制界面
    lazy var simpleControlView: UIView = {
        let view = UIView()
        self.videoView.addSubview(view)
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        return view
    }()
    
    /// 控制界面
    lazy var controlView: UIView = {
        let view = UIView()
        self.view.addSubview(view)
        return view
    }()
    
    /// 控制界面背景
    lazy var controlBG: UIImageView = {
        let view = UIImageView()
        controlView.addSubview(view)
        view.image = UIImage.init(named: "video_bg")
        view.isUserInteractionEnabled = true
        return view
    }()
    
    /// 左侧按钮
    lazy var leftBTN: UIButton = {
        let view = UIButton()
        controlBG.addSubview(view)
        view.setBackgroundImage(UIImage.init(named: "video_anjian_L"), for: UIControlState.normal)
        view.setBackgroundImage(UIImage.init(named: "video_anjian_LS"), for: UIControlState.highlighted)
        return view
    }()
    
    /// 右侧控制按钮
    lazy var rightBTN: UIButton = {
        let view = UIButton()
        controlBG.addSubview(view)
        view.setBackgroundImage(UIImage.init(named: "video_anjian_R"), for: UIControlState.normal)
        view.setBackgroundImage(UIImage.init(named: "video_anjian_RS"), for: UIControlState.highlighted)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "安全监控"
        monitoring()
        deploySubviews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        KPEMChatHelper.hangupVideoCall(aSession: self.callSession)
    }
    
    /// 监控
    private func monitoring(){
        EMClient.shared()?.callManager.add?(self, delegateQueue: nil)
        KPEMChatHelper.startVideoCall(name: testEMName, ext: "peep") { (callSession, error) in
        }
    }
    
    /// 接受通话调用
    ///
    /// - Parameter aSession: 通话对象
    private func receiveAnswer(aSession: EMCallSession){
        self.callSession = aSession
        //同意接听视频通话之后
        let videoView = KPEMChatHelper.receiveVideoCall(aSession: aSession)
        self.videoView.addSubview(videoView)
        aSession.remoteVideoView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.videoView.bringSubview(toFront: simpleControlView)
    }
    
    /// 配置子view
    private func deploySubviews(){
        videoView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(261)
        }
        
        simpleControlView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.right.bottom.equalTo(0)
        }
        
        for i in 1...5 {
            let button = UIButton()
            simpleControlView.addSubview(button)
            button.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.centerX.equalToSuperview().offset(autoLayoutX(X: interval(index: i)))
                make.width.equalTo(25)
                make.height.equalTo(21)
            }
            button.tag = i
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
            switch i {
            case 1:
                button.setImage(UIImage.init(named: "video_icon12"), for: UIControlState.normal)
                button.setImage(UIImage.init(named: "video_icon11"), for: UIControlState.selected)
                break
            case 2:
                button.setImage(UIImage.init(named: "video_icon10"), for: UIControlState.normal)
                button.setImage(UIImage.init(named: "video_icon13"), for: UIControlState.selected)
            case 3:
                button.setImage(UIImage.init(named: "video_icon9"), for: UIControlState.normal)
            case 4:
                button.setImage(UIImage.init(named: "video_icon8"), for: UIControlState.normal)
            case 5:
                button.setImage(UIImage.init(named: "video_icon14"), for: UIControlState.normal)
            default:
                break
            }
        }
        
        controlView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(videoView.snp.bottom)
        }
        
        controlBG.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        leftBTN.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.width.equalTo(180)
            make.height.equalTo(241)
            make.right.equalTo(controlBG.snp.centerX)
        }
        
        rightBTN.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.width.equalTo(180)
            make.height.equalTo(241)
            make.left.equalTo(controlBG.snp.centerX)
        }
    }
    
    /// 间隔
    ///
    /// - Returns: 间隔距离
    private func interval(index: Int)->CGFloat{
        return CGFloat(index - 3) * 77.0
    }
    
    /// 按钮点击事件
    ///
    /// - Parameter sender: 按钮
    @objc private func buttonAction(sender: UIButton){
        switch sender.tag {
        case 1:  //静音
            sender.isSelected = !sender.isSelected
            KPEMChatHelper.videoMute(aSession: self.callSession, isMute: sender.isSelected)
        case 2:  //录制
            sender.isSelected = !sender.isSelected
            KPEMChatHelper.recorderVideo(isRecorder: sender.isSelected)
        case 3:  //转视频通话
            self.huangup()
        case 4:  //拍照
            KPEMChatHelper.takeRemoteVideoPicture()
        case 5:  //全屏
            fullScreen()
        default:
            break
        }
    }
    
    /// 全屏
    private func fullScreen(){
        guard let callSession = self.callSession else { return }
        guard let window = UIApplication.shared.keyWindow else { return }
        callSession.remoteVideoView.removeFromSuperview()
        window.addSubview(callSession.remoteVideoView)
        callSession.remoteVideoView.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI_2))
        callSession.remoteVideoView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(kScreenH)
            make.height.equalTo(kScreenW)
        }
        //加载控制界面
        let controlView = KPEMVideoControlView.init(type: .monitoring)
        controlView.delegate = self
        callSession.remoteVideoView.addSubview(controlView)
        controlView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    /// 半屏
    private func halfScreen(){
        guard let callSession = self.callSession else { return }
        callSession.remoteVideoView.removeFromSuperview()
        callSession.remoteVideoView.transform = CGAffineTransform.init(rotationAngle: CGFloat(-M_PI_2))
        videoView.addSubview(callSession.remoteVideoView)
        videoView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        videoView.sendSubview(toBack: callSession.remoteVideoView)
    }
    
    /// 监控转视频通话
    private func huangup(){
        KPEMChatHelper.hangupVideoCall(aSession: self.callSession)
        self.navigationController?.popViewController(animated: false)
        NotificationCenter.default.post(name: kMonitorToVideoNN, object: nil)
    }
    
    deinit {
        EMClient.shared()?.callManager.remove?(self)
    }
    
}

// MARK: - KPEMVideoControlViewDelegate
extension KPEMMonitoringVC: KPEMVideoControlViewDelegate{
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
            break
        case .picture:
            KPEMChatHelper.takeRemoteVideoPicture()
        case .record:
            sender.isSelected = !sender.isSelected
            KPEMChatHelper.recorderVideo(isRecorder: sender.isSelected)
        case .cancel:
            halfScreen()
        case .monitor2Video:
            self.huangup()
        }
    }
}

// MARK: - EMCallManagerDelegate
extension KPEMMonitoringVC: EMCallManagerDelegate{
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
