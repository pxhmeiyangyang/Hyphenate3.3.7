//
//  KPEMChatHelper.swift
//  EMChat
//
//  Created by pxh on 2019/5/16.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

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

// MARK: - 登录注册相关
extension KPEMChatHelper{
    
    /// 初始化环信聊天
    class func initializeEMChat(){
        guard let options = EMOptions.init(appkey: EMAppKey) else { return }
        options.isAutoAcceptGroupInvitation = false
        options.apnsCertName = "chatdemoui_dev"
        EMClient.shared()?.initializeSDK(with: options)
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
    
    /// 退出函数
    class func quit(){
        guard let error = EMClient.shared()?.logout(true) else {
            print("环信退出成功")
            return
        }
        print(error.description)
    }
}
