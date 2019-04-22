//
//  UIColor+Extensions.swift
//  weibotest
//
//  Created by mac on 2018/12/20.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
#if os(iOS) || os(tvOS)
import UIKit

#else
import AppKit
#endif

extension UIColor{
    /// 16进制字符串转UIColor，支持3位，6位，8位
    /// 例：
    ///   #ccc, #0000ff, #a000b5ff
    ///
    /// - Parameter hexString: 16进制字符串
    public convenience init?(_ hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        let red, green, blue, alpha: CGFloat
        switch chars.count {
        case 3:
            chars = chars.flatMap { [$0, $0] }
            fallthrough
        case 6:
            chars = ["F","F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
            red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            return nil
        }
        self.init(red: red, green: green, blue:  blue, alpha: alpha)
    }
    
    
    /*
     /// 其他方法：16进制转UIColor，支持 6位，8位
     convenience init?(_ hexString: String) {
     
     let r, g, b, a: CGFloat
     
     if hexString.hasPrefix("#") {
     let start = hexString.index(hexString.startIndex, offsetBy: 1)
     var hexColor = String(hexString[start...])
     
     if hexColor.count == 6 {
     hexColor = "ff"+hexColor
     }
     
     if hexColor.count == 8 {
     let scanner = Scanner(string: hexColor)
     var hexNumber: UInt64 = 0
     
     if scanner.scanHexInt64(&hexNumber) {
     a = CGFloat((hexNumber & 0xff000000) >> 24) / 255
     r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
     g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
     b = CGFloat(hexNumber & 0x000000ff) / 255
     
     self.init(red: r, green: g, blue: b, alpha: a)
     return
     }
     }
     }
     
     return nil
     }
     */
    
}

extension GGReactive where Base : UIColor{
    /// 获取随机颜色，alpha 为 1
    public static var randomColor: UIColor {
        // 1 / 256 = 0.00390625，所以保留8位即可
        
        srand48(Int(arc4random_uniform(255)))   // 必须加这一句，否则 drand48() 每次运行都一样
        
        let red: CGFloat = CGFloat(drand48().gg.doubleRoundOff(places: 8))
        let green: CGFloat = CGFloat(drand48().gg.doubleRoundOff(places: 8))
        let blue: CGFloat = CGFloat(drand48().gg.doubleRoundOff(places: 8))
        
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    /// 获取随机颜色，alpha也是随机
    public static var randomColorAndAlpha: UIColor {
        // 1 / 256 = 0.00390625，所以保留8位即可
        
        srand48(Int(arc4random_uniform(255)))   // 必须加这一句，否则 drand48() 每次运行都一样
        
        let red: CGFloat = CGFloat(drand48().gg.doubleRoundOff(places: 8))
        let green: CGFloat = CGFloat(drand48().gg.doubleRoundOff(places: 8))
        let blue: CGFloat = CGFloat(drand48().gg.doubleRoundOff(places: 8))
        let alpha: CGFloat = CGFloat(drand48().gg.doubleRoundOff(places: 8))
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    
    
    
    /// 当前颜色转16进制字符串
    public func colorToHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        base.getRed(&r, green: &g, blue: &b, alpha: &a)
        let argb:Int = (Int)(a*255)<<24 | (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%08x", argb)
    }
    
}




