//  Created by Виктор Заикин on 22.05.16.
//  Copyright © 2016 Виктор Заикин. All rights reserved.

import UIKit

public enum ShadowPath {
    case bottom
    case top
    case left
    case right
}

public struct ViewCorners {
    var view: UIView

    var topLeft: CGPoint {
        return CGPoint(x: 0.0, y: 0.0)
    }
    var topRight: CGPoint {
        return CGPoint(x: view.frame.size.width, y: 0.0)
    }
    var bottomLeft: CGPoint {
        return CGPoint(x: 0.0, y: view.frame.size.height)
    }
    var bottomRight: CGPoint {
        return CGPoint(x: view.frame.size.width, y: view.frame.size.height)
    }
}

public extension UIView {
    var corners: ViewCorners {
        return ViewCorners(view: self)
    }

    /** Seting shadow for specified view

     - parameter color        : shadow color (default is UIColor(white: 0.0, alpha: 0.3))
     - parameter opacity      : shadow opacity (default is 0.3)
     - parameter shadowOffset : shadow offset (default is (0.0, 0.0))
     - parameter radius       : shadow radius (default is 5.0)

     */
    func addShadow(color shadowColor: UIColor = UIColor(white: 0.0, alpha: 0.3),
                   opacity _opacity: Float = 0.3,
                   radius _radius: CGFloat = 5.0,
                   shadowOffset _shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)) {
        self.layer.masksToBounds = false

        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = _opacity
        self.layer.shadowOffset = _shadowOffset
        self.layer.shadowRadius = _radius
    }

    /** Seting shadow for specified view with custom bezier path

     - parameter color        : shadow color (default is UIColor(white: 0.0, alpha: 0.3))
     - parameter opacity      : shadow opacity (default is 0.3)
     - parameter shadowOffset : shadow offset (default is (0.0, 0.0))
     - parameter radius       : shadow radius (default is 5.0)
     - parameter shadowPath   : shadow path

     */
    func addShadow(color shadowColor: UIColor = UIColor(white: 0.0, alpha: 0.3),
                   opacity _opacity: Float = 0.3,
                   radius _radius: CGFloat = 5.0,
                   shadowOffset _shadowOffset: CGSize = CGSize(width: 0.0, height: -2.0),
                   shadowHeight _shadowHeight: CGFloat = 8.0,
                   shadowPath _shadowPath: ShadowPath) {
        var shadowPath: UIBezierPath
        switch _shadowPath {
        case .bottom:
            shadowPath = shadowPathBottom(_shadowHeight)
            break
        case .top:
            shadowPath = shadowPathTop(_shadowHeight)
            break
        case .left:
            shadowPath = shadowPathLeft(_shadowHeight)
            break
        case .right:
            shadowPath = shadowPathRight(_shadowHeight)
            break
        }
        addShadow(color: shadowColor, opacity: _opacity, radius: _radius, shadowOffset: _shadowOffset, shadowPath: shadowPath)
    }

    /** Seting shadow for specified view with custom bezier path

     - parameter color        : shadow color (default is UIColor(white: 0.0, alpha: 0.3))
     - parameter opacity      : shadow opacity (default is 0.3)
     - parameter shadowOffset : shadow offset (default is (0.0, 0.0))
     - parameter radius       : shadow radius (default is 5.0)
     - parameter shadowPath   : shadow path

     */
    func addShadow(color shadowColor: UIColor = UIColor(white: 0.0, alpha: 0.3),
                   opacity _opacity: Float = 0.3,
                   radius _radius: CGFloat = 5.0,
                   shadowOffset _shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0),
                   shadowPath _shadowPath: UIBezierPath) {
        addShadow(color: shadowColor, opacity: _opacity, radius: _radius, shadowOffset: _shadowOffset)
        self.layer.shadowPath = _shadowPath.cgPath
    }

    func removeShadow() {
        self.layer.shadowColor = nil
        self.layer.shadowRadius = 0.0
        self.layer.shadowOpacity = 0.0
    }

    func shadowPathBottom(_ height: CGFloat) -> UIBezierPath {
        let point1 = corners.bottomLeft
        let point2 = corners.bottomRight
        let point3 = CGPoint(x: corners.bottomRight.x,   y: corners.bottomRight.y + height)
        let point4 = CGPoint(x: corners.bottomLeft.x,  y: corners.bottomLeft.y + height)
        let points = [point1, point2, point3, point4]
        return shadowPath(points: points)
    }

    func shadowPathTop(_ height: CGFloat) -> UIBezierPath {
        let point1 = CGPoint(x: corners.topLeft.x,   y: corners.topLeft.y + height)
        let point2 = CGPoint(x: corners.topRight.x,  y: corners.topRight.y + height)
        let point3 = corners.topRight
        let point4 = corners.topLeft
        let points: [CGPoint] = [point1, point2, point3, point4]
        return shadowPath(points: points)
    }

    func shadowPathLeft(_ height: CGFloat) -> UIBezierPath {
        let point1 = CGPoint(x: corners.topLeft.x - height,     y: corners.topLeft.y)
        let point2 = corners.topLeft
        let point3 = corners.bottomLeft
        let point4 = CGPoint(x: corners.bottomLeft.x - height,  y: corners.bottomLeft.y)
        let points: [CGPoint] = [point1, point2, point3, point4]
        return shadowPath(points: points)
    }

    func shadowPathRight(_ height: CGFloat) -> UIBezierPath {
        let point1 = corners.topRight
        let point2 = CGPoint(x: corners.topRight.x + height,  y: corners.topRight.y)
        let point3 = CGPoint(x: corners.bottomRight.x - height,     y: corners.bottomRight.y)
        let point4 = corners.bottomRight
        let points: [CGPoint] = [point1, point2, point3, point4]
        return shadowPath(points: points)
    }

    func shadowPath(paths: [UIBezierPath]) -> UIBezierPath {
        let path = UIBezierPath()
        for _path in paths {
            path.append(_path)
        }
        return path
    }

    func shadowPath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        if points.count > 0 {
            path.move(to: points.first!)
            for i in 1..<points.count {
                path.addLine(to: points[i])
            }
            path.close()
        }
        return path
    }

    /**
     Apply gradient to UIView
     If you applied this method on view, where there is last sublayer of type CAGradientLayer, it will be overwrited

     - Parameter withFrame: This parameter is optional, by default uses bounds of self
     - Parameter alpha: This parameter is optional, maximum alpha of black that will reach on view, by default uses alpha = 0.6
     */
    func addGradient(withFrame frame: CGRect? = nil, alpha: CGFloat = 0.6) {
        let gradientLayer = CAGradientLayer()
        backgroundColor = UIColor.clear
        if let rect = frame {
            gradientLayer.frame = rect
        } else {
            gradientLayer.frame = self.bounds
        }
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        let color0 = UIColor(white: 0, alpha: 0.0).cgColor as CGColor
        let colormiddle = UIColor(white: 0, alpha: alpha/3).cgColor as CGColor
        let color1 = UIColor(white: 0, alpha: alpha).cgColor as CGColor
        gradientLayer.colors = [color0, colormiddle, color1]
        gradientLayer.locations = [0.0,0.5,1.0]
        if layer.sublayers?.last is CAGradientLayer {
            layer.sublayers?.removeLast()
        }
        layer.addSublayer(gradientLayer)
    }
    
}
