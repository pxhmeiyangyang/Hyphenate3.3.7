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
    }
    
    
    @objc func notificationSelector(){
        KPEM1v1VideoVC.initializeVideoCall()
        self.present(KPEM1v1VideoVC(), animated: false, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK: - EaseMessageViewControllerDelegate,EaseMessageViewControllerDataSource
extension KPChatVC: EaseMessageViewControllerDelegate,EaseMessageViewControllerDataSource{
    
}
