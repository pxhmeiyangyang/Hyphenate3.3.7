//
//  KPChatVC.swift
//  EMChat
//
//  Created by pxh on 2019/5/16.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit
/// 聊天界面
class KPChatVC: EaseMessageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(notiAction(noti:)), name: NSNotification.Name.init(KPChatBarMoreNN), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notiAction(noti:)), name: NSNotification.Name.init(KPRecordTimeOutNN), object: nil)
        self.showRefreshHeader = true
        self.tableViewDidTriggerHeaderRefresh()
        deployMessageStyle()
        self.delegate = self
        self.dataSource = self
        
    }
    
    
    /// 设置气泡样式
    private func deployMessageStyle(){
        //设置起泡
        let cell = EaseBaseMessageCell.appearance()
        cell.sendBubbleBackgroundImage = UIImage.init(named: "Combined-ShapeL")?.stretchableImage(withLeftCapWidth: 8, topCapHeight: 8)
        cell.recvBubbleBackgroundImage = UIImage.init(named: "Combined Shape")?.stretchableImage(withLeftCapWidth: 8, topCapHeight: 8)
        //设置头像
        cell.avatarSize = 40
        cell.avatarCornerRadius = 20.0
        //设置字体颜色
        cell.messageTextFont = UIFont.systemFont(ofSize: 16)
        cell.messageTextColor = UIColor.UT20Color()
        cell.messageVoiceDurationFont = UIFont.systemFont(ofSize: 12)
        cell.messageVoiceDurationColor = UIColor.UT4AColor()
        //设置语音消息图片样式
        var sendImages = [UIImage]()
        var recvImages = [UIImage]()
        for i in 0...3 {
            var index = 0
            if i == 0{
                index = 3
            }else{
                index = i
            }
            if let sendImage = UIImage.init(named: "chat_shengyinR\(index)"){
                sendImages.append(sendImage)
            }
            if let recvImage = UIImage.init(named: "chat_shengyinL\(index)"){
                recvImages.append(recvImage)
            }
        }
        cell.sendMessageVoiceAnimationImages = sendImages
        cell.recvMessageVoiceAnimationImages = recvImages
    }
    
    
    @objc func notiAction(noti: NSNotification){
        if noti.name == NSNotification.Name.init(KPRecordTimeOutNN){
            //在这里终止录音
        }else if noti.name == NSNotification.Name.init(KPChatBarMoreNN){
            guard let button = noti.object as? UIButton else { return }
            if button.tag == 1000 { //视频通话
                KPEMChatHelper.present1v1VideoCall(rootVC: self)
            }else if button.tag == 1001{ //安全监看
                self.navigationController?.pushViewController(KPEMMonitoringVC(), animated: true)
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK: - EaseMessageViewControllerDelegate
extension KPChatVC: EaseMessageViewControllerDelegate{
    
}

// MARK: - EaseMessageViewControllerDataSource
extension KPChatVC: EaseMessageViewControllerDataSource{
    /*!
     @method
     @brief 将EMMessage类型转换为符合<IMessageModel>协议的类型
     @discussion 将EMMessage类型转换为符合<IMessageModel>协议的类型,设置用户信息,消息显示用户昵称和头像
     @param viewController 当前消息视图
     @param EMMessage 聊天消息对象类型
     @result 返回<IMessageModel>协议的类型
     */
    func messageViewController(_ viewController: EaseMessageViewController!, modelFor message: EMMessage!) -> IMessageModel! {
        message.chatType = EMChatTypeChat;
        let model = EaseMessageModel.init(message: message)
        if model?.isSender ?? false {
            model?.avatarImage = UIImage.init(named: "chat_speek_face1")
            model?.nickname = ""
        }else{
            model?.avatarImage = UIImage.init(named: "chat_babyface")
            model?.nickname = "123123213"
        }
        model?.avatarURLPath = ""
        return model
    }
    //是否允许长按
    func messageViewController(_ viewController: EaseMessageViewController!, canLongPressRowAt indexPath: IndexPath!) -> Bool {
        return true
    }
    //触发长按手势
    func messageViewController(_ viewController: EaseMessageViewController!, didLongPressRowAt indexPath: IndexPath!) -> Bool {
        //给出长按menu 图
        guard let cell = self.tableView.cellForRow(at: indexPath) as? EaseMessageCell else { return true }
        cell.becomeFirstResponder()
        self.menuIndexPath = indexPath
        self.showMenuViewController(cell.bubbleView, andIndexPath: indexPath, messageType: cell.model.bodyType)
        return true
    }
    
}
