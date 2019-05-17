//
//  KPEMCommon.swift
//  EMChat
//
//  Created by pxh on 2019/5/17.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit

/// kar pro 环信公用方法
class KPEMCommon: NSObject {

    /// 获取当前root view controller
    ///
    /// - Returns: 当前window上的view Controller
    class func rootVC()->UIViewController?{
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while topVC?.presentedViewController != nil {
            topVC = topVC?.presentedViewController
        }
        return topVC
    }
    
}
