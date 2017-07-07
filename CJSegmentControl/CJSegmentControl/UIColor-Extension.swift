//
//  UIColor-Extension.swift
//  CJLive
//
//  Created by CoderJon on 2017/7/3.
//  Copyright © 2017年 CoderJon. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
    
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        guard hex.characters.count >= 6 else {
            return nil
        }
        
        var temHex = hex.uppercased()
        
        if temHex.hasPrefix("0x") || temHex.hasPrefix("##") || temHex.hasPrefix("0X"){
            temHex = (temHex as NSString).substring(from: 2)
        }
        
        if temHex.hasPrefix("#") {
            temHex = (temHex as NSString).substring(from: 1)
        }
        
        var range = NSRange(location: 0, length: 2)
        let rHex = (temHex as NSString).substring(with: range)
        range.location = 2
        let gHex = (temHex as NSString).substring(with: range)
        range.location = 4
        let bHex = (temHex as NSString).substring(with: range)
        
        var r: UInt32 = 0, g: UInt32 = 0, b: UInt32 = 0
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        
        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    class func getRGBDelta(_ firstColor: UIColor, _ secondColor: UIColor) -> (rDelta: CGFloat, gDelta: CGFloat, bDelta: CGFloat){
        let firstRGB = firstColor.getRGB()
        let secondRGB = secondColor.getRGB()
        
        return (firstRGB.0 - secondRGB.0, firstRGB.1 - secondRGB.1, firstRGB.2 - secondRGB.2)
    }
    
    func getRGB() -> (CGFloat, CGFloat, CGFloat) {
        guard let cmps = cgColor.components else {
            fatalError("Ensure that the color is RGB")
        }
        
        return (cmps[0] * 255, cmps[1] * 255, cmps[2] * 255)
    }
}
