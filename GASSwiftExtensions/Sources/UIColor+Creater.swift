//  Created by Виктор Заикин on 05.07.16.
//  Copyright © 2016 Виктор Заикин. All rights reserved.

import UIKit

public extension UIColor {
    // Values not devided by 255
    public class func colorFrom(red: Float, green: Float, blue: Float) -> UIColor {
        return UIColor(colorLiteralRed: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
    
    public class func colorFrom(hex: String) -> UIColor {
        var rgbValue : UInt32 = 0
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        scanner.scanHexInt32(&rgbValue)
      
        return UIColor.colorFrom(red: Float((rgbValue & UInt32(0xFF0000)) >> 16),
                                 green: Float((rgbValue & UInt32(0xFF00)) >> 8),
                                 blue: Float(rgbValue & UInt32(0xFF)))
    }
}
