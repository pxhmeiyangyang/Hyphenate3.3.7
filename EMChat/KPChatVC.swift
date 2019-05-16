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
    }
    
}

// MARK: - EaseMessageViewControllerDelegate,EaseMessageViewControllerDataSource
extension KPChatVC: EaseMessageViewControllerDelegate,EaseMessageViewControllerDataSource{
    
}
