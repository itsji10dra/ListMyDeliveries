//
//  ActivityIndicator.swift
//  ListMyDelivery
//
//  Created by Jitendra on 16/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

class ActivityIndicator {
    
    // MARK: Private
    
    private static let restorationIdentifier = "ActivityIndicator"
    
    private static var window: UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    // MARK: Public
    
    public static var defaultMessage = "Loading"
    
    public static var isShowing: Bool {
        return window?.subviews.reversed().contains { $0.restorationIdentifier == restorationIdentifier } == true
    }
    
    // MARK: Public Methods

    public static func startAnimating(message: String? = defaultMessage) {
        
        guard isShowing == false,
            let keyWindow = window else { return }
        
        DispatchQueue.main.async {
            
            let view = UIView()
            view.backgroundColor = UIColor.clear
            view.restorationIdentifier = restorationIdentifier
            
            defer {
                keyWindow.addSubview(view)
                let constraint = view.alignWithSuperView()
                if constraint.isEmpty {
                    view.frame = UIScreen.main.bounds
                } else {
                    NSLayoutConstraint.activate(Array(constraint.values))
                }
            }
            
            let dimView = UIView()
            dimView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            view.addSubview(dimView)
            dimView.translatesAutoresizingMaskIntoConstraints = false
            dimView.alignWithSuperView()
            
            let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
            blurView.layer.masksToBounds = true
            blurView.layer.cornerRadius = 10
            view.addSubview(blurView)
            blurView.alignWidth(150, height: 150)
            blurView.alignCenterWithSuperView()

            let holderStackView = UIStackView()
            holderStackView.axis = .vertical
            holderStackView.distribution = .fill
            holderStackView.alignment = .center
            holderStackView.spacing = 15
            blurView.contentView.addSubview(holderStackView)
            holderStackView.alignCenterWithSuperView()

            let loaderView = UIActivityIndicatorView(style: .whiteLarge)
            loaderView.startAnimating()
            loaderView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            holderStackView.addArrangedSubview(loaderView)
            
            let label = UILabel()
            label.text = message
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 17)
            label.numberOfLines = 0
            label.textAlignment = .center
            holderStackView.addArrangedSubview(label)
        }
    }
    
    public static func stopAnimating() {
        
        DispatchQueue.main.async {
            if let subViews = window?.subviews.reversed(),
                let loaderView = subViews.first(where: { $0.restorationIdentifier == restorationIdentifier }) {
                loaderView.removeFromSuperview()
            }
        }
    }
}
