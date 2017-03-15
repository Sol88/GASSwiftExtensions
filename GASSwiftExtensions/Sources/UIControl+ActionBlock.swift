//  Created by Виктор Заикин on 16.05.16.
//  Copyright © 2016 Виктор Заикин. All rights reserved.

import UIKit

public typealias ControlActionBlock = () -> Void

var AssociatedObjectHandle: UInt8 = 0

class BlockWrapper: NSObject {
    var block: ControlActionBlock?
    
    init(block: ControlActionBlock?) {
        self.block = block
    }
    
    func invokeBlock() {
        if let block = block {
            block()
        }
    }
}

public extension UIControl {
    public func addActionBlock(controlEvents: UIControlEvents, actionBlock:ControlActionBlock?) {
        let wrapper = BlockWrapper(block: actionBlock)
        self.addTarget(wrapper, action: #selector(BlockWrapper.invokeBlock), for: controlEvents)
        
        objc_setAssociatedObject(self, &AssociatedObjectHandle, wrapper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
