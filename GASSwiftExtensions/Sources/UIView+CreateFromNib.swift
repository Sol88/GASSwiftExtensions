//  Created by Виктор Заикин on 02.06.16.
//  Copyright © 2016 Виктор Заикин. All rights reserved.

import UIKit

public extension UIView {
    public class func fromNib(_ nibNameOrNil: String? = nil) -> Self {
        return _fromNib(nibNameOrNil)
    }
    
    public class func _fromNib<T : UIView>(_ nibNameOrNil: String? = nil) -> T {
        let v: T? = _fromNib(nibNameOrNil)
        return v!
    }
    
    public class func _fromNib<T : UIView>(_ nibNameOrNil: String? = nil) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            name = nibName
        }
        let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        for v in nibViews! {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
    }
    
    public class var nibName: String {
        let name = "\(self)".components(separatedBy: ".").first ?? ""
        return name
    }
    public class var nib: UINib? {
        if let _ = Bundle.main.path(forResource: nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }
}
