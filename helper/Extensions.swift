//
//  UIColorXt.swift
//  search
//
//  Created by Affandy Murad on 13/11/19.
//  Copyright © 2019 Affandy Murad. All rights reserved.
//

import UIKit

extension UIColor {
    static var aqua: UIColor {
        return UIColor(red: 0, green: 150/255, blue: 255/255, alpha: 1)
    }
    
    static var clover: UIColor {
        return UIColor(red: 0, green: 143/255, blue: 0, alpha: 1)
    }
    
    static var maraschino: UIColor {
        return UIColor(red: 255/255, green: 38/255, blue: 0, alpha: 1)
    }
    
    static var tangerine: UIColor {
        return UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1)
    }
    
    static var yellow: UIColor {
        return UIColor(red: 0.98, green: 0.75, blue: 0.18, alpha: 1.0)
    }
}

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
}

extension UITextField {
  func setBottomBorder() {
    self.borderStyle = .none
    self.layer.backgroundColor = UIColor.white.cgColor

    self.layer.masksToBounds = false
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    self.layer.shadowOpacity = 1.0
    self.layer.shadowRadius = 0.0
  }
}
