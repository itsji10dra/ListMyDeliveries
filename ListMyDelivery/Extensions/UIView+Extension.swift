//
//  UIView+Extension.swift
//  ListMyDelivery
//
//  Created by Jitendra on 26/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

public enum ConstraintType {
    case top, bottom, leading, trailing, width, height, centerX, centerY
}

public typealias ConstraintInfo = [ConstraintType: NSLayoutConstraint]

extension UIView {
    
    @discardableResult
    public func contraintsAlign(with view: UIView, padding inset: UIEdgeInsets = .zero, activate: Bool = true) -> ConstraintInfo {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint: ConstraintInfo = [.top: topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top),
                                          .bottom: bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: inset.bottom),
                                          .leading: leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset.left),
                                          .trailing: trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: inset.right)]
        defer { if activate { NSLayoutConstraint.activate(Array(constraint.values)) } }
        return constraint
    }
    
    @discardableResult
    public func contraintsCenterAlign(with view: UIView, activate: Bool = true) -> ConstraintInfo {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint: ConstraintInfo = [.centerX: centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                          .centerY: centerYAnchor.constraint(equalTo: view.centerYAnchor)]
        defer { if activate { NSLayoutConstraint.activate(Array(constraint.values)) } }
        return constraint
    }
    
    @discardableResult
    public func contraintsAlignWithSuperView(with paddingInset: UIEdgeInsets = .zero, activate: Bool = true) -> ConstraintInfo {
        guard let superview = superview else { return [:] }
        return contraintsAlign(with: superview, padding: paddingInset, activate: activate)
    }
    
    @discardableResult
    public func contraintsCenterAlignWithSuperView(activate: Bool = true) -> ConstraintInfo {
        guard let superview = superview else { return [:] }
        return contraintsCenterAlign(with: superview, activate: activate)
    }
    
    @discardableResult
    public func contraints(_ width: CGFloat, height: CGFloat, activate: Bool = true) -> ConstraintInfo {
        let constraint: ConstraintInfo = [.width: widthAnchor.constraint(equalToConstant: width),
                                          .height: heightAnchor.constraint(equalToConstant: height)]
        defer { if activate { NSLayoutConstraint.activate(Array(constraint.values)) } }
        return constraint

    }
}
