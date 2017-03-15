//  Created by Виктор Заикин on 20.10.16.
//  Copyright © 2016 Виктор Заикин. All rights reserved.

import UIKit

public extension UIView {
    public var isRasterized: Bool {
        return self.layer.shouldRasterize
    }
    
    public func shouldRasterize(_ should: Bool) {
        if should {
            self.layer.rasterizationScale = UIScreen.main.scale
            self.layer.shouldRasterize = true
        } else {
            self.layer.shouldRasterize = false
        }
    }
    
    public func roundCorners(radius: CGFloat = 0) {
        let size = radius > 0 ? radius : self.frame.size.width
        self.layer.cornerRadius = size / 2
        self.layer.masksToBounds = true
    }
    
    public func skipCornerRadius() {
        self.layer.cornerRadius = 0
        self.layer.masksToBounds = false
    }
}
