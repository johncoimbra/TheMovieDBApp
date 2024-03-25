//
//  UIView+AutoLayout.swift
//  joinin
//
//  Created by John on 22/08/23.
//  Copyright © 2023 Joinin Tecnologia. All rights reserved.
//

import UIKit

extension UIView {
    convenience init(translateMask: Bool) {
            self.init()
            self.translatesAutoresizingMaskIntoConstraints = translateMask
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                left: NSLayoutXAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                paddingLeft: CGFloat = 0,
                bottom: NSLayoutYAxisAnchor? = nil,
                paddingBottom: CGFloat = 0,
                right: NSLayoutXAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -paddingRight).isActive = true
        }
    }
    
    func setHeight(height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superviewTopAnchor = superview?.topAnchor,
              let superviewBottomAnchor = superview?.bottomAnchor,
              let superviewLeadingAnchor = superview?.leftAnchor,
              let superviewTrailingAnchor = superview?.rightAnchor else { return }
        
        anchor(top: superviewTopAnchor, left: superviewLeadingAnchor,
               bottom: superviewBottomAnchor, right: superviewTrailingAnchor)
    }
    
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
        
        if let leftAnchor = leftAnchor, let padding = paddingLeft {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        }
    }
    
    func setHeightMultiplier(equalTo anchor: NSLayoutDimension, multiplier m: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: anchor, multiplier: m).isActive = true
    }
    
    func setDimension(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func addBottomLine(color: UIColor, height: CGFloat) {
        let bottomView = UIView(frame: CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: height))
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.autoresizingMask = .flexibleWidth
        bottomView.backgroundColor = color
        self.addSubview(bottomView)
    }
    
    func removeBottomLine(color: UIColor, height: CGFloat) {
        let bottomView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: height))
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.autoresizingMask = .flexibleWidth
        bottomView.backgroundColor = color
        self.addSubview(bottomView)
    }
    
    func roundCorners(_ corners: UIRectCorner, _ radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func removeAllConstraints() {
        var superv = self.superview
        
        while let superview = superv {
            for constraint in superview.constraints {
                
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }
                
                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }
            
            superv = superview.superview
        }
        
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }
    
}

public extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                leading: NSLayoutXAxisAnchor? = nil,
                paddingLeft: CGFloat = 0,
                bottom: NSLayoutYAxisAnchor? = nil,
                paddingBottom: CGFloat = 0,
                trailing: NSLayoutXAxisAnchor? = nil,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -paddingRight).isActive = true
        }
    }
}


public extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: 0).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -0).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: 0).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -0).isActive = true
        }
    }
}

public extension UIView {
    func fadeTo(_ alpha: CGFloat, duration: TimeInterval = 0.3) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration) {
                self.alpha = alpha
            }
        }
    }
    
    func fadeIn(_ duration: TimeInterval = 0.3) {
        fadeTo(1.0, duration: duration)
    }
    
    func fadeOut(_ duration: TimeInterval = 0.3) {
        fadeTo(0.0, duration: duration)
    }
}

// MARK: Rotate And CornerRadius
public extension UIView {
    func setCorners(corners: UIRectCorner, radius: CGFloat) {
        layoutIfNeeded()
        let rect = self.bounds
        
        let layer = CAShapeLayer()
        let roundPath = UIBezierPath(roundedRect: rect,
                                     byRoundingCorners: corners,
                                     cornerRadii: CGSize(width: radius, height: radius)).cgPath
        layer.path = roundPath
        self.layer.mask = layer
    }
    
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }
}

// MARK: Shadow
public extension UIView {
    @discardableResult
    func addBorders(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0,
                    cornerRadius: CGFloat = 8.0,
                    roundCorner: Bool = false) -> [UIView] {
        
        var borders = [UIView]()
        
        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            if roundCorner {
                border.layer.cornerRadius = cornerRadius
            }
            border.backgroundColor = color
            
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border]) })
            borders.append(border)
            return border
        }
        
        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }
        
        return borders
    }
}

public extension UIView {
    func anchor(centerX:(anchor: NSLayoutXAxisAnchor, padding: CGFloat)? = nil,
                centerY: (anchor: NSLayoutYAxisAnchor, padding: CGFloat)? = nil,
                top: (anchor: NSLayoutYAxisAnchor, padding: CGFloat)? = nil,
                left: (anchor: NSLayoutXAxisAnchor, padding: CGFloat)? = nil,
                right: (anchor: NSLayoutXAxisAnchor, padding: CGFloat)? = nil,
                bottom: (anchor: NSLayoutYAxisAnchor, padding: CGFloat)? = nil,
                width: CGFloat? = nil, height: CGFloat? = nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX.anchor, constant: centerX.padding).isActive = true
        }
        
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY.anchor, constant: centerY.padding).isActive = true
        }
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top.anchor, constant: top.padding).isActive = true
        }
        
        if let left = left {
            self.leadingAnchor.constraint(equalTo: left.anchor, constant: left.padding).isActive = true
        }
        
        if let right = right {
            self.trailingAnchor.constraint(equalTo: right.anchor, constant: -right.padding).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom.anchor, constant: -bottom.padding).isActive = true
        }
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

public extension UIView {
    
    func hideAnimated(_ view: UIView, _ duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut], animations: {
            if view.isHidden == true {
                return
            } else {
                view.isHidden = true
            }
        })
    }
    
    func showAnimated(_ view: UIView, _ duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut], animations: {
            if view.isHidden == true {
                view.isHidden = false
            } else {
                return
            }
        })
    }
}

public extension UIView {
    func addTopShadow(shadowColor: UIColor, shadowOpacity: Float, shadowRadius: CGFloat, offset: CGSize, _ view: UIView) {
        self.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.clipsToBounds = false
        self.layer.shouldRasterize = false
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func addBottomShadow(_ view: UIView) {
        self.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 3.0
        self.layer.shadowColor = UIColor.systemGray3.cgColor
        self.layer.shouldRasterize = false
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = false
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func addShadow() {
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.black.cgColor
    }
    
    func removeShadow() {
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.clear.cgColor
    }
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { (subview) in
            self.addSubview(subview)
        }
    }
}

extension UIView {
  func addViews(_ subviews: UIView...) {
    subviews.forEach { (subview) in
      self.addSubview(subview)
    }
  }
}
