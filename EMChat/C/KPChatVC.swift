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
        NotificationCenter.default.addObserver(self, selector: #selector(notificationSelector), name: NSNotification.Name.init(KNOTIFICATION_MAKE1V1CALL), object: nil)
        self.showRefreshHeader = true
        self.tableViewDidTriggerHeaderRefresh()
        deployMessageStyle()
    }
    
    
    /// 设置气泡样式
    private func deployMessageStyle(){
        //设置起泡
        let cell = EaseBaseMessageCell.appearance()
//        cell.sendBubbleBackgroundImage = UIImage.init(named: "<#T##String#>")
//        cell.recvBubbleBackgroundImage = UIImage.init(named: "<#T##String#>")
        //设置头像
        cell.avatarSize = 40
        cell.avatarCornerRadius = 20.0
        //设置字体颜色
        cell.messageTextFont = UIFont.systemFont(ofSize: 16)
        cell.messageTextColor = UIColor.UT20Color()
        cell.messageVoiceDurationFont = UIFont.systemFont(ofSize: 12)
        cell.messageVoiceDurationColor = UIColor.UT4AColor()
        //设置底部输入栏
        self.chatBarMoreView.removeItematIndex(1)
    }
    
    
    @objc func notificationSelector(){
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK: - EaseMessageViewControllerDelegate,EaseMessageViewControllerDataSource
extension KPChatVC: EaseMessageViewControllerDelegate,EaseMessageViewControllerDataSource{
    
}
