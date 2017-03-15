//  Created by Виктор Заикин on 13.07.16.
//  Copyright © 2016 Виктор Заикин. All rights reserved.

import UIKit

// MARK:- Navigation stack
public extension UINavigationController {
    public func previousViewController() -> UIViewController? {
        return viewController(at: viewControllers.count - 2)
    }
    
    public func viewController(at index: Int) -> UIViewController? {
        guard index >= 0 else { return nil }
        return viewControllers[index]
    }
    
    public func removeViewController(at index: Int) {
        var _viewControllers = viewControllers
        _viewControllers.remove(at: index)
        viewControllers = _viewControllers
    }
    
    public func removeViewController(atTail index: Int) {
        var _viewControllers = viewControllers
        _viewControllers.remove(at: _viewControllers.count - index - 1)
        viewControllers = _viewControllers
    }
    
    public func removeViewControllers(previous number: Int) {
        var _viewControllers = viewControllers
        if number < _viewControllers.count {
            _viewControllers.removeSubrange(_viewControllers.count - number - 1..._viewControllers.count - 2)
            viewControllers = _viewControllers
        }
    }
    
    public func removePreviousViewController() {
        removeViewController(atTail: 1)
    }
}

// MARK:- UINavigation appearance
public extension UINavigationController {
    public func setNavigationBar(color: UIColor, duration: TimeInterval = 0.0) {
        if duration == 0.0 {
            self.navigationBar.barTintColor = color
        } else {
            UIView.animate(withDuration: duration, animations: {
                self.navigationBar.barTintColor = color
            })
        }
    }
    
    public func setNavigationBar(titleColor color: UIColor, duration: TimeInterval = 0.0) {
        if duration == 0.0 {
            self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : color]
        } else {
            UIView.animate(withDuration: duration, animations: {
                self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : color]
            })
        }
    }
}
