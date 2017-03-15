//  Created by Виктор Заикин on 31.03.16.
//  Copyright © 2016 Виктор Заикин. All rights reserved.

import UIKit

public extension String {
    public func height(font: UIFont, boundingWidth: CGFloat) -> CGFloat {
        let string = self as NSString
        guard string.length > 0 else { return 0.0 }
        let frame = string.boundingRect(with: CGSize(width: boundingWidth, height: CGFloat.greatestFiniteMagnitude),
                                                options: .usesLineFragmentOrigin,
                                                attributes: [NSFontAttributeName : font],
                                                context: nil)
        return ceil(frame.height)
    }
    
    public func width(font: UIFont, boundingHeight: CGFloat) -> CGFloat {
        let string = self as NSString
        guard string.length > 0 else { return 0.0 }
        let frame = string.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: boundingHeight),
                                                options: .usesLineFragmentOrigin,
                                                attributes: [NSFontAttributeName : font],
                                                context: nil)
        return ceil(frame.width)
    }
    
    public func maxFontSize(_ font: UIFont, boundingWidth: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let textHeight = self.height(font: font, boundingWidth: boundingWidth)
        if textHeight < maxHeight {
            return floor(textHeight)
        } else {
            let newFont = font.withSize(font.pointSize - 1)
            return self.maxFontSize(newFont, boundingWidth: boundingWidth, maxHeight: maxHeight)
        }
    }
}

public extension NSAttributedString {
    public func height(boundingWidth: CGFloat) -> CGFloat {
        guard self.length > 0 else { return 0.0 }
        let frame = boundingRect(with: CGSize(width: boundingWidth, height: CGFloat.greatestFiniteMagnitude),
                                 options: [.usesLineFragmentOrigin, .usesFontLeading],
                                 context: nil)
        return ceil(frame.height)
    }
    
    public func width(boundingHeight: CGFloat) -> CGFloat {
        guard self.length > 0 else { return 0.0 }
        let frame = boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: boundingHeight),
                                 options: [.usesLineFragmentOrigin, .usesFontLeading],
                                 context: nil)
        return ceil(frame.width)
    }
}
