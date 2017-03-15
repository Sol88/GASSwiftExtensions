//  Created by Виктор Заикин on 03.04.16.
//  Copyright © 2016 Виктор Заикин. All rights reserved.

import UIKit

public extension UIAlertController {
    public static func showAlert(
        title: String?,
        message: String?,
        tintColor: UIColor? = nil,
        inViewController viewController: UIViewController,
        actionBlock: (() -> Void)?)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertActionOk = UIAlertAction(title: "OK", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
            if let actionBlock = actionBlock {
                actionBlock()
            }
        }
    
        alert.addAction(alertActionOk)
        DispatchQueue.main.async(execute: {
            viewController.present(alert, animated: true, completion: nil)
            if tintColor != nil {
                alert.view.tintColor = tintColor!
            }
        })
    }
    
    public static func showActionSheet(
        title: String?,
        message: String?,
        viewController: UIViewController,
        actions: [UIAlertAction]?,
        cancelTitle: String,
        tintColor: UIColor?)
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UI_USER_INTERFACE_IDIOM() == .pad ? .alert : .actionSheet)
        alert.addActions(actions)
        let alertActionCancel = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        alert.addAction(alertActionCancel)
        DispatchQueue.main.async(execute: {
            viewController.present(alert, animated: true, completion: nil)
            if tintColor != nil {
                alert.view.tintColor = tintColor!
            }
        })
    }
}

// MARK:- Add methods
public extension UIAlertController {
    public func addActions(_ actions: [UIAlertAction]?) {
        actions?.forEach { self.addAction($0) }
    }
}
