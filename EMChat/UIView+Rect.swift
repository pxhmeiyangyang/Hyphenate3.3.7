//
//  UIView+Rect.swift
//  EMChat
//
//  Created by pxh on 2019/5/18.
//  Copyright © 2019 pxh. All rights reserved.
//

import UIKit


/// 屏幕frame
let kScreenRect = UIScreen.main.bounds

let kRatioX = kScreenRect.width / 375.0

let kRatioY = kScreenRect.height / 667.0

/// 屏幕高度
let kScreenH = kScreenRect.height

/// 屏幕宽度
let kScreenW = kScreenRect.width


/// 自动布局x轴
///
/// - Parameter X: x布局
/// - Returns: 计算好的值
func autoLayoutX(X: CGFloat)->CGFloat{
    return X * kRatioX
}
/// 自动布局y轴
///
/// - Parameter y: y布局
/// - Returns: 计算好的值
func autoLayoutY(Y: CGFloat)->CGFloat{
    return Y * kRatioY
}

// MARK: - view + rect
extension UIView{
    
}
