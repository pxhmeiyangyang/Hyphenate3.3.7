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
    
    /// 通话计时
    private var callDurationTimer: Timer?
    private var callDuration: Int = 0
    
    //加载控制界面 屏幕切换控制
    let fullControlView = KPEMVideoControlView.init(type: .monitoring)
    
    /*
     * 记录进入全屏前的parentView和frame
     */
    var movieViewParentView: UIView? = nil
    var movieViewFrame = CGRect.zero
    
    /// 设备旋转控制
    private var orientationTimer: Timer?
    private var orientationCount: Int = 0
    /// 视屏界面
    lazy var videoView: UIView = {
        let view = UIView()
        self.view.addSubview(view)
        view.backgroundColor = UIColor.black
        return view
    }()
    
    /// 计时标签
    lazy var timeLB: UILabel = {
        let view = UILabel()
        videoView.addSubview(view)
        view.textColor = UIColor.white
        view.font = UIFont.systemFont(ofSize: 16)
        view.textAlignment = NSTextAlignment.right
        view.backgroundColor = UIColor.clear
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
        view.setBackgroundImage(UIImage.init(named: "video_anjian_L"), for: UIControlState.highlighted)
        view.setBackgroundImage(UIImage.init(named: "video_anjian_LS"), for: UIControlState.disabled)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.addTarget(self, action: #selector(buttonDragDown(sender:)), for: UIControlEvents.touchDown)
        view.tag = 2000
        return view
    }()
    
    /// 右侧控制按钮
    lazy var rightBTN: UIButton = {
        let view = UIButton()
        controlBG.addSubview(view)
        view.setBackgroundImage(UIImage.init(named: "video_anjian_R"), for: UIControlState.normal)
        view.setBackgroundImage(UIImage.init(named: "video_anjian_R"), for: UIControlState.highlighted)
        view.setBackgroundImage(UIImage.init(named: "video_anjian_RS"), for: UIControlState.disabled)
        view.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
        view.addTarget(self, action: #selector(buttonDragDown(sender:)), for: UIControlEvents.touchDown)
        view.tag = 2001
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "安全监控"
        monitoring()
        deploySubviews()
        NotificationCenter.default.addObserver(self, selector: #selector(notiAction(noti:)), name: orientationNN, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.huangup()
    }
    
    /// 监控
    private func monitoring(){
        EMClient.shared()?.callManager.add?(self, delegateQueue: nil)
        KPEMChatHelper.startVideoCall(name: testEMName, ext: "peep") { (callSession, error) in
            self.callSession = callSession
        }
    }
    
    /// 接受通话调用
    ///
    /// - Parameter aSession: 通话对象
    private func receiveAnswer(aSession: EMCallSession){
        //同意接听视频通话之后
        let videoView = KPEMChatHelper.receiveVideoCall(aSession: aSession)
        self.videoView.addSubview(videoView)
        aSession.remoteVideoView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.videoView.bringSubview(toFront: simpleControlView)
        self.videoView.bringSubview(toFront: timeLB)
        self.callSession = aSession
    }
    
    /// 配置子view
    private func deploySubviews(){
        videoView.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            make.left.right.equalTo(0)
            make.height.equalTo(autoLayoutX(X: 260))
        }
        
        timeLB.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.right.equalTo(-10)
        }
        
        simpleControlView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.right.bottom.equalTo(0)
        }
        
        
        let interval = kScreenW * 0.25
        for i in 2...5 {
            let button = UIButton()
            simpleControlView.addSubview(button)
            button.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.centerX.equalTo((CGFloat(i - 2) + 0.5) * interval)
                make.width.equalTo(25)
                make.height.equalTo(21)
            }
            button.tag = i
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside)
            switch i {
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
    
    
    
    /// 全屏
    private func fullScreen(){
        guard let callSession = self.callSession else { return }
        guard let window = UIApplication.shared.keyWindow else { return }
        guard let _ = callSession.remoteVideoView else { return }
        self.movieViewParentView = callSession.remoteVideoView.superview
        self.movieViewFrame = callSession.remoteVideoView.frame
        UIApplication.shared.setStatusBarHidden(true, with: UIStatusBarAnimation.none)
        callSession.remoteVideoView.removeFromSuperview()
        window.addSubview(callSession.remoteVideoView)
        callSession.remoteVideoView.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI_2))
        callSession.remoteVideoView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(kScreenH)
            make.height.equalTo(kScreenW)
        }
        fullControlView.delegate = self
        callSession.remoteVideoView.addSubview(fullControlView)
        fullControlView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    /// 半屏
    private func halfScreen(){
        guard let callSession = self.callSession else { return }
        UIApplication.shared.setStatusBarHidden(false, with: UIStatusBarAnimation.none)
        let frame = self.movieViewParentView?.convert(self.movieViewFrame, to: UIApplication.shared.keyWindow)
        fullControlView.removeFromSuperview()
        callSession.remoteVideoView.transform = CGAffineTransform.identity
        callSession.remoteVideoView.frame = frame!
        
        callSession.remoteVideoView.removeFromSuperview()
        callSession.remoteVideoView.frame = self.movieViewFrame
        self.movieViewParentView?.addSubview(callSession.remoteVideoView)
        self.movieViewParentView?.sendSubview(toBack: callSession.remoteVideoView)
    }
    
    /// 挂断通话
    private func huangup(){
        stopCallDurationTimer()
        KPEMChatHelper.hangupVideoCall(aSession: self.callSession)
    }
    
    /// 监控转视频通话
    private func monitor2Video(){
        huangup()
        self.navigationController?.popViewController(animated: false)
        NotificationCenter.default.post(name: kMonitorToVideoNN, object: nil)
    }
    
    /// 通知方法
    ///
    /// - Parameter noti: 通知携带数据
    @objc func notiAction(noti: Notification){
        guard let object = noti.object as? String else { return }
        if object == "min" {
            leftBTN.isEnabled = false
            fullControlView.rollLeftBTN.isEnabled = false
        }else if object == "max" {
            rightBTN.isEnabled = false
            fullControlView.rollRightBTN.isEnabled = false
        }else{
            leftBTN.isEnabled = true
            rightBTN.isEnabled = true
            fullControlView.rollLeftBTN.isEnabled = true
            fullControlView.rollRightBTN.isEnabled = true
        }
    }
    
    /// 按钮点击事件
    ///
    /// - Parameter sender: 按钮
    @objc private func buttonAction(sender: UIButton){
        print("==========")
        switch sender.tag {
        case 1:  //静音
            sender.isSelected = !sender.isSelected
            KPEMChatHelper.videoMute(aSession: self.callSession, isMute: sender.isSelected)
        case 2:  //录制
            sender.isSelected = !sender.isSelected
            KPEMChatHelper.recorderVideo(isRecorder: sender.isSelected)
        case 3:  //转视频通话
            self.monitor2Video()
        case 4:  //拍照
            KPEMChatHelper.takeRemoteVideoPicture()
        case 5:  //全屏
            fullScreen()
        case 2000:  //左转
            orientationTouchUpInside(left: true)
        case 2001:  //右转
            orientationTouchUpInside(left: false)
        default:
            break
        }
    }
    
    
    /// 按钮抬起转动方法
    ///
    /// - Parameter left: 是否是左转
    private func orientationTouchUpInside(left: Bool){
        stopOrientationTimer()
        if orientationCount == 0{
            orientation(left: left, time: 10)
        }
    }
    
    /// 按钮按下
    ///
    /// - Parameter sender: 按钮
    @objc private func buttonDragDown(sender: UIButton){
        dragDownAction(left: sender.tag == 2000)
    }
    
    
    /// 按下 事件
    ///
    /// - Parameter tag: 事件索引
    private func dragDownAction(left: Bool){
        stopOrientationTimer()
        self.orientationCount = 0
        if left { //左转
            self.orientationTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(leftTimerAction(timer:)), userInfo: nil, repeats: true)
        }else { //右转
            self.orientationTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(rightTimerAction(timer:)), userInfo: nil, repeats: true)
        }
    }
    
    
    /// 停止设备转头及时
    private func stopOrientationTimer(){
        if let _ = orientationTimer{
            self.orientationTimer?.invalidate()
            self.orientationTimer = nil
        }
    }
    
    /// 设备转头方法 左向
    @objc private func leftTimerAction(timer: Timer){
        self.orientationCount += 1
        orientation(left: true, time: 15)
    }
    
    /// 设备转头方法 右向
    @objc private func rightTimerAction(timer: Timer){
        self.orientationCount += 1
        orientation(left: false, time: 15)
    }
    
    /// 转头
    ///
    /// - Parameter left: 左转还是右转
    private func orientation(left: Bool, time: Int){
        let orientation = left ? "left" : "right"
        KPEMChatHelper.sendCMDMessage(ext: ["amplitude":time,"orientation":orientation])
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        huangup()
        EMClient.shared()?.callManager.remove?(self)
    }
    
}

// MARK: - about CallDurationTimer
extension KPEMMonitoringVC{
    /// 开启计时
    private func startCallDurationTimer(){
        self.stopCallDurationTimer()
        self.callDuration = 0
        self.callDurationTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    /// 停止计时
    private func stopCallDurationTimer(){
        if let _ = self.callDurationTimer{
            self.callDurationTimer?.invalidate()
            self.callDurationTimer = nil
        }
    }

    @objc func timerAction(){
        self.callDuration += 1
        let hour = self.callDuration / 3600;
        let m = (self.callDuration - hour * 3600) / 60;
        let s = self.callDuration - hour * 3600 - m * 60;
        
        if (hour > 0) {
            self.timeLB.text = String.init(format: "%i:%i:%i", hour, m, s)
        }
        else if(m > 0){
            self.timeLB.text = String.init(format: "%i:%i", m, s)
        }
        else{
            self.timeLB.text = String.init(format: "00:%i", s)
        }
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
            self.monitor2Video()
        case .rollLeft:
            orientationTouchUpInside(left: true)
        case .rollLeftDown:
            dragDownAction(left: true)
        case .rollRight:
            orientationTouchUpInside(left: false)
        case .rollRightDown:
            dragDownAction(left: false)
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
        KPEMChatHelper.videoMute(aSession: aSession, isMute: true)
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
        startCallDurationTimer()
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
