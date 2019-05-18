//
//  KPEMChatHelper.swift
//  EMChat
//
//  Created by pxh on 2019/5/16.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

let testEMName = "123456789"
//azyepndb4t6ixzlksfl64kdeq656waparzir2cqp6outu3dzfn11  //机器人

/// karPro 环信聊天助手
class KPEMChatHelper: NSObject {
    
    /// 环信APP key 正式 请替换
    static let EMAppKey = "1131190320085875#lidaobaochat"
    
    /// 单例对象
    static let shared = KPEMChatHelper()
    
    private override init() {
        super.init()
        deployDelegate()
    }
    
    /// 遵循所有环信协议
    private func deployDelegate(){
        EMClient.shared()?.add(self, delegateQueue: nil)
        EMClient.shared()?.groupManager.add(self, delegateQueue: nil)
        EMClient.shared()?.contactManager.add(self, delegateQueue: nil)
        EMClient.shared()?.roomManager.add(self, delegateQueue: nil)
        EMClient.shared()?.chatManager.add(self, delegateQueue: nil)
        EMClient.shared()?.callManager.add?(self, delegateQueue: nil)
    }
    
    /// 环信聊天helper 清理函数
    func _clearHelper(){
        KPEMChatHelper.quit()
    }
    
    /// 空函数 进行环信初始化
    func empty(){
    }
    
    
    deinit {
        EMClient.shared()?.removeDelegate(self)
        EMClient.shared()?.groupManager.removeDelegate(self)
        EMClient.shared()?.contactManager.removeDelegate(self)
        EMClient.shared()?.roomManager.remove(self)
        EMClient.shared()?.chatManager.remove(self)
        EMClient.shared()?.callManager.remove?(self)
    }
}

// MARK: - EMClientDelegate
extension KPEMChatHelper: EMClientDelegate{
    //网络状态变化
    func connectionStateDidChange(_ aConnectionState: EMConnectionState) {
        
    }
    
    func autoLoginDidCompleteWithError(_ aError: EMError!) {
        if (aError != nil) {
            
        }else if EMClient.shared().isConnected{
            
        }
    }
    
    func userAccountDidLoginFromOtherDevice() {
        _clearHelper()
        NotificationCenter.default.post(name: NSNotification.Name.init(KNOTIFICATION_LOGINCHANGE), object: NSNumber.init(value: false))
        
    }
    
    func userAccountDidRemoveFromServer() {
        _clearHelper()
        NotificationCenter.default.post(name: NSNotification.Name.init(KNOTIFICATION_LOGINCHANGE), object: NSNumber.init(value: false))
    }
    
    func userDidForbidByServer() {
        _clearHelper()
        NotificationCenter.default.post(name: NSNotification.Name.init(KNOTIFICATION_LOGINCHANGE), object: NSNumber.init(value: false))
    }
}

// MARK: - EMChartManagerDelegate
extension KPEMChatHelper: EMChatManagerDelegate{
    func didUpdateConversationList(_ aConversationList: [Any]!) {
        
    }
    func didReceiveMessages(_ aMessages: [Any]!) {
        
    }
}

// MARK: - EMGroupManagerDelegate
extension KPEMChatHelper: EMGroupManagerDelegate{
    func didReceiveLeavedGroup(_ aGroup: EMGroup!, reason aReason: EMGroupLeaveReason) {
        
    }
    
    func didReceiveJoinGroupApplication(_ aGroup: EMGroup!, applicant aApplicant: String!, reason aReason: String!) {
        
    }
    
    func didJoin(_ aGroup: EMGroup!, inviter aInviter: String!, message aMessage: String!) {
        
    }
    
    func didReceiveDeclinedJoinGroup(_ aGroupId: String!, reason aReason: String!) {
        
    }
    
    func didReceiveAcceptedJoin(_ aGroup: EMGroup!) {
        
    }
    
    func didReceiveGroupInvitation(_ aGroupId: String!, inviter aInviter: String!, message aMessage: String!) {
        if aGroupId.count > 0 && aInviter.count > 0 {
            EMClient.shared().groupManager.getGroupSpecificationFromServer(withId: aGroupId, completion: { (aGroup, aError) in
                
            })
        }
    }
}


// MARK: - EMChatroomManagerDelegate
extension KPEMChatHelper: EMChatroomManagerDelegate{
    
}

// MARK: - EMContactManagerDelegate
extension KPEMChatHelper: EMContactManagerDelegate{
    
}


// MARK: - EMCallManagerDelegate
extension KPEMChatHelper: EMCallManagerDelegate{
    /*!
     *  \~chinese
     *  用户A拨打用户B，用户B会收到这个回调
     */
    func callDidReceive(_ aSession: EMCallSession!) {
        let videoVC = KPEM1v1VideoVC.init(type: .called)
        videoVC.callSession = aSession
        KPEMCommon.rootVC()?.present(videoVC, animated: true, completion: nil)
    }
    /*!
     *  \~chinese
     *  通话通道建立完成，用户A和用户B都会收到这个回调
     */
    func callDidConnect(_ aSession: EMCallSession!) {
        
    }
    /*!
     *  \~chinese
     *  用户B同意用户A拨打的通话后，用户A会收到这个回调
     */
    func callDidAccept(_ aSession: EMCallSession!) {
        
    }
    /*!
     *  \~chinese
     *  1. 用户A或用户B结束通话后，双方会收到该回调
     *  2. 通话出现错误，双方都会收到该回调
     */
    func callDidEnd(_ aSession: EMCallSession!, reason aReason: EMCallEndReason, error aError: EMError!) {
        
    }
    
    /*!
     *  \~chinese
     *  用户A和用户B正在通话中，用户A中断或者继续数据流传输时，用户B会收到该回调
     */
    func callStateDidChange(_ aSession: EMCallSession!, type aType: EMCallStreamingStatus) {
        
    }
    
    /*!
     *  \~chinese
     *  用户A和用户B正在通话中，用户A的网络状态出现不稳定，用户A会收到该回调
     
     */
    func callNetworkDidChange(_ aSession: EMCallSession!, status aStatus: EMCallNetworkStatus) {
        
    }
    /*!
     *  \~chinese
     *  建立通话时，自定义语音类别
     */
    func callDidCustomAudioSessionCategoryOptions(withCategory aCategory: String!) {
        
    }
}

// MARK: - 登录注册相关
extension KPEMChatHelper{
    
    /// 初始化环信聊天
    class func initializeEMChat(){
        guard let options = EMOptions.init(appkey: EMAppKey) else { return }
        options.isAutoAcceptGroupInvitation = false
        options.apnsCertName = "chatdemoui_dev"
        EMClient.shared()?.initializeSDK(with: options)
    }
    
    /// 初始化环信视频聊天
    class func initializeVideoCall(){
        guard let manager = EMClient.shared()?.callManager else { return }
        guard let options = manager.getCallOptions?() else { return }
        //当对方不在线时，是否给对方发送离线消息和推送，并等待对方回应
        options.isSendPushIfOffline = false
        //设置视频分辨率：自适应分辨率、352 * 288、640 * 480、1280 * 720
        options.videoResolution = EMCallVideoResolutionAdaptive;
        //最大视频码率，范围 50 < videoKbps < 5000, 默认0, 0为自适应，建议设置为0
        options.maxVideoKbps = 0;
        //最小视频码率
        options.minVideoKbps = 0;
        //是否固定视频分辨率，默认为NO
        options.isFixedVideoResolution = false;
        manager.setCallOptions?(options)
    }
    
    /// 开始视频通话
    ///
    /// - Parameter callBack: 开始回调
    class func startVideoCall(name: String ,ext: String ,callBack: @escaping (_ aCallSession: EMCallSession?,_ aError: EMError?)->()){
        EMClient.shared()?.callManager.start?(EMCallTypeVideo, remoteName: name, ext: ext, completion: { (callSession, error) in
            callBack(callSession,error)
        })
    }
    
    /// 注册
    ///
    /// - Parameters:
    ///   - username: 账号
    ///   - passWord: 密码
    class func register(username: String, passWord: String){
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            let error = EMClient.shared()?.register(withUsername: username, password: passWord)
            DispatchQueue.main.async {
                guard let error = error else {
                    self.login(username: username, passWord: passWord) //注册成功直接登录
                    return
                }
                switch error.code{
                case EMErrorServerNotReachable:
                    
                    break;
                case EMErrorUserAlreadyExist:
                    self.login(username: username, passWord: passWord)  //用户已存在直接登录
                    break;
                case EMErrorNetworkUnavailable:
                    
                    break;
                case EMErrorServerTimeout:
                    
                    break;
                case EMErrorServerServingForbidden:
                    
                    break;
                default:
                    
                    break;
                }
            }
        }
    }
    
    /// 登录
    ///
    /// - Parameters:
    ///   - username: 账号
    ///   - passWord: 密码
    class func login(username: String, passWord: String){
        DispatchQueue.global(qos: .default).async {
            let error = EMClient.shared()?.login(withUsername: username, password: passWord)
            DispatchQueue.main.async {
                guard let error = error else {
                    EMClient.shared()?.options.isAutoLogin = true //开启自动登录
                    
                    DispatchQueue.global(qos: .default).async {
                        EMClient.shared()?.migrateDatabaseToLatestSDK() //做好数据迁移
                        DispatchQueue.main.async {
                            //发送自动登录状态通知
                            NotificationCenter.default.post(name: NSNotification.Name.init(KNOTIFICATION_LOGINCHANGE), object: EMClient.shared()?.isLoggedIn)
                        }
                    }
                    
                    return
                }
                switch error.code {
                case EMErrorNetworkUnavailable:
                    
                    break;
                case EMErrorServerNotReachable:
                    
                    break;
                case EMErrorUserAuthenticationFailed:
                    
                    break;
                case EMErrorServerTimeout:
                    
                    break;
                case EMErrorServerServingForbidden:
                    
                    break;
                case EMErrorUserNotFound: //账户不存在  重新注册 然后登录
                    self.register(username: username, passWord: passWord)
                    break;
                default:
                    print("======环信登录失败")
                    break;
                }
            }
        }
    }
    
    /// 接听视频通话
    class func receiveVideoCall(aSession: EMCallSession, frame: CGRect)->EMCallRemoteView{
        //同意接听视频通话之后
        aSession.remoteVideoView = EMCallRemoteView.init(frame: frame)
        aSession.remoteVideoView.scaleMode = EMCallViewScaleModeAspectFill
        return aSession.remoteVideoView
    }
    
    /// 挂断视频通话
    class func hangupVideoCall(aSession: EMCallSession){
        guard let callId = aSession.callId,
            let manager = EMClient.shared()?.callManager else { return }
        let options = manager.getCallOptions?()
        options?.enableCustomizeVideoData = false
        let error = manager.endCall?(callId, reason: EMCallEndReasonHangup)
        if let _ = error {
            print("挂断失败")
        }
    }
    
    /// 切换摄像头方向
    ///
    /// - Parameter aSession: 通话对象
    class func switchCamera(aSession: EMCallSession, position: Bool){
        aSession.switchCameraPosition(position)
    }
    
    /// 视频静音
    ///
    /// - Parameters:
    ///   - aSession: 通话对象
    ///   - isMute: 是否静音
    class func videoMute(aSession: EMCallSession, isMute: Bool){
        if isMute {
            aSession.pauseVoice()
        }else{
            aSession.resumeVoice()
        }
    }
    
    
    /// 环信文件存储路径
    ///
    /// - Parameter file: 文件类型
    /// - Returns: 返回文件路径
    class func EMFilePath(file: String)->String?{
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return nil}
        let filePath = path + "/KARPro/" + file
        let fileManager = FileManager.default
        var directoryExists = ObjCBool(false)
        if fileManager.fileExists(atPath: filePath, isDirectory: &directoryExists){
            do{
                try fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
            }catch{
            }
        }
        return filePath
    }
    
    
    /// 截取远程视频
    class func takeRemoteVideoPicture(){
        guard let filePath = self.EMFilePath(file: "image") else { return }
        let time = Date().timeIntervalSince1970
        let fileName = String.init(format: "%@/%.0f.jpeg", filePath, time)
        EMCallRecorderPlugin.sharedInstance()?.screenCapture(toFilePath: fileName, error: nil)
    }
    
    /// 录制视频
    class func recorderVideo(isRecorder: Bool){
        guard let filePath = self.EMFilePath(file: "video") else { return }
        if isRecorder {
            EMCallRecorderPlugin.sharedInstance()?.startVideoRecording(toFilePath: filePath, error: nil)
        }else{
            let path = EMCallRecorderPlugin.sharedInstance()?.stopVideoRecording(nil)
            print("录制视频路径\(path)")
        }
    }
    
    
    /// 退出函数
    class func quit(){
        guard let error = EMClient.shared()?.logout(true) else {
            print("环信退出成功")
            return
        }
        print(error.description)
    }
}
