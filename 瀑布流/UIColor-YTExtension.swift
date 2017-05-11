//
//  UIColor-Extension.swift
//  Swift-test
//
//  Created by Bill on 2017/5/5.
//  Copyright © 2017年 Bill. All rights reserved.
//

import UIKit

extension UIColor {
//    10进制颜色
    convenience init(r:CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a);
    }
//    16进制颜色
    convenience init?(hex : String, alpha : CGFloat = 1.0) {
        guard hex.characters.count >= 6 else {
            return nil
        }
        var tempHex = hex.uppercased()
        if tempHex.hasPrefix("0X") || tempHex.hasPrefix("##") {
            tempHex = (tempHex as NSString).substring(from: 2)
        }
        if tempHex.hasPrefix("#") {
            tempHex = (tempHex as NSString).substring(from: 1)
        }
        var r : UInt32 = 0, g : UInt32 = 0, b : UInt32 = 0
        
        var range = NSMakeRange(0, 2)
        let rHex = (tempHex as NSString).substring(with: range)
        range.location = 2
        let gHex = (tempHex as NSString).substring(with: range)
        range.location = 4
        let bHex = (tempHex as NSString).substring(with: range)
        
        Scanner(string: rHex).scanHexInt32( &r )
        Scanner(string: gHex).scanHexInt32( &g )
        Scanner(string: bHex).scanHexInt32( &b )
        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b), a: alpha)
        
     }
    
    /* 随机颜色 */
    class func randomRGB() -> UIColor {
        return UIColor.init(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)), a: 1.0)
    }
    
}
