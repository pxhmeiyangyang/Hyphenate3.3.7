//
//  Color+extension.swift
//  UniToy
//
//  Created by pxh on 2017/10/23.
//  Copyright © 2017年 pxh. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func UniToyWindowColor()->UIColor{
        return UIColor.white
    }
    
    class func UniToyGray()->UIColor{
        return UIColor.hexStringToColor(hexString: "#B0B0B0")
    }
    
    class func UniToyBlack()->UIColor{
        return UIColor.hexStringToColor(hexString: "0X000000")
    }
    
    class func UniToyNaviYellow()->UIColor{
        return UIColor.hexStringToColor(hexString: "FFD636")
    }
    
    class func UniToyNaviGray()->UIColor{
        return UIColor.hexStringToColor(hexString: "606060")
    }
    
    class func UniToyViewGray()->UIColor{
        return UIColor.hexStringToColor(hexString: "F7F9FB")
    }
    
    class func UT4AColor()->UIColor{
        return UIColor.hexStringToColor(hexString: "4A4A4A")
    }
    
    class func UTB0Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "B0B0B0")
    }
    
    class func UT20Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "202020")
    }
    
    class func UT9BColor()->UIColor{
        return UIColor.hexStringToColor(hexString: "9B9B9B")
    }
    
    class func UTF7Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "F7F9FB")
    }
    
    class func UT36Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "364450")
    }
    
    class func UTE4Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "E4EAF4")
    }
    
    class func UTE1Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "E1E1E1")
    }
    
    class func UTFFColor()->UIColor{
        return UIColor.hexStringToColor(hexString: "FFD636")
    }
    
    class func UTFF9571Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "FF9571")
    }
    
    class func UTD8Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "D8D8D8")
    }
    
    class func UT11Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "11BBFF")
    }
    
    class func UT79Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "797979")
    }
    
    //===========================
    
    class func UT27BCFCColor()->UIColor{
        return UIColor.hexStringToColor(hexString: "27BCFC")
    }
    
    class func UTEDEDEDColor()->UIColor{
        return UIColor.hexStringToColor(hexString: "EDEDED")
    }
    
    class func UT999999Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "999999")
    }
    
    
    /// FAQ
    ///
    /// - Returns: FAQ（推荐、我的高亮颜色）
    class func UTFAQ58A23Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "F58A23")
    }
    
    class func UTFAQE2Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "E2E2E2")
    }
    
    class func UTFAQFF3638Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "FF3638")
    }
        
    class func UT535F45Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "535F45")
    }
    
    /// 收藏专辑高亮红色
    ///
    /// - Returns: 红色
    class func UTFB5569Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "FB5569")
    }
    
    // 时间选中底图
    class func UTFCFCFCColor()->UIColor{
        return UIColor.hexStringToColor(hexString: "FCFCFC")
    }
    
    // 配网底图虚线颜色
    class func UTDAColor()->UIColor{
        return UIColor.hexStringToColor(hexString: "DADADA")
    }
    
    // 二维码背景色
    class func UTA1Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "A1A1A1")
    }
    
    // 配网底图分割实线
    class func UTF5Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "#F5F5F5")
    }
    
    //===========================
    
    /// time 时间管理
    ///
    /// - Returns: 色值
    class func UTAE8A00Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "AE8A00")
    }
    
    //开关
    class func UTA2EC61Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "A2EC61")
    }
    
    class func UT69Color()->UIColor{
        return UIColor.hexStringToColor(hexString: "696969")
    }
    
    class func UTFFE26FColor()->UIColor{
        return UIColor.hexStringToColor(hexString: "FFE26F")
    }
    
    class func UTTimeColor0(index: Int)->UIColor{
        
        switch index {
        case 0:
            return UIColor.hexStringToColor(hexString: "FFFAF2")
        case 1:
            return UIColor.hexStringToColor(hexString: "FFE2E2")
        case 2:
            return UIColor.hexStringToColor(hexString: "FFBEBE")
        case 3:
            return UIColor.hexStringToColor(hexString: "FFD5BF")
        case 4:
            return UIColor.hexStringToColor(hexString: "FFEDBE")
        case 5:
            return UIColor.hexStringToColor(hexString: "FFEF80")
        case 6:
            return UIColor.hexStringToColor(hexString: "F4FF63")
        case 7:
            return UIColor.hexStringToColor(hexString: "E2FF51")
        case 8:
            return UIColor.hexStringToColor(hexString: "B1FF62")
        case 9:
            return UIColor.hexStringToColor(hexString: "94FCA2")
        case 10:
            return UIColor.hexStringToColor(hexString: "95E2FF")
        case 11:
            return UIColor.hexStringToColor(hexString: "99C8FF")
        case 12:
            return UIColor.hexStringToColor(hexString: "7AACFF")
        case 13:
            return UIColor.hexStringToColor(hexString: "B6BBFF")
        case 14:
            return UIColor.hexStringToColor(hexString: "D8D8FF")
        case 15:
            return UIColor.hexStringToColor(hexString: "F7D4FE")
        case 16:
            return UIColor.hexStringToColor(hexString: "FFBAD5")
        case 17:
            return UIColor.hexStringToColor(hexString: "FFA3DD")
        default:
            return UIColor.hexStringToColor(hexString: "FFFFFF")
        }
    }
    
    class func UTHintBGColor()->UIColor{
        return UIColor.RGBA(R: 0, G: 0, B: 0, A: 0.6)
    }
    
    class func UTLightHintBGColor()->UIColor{
        return UIColor.RGBA(R: 0, G: 0, B: 0, A: 0.08)
    }
    
    class func RGBA(R : CGFloat,G : CGFloat,B : CGFloat,A : CGFloat)->UIColor{
        return UIColor.init(red: R / 255.0, green: G / 255.0, blue: B / 255.0, alpha: A)
    }
    
    //hex string to color
    class func hexStringToColor(hexString : String)->UIColor{
        var cString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if cString.count < 6 {return UIColor.black}
        
        let index = cString.index(cString.endIndex, offsetBy: -6)
        
        if cString.hasPrefix("0X") {
            cString = String(cString[index ..< cString.endIndex])
        }
        
        if cString.hasPrefix("#") {
            cString = String(cString[index ..< cString.endIndex])
        }
        
        if cString.count != 6 {
            return UIColor.black
        }
        
        var range: NSRange = NSMakeRange(0, 2)
        
        let rString = (cString as NSString).substring(with: range)
        
        range.location = 2
        
        let gString = (cString as NSString).substring(with: range)
        
        range.location = 4
        
        let bString = (cString as NSString).substring(with: range)
        
        
        
        var r: UInt32 = 0x0
        
        var g: UInt32 = 0x0
        
        var b: UInt32 = 0x0
        
        Scanner.init(string: rString).scanHexInt32(&r)
        
        Scanner.init(string: gString).scanHexInt32(&g)
        
        Scanner.init(string: bString).scanHexInt32(&b)
        
        
        
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))
        
    }
}
