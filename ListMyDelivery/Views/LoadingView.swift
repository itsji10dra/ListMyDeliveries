//
//  LoadingView.swift
//  ListMyDelivery
//
//  Created by Jitendra on 17/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    // MARK: - IB Outlets
    
    private var statusLabel: UILabel!
    
    private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Data
    
    private let height: CGFloat = 50
    
    private var heightConstraint: NSLayoutConstraint!

    // MARK: - Initializer
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadSubViews()
        loadConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SubViews
    
    private func loadSubViews() {

        statusLabel = UILabel()
        activityIndicator = UIActivityIndicatorView()
        
        let stackView = UIStackView(arrangedSubviews: [statusLabel, activityIndicator])
        stackView.axis = .horizontal
        stackView.spacing = 5
        addSubview(stackView)
        stackView.alignCenterWithSuperView()
    }
    
    private func loadConstraint() {
        
        heightConstraint = align(width: 0, height: height)[.height]
    }
    
    // MARK: - Public Methods
    
    public func showMessage(_ message: String,
                            animateLoader: Bool,
                            autoHide after: TimeInterval? = nil) {
        
        heightConstraint.isActive = true
        
        statusLabel.text = message
        animateLoader ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        
        if let timeInterval = after {
            DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) { [weak self] in
                self?.hide()
            }
        }
    }
    
    public func hide() {
        heightConstraint.isActive = false
        statusLabel.text = nil
        activityIndicator.stopAnimating()
    }
}
