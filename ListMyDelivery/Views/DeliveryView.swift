//
//  DeliveryView.swift
//  ListMyDelivery
//
//  Created by Jitendra on 16/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

class DeliveryView: UIView {

    // MARK: - UI Data
    
    private let padding: CGFloat = 8
    
    private let minimumThumbWidth: CGFloat = 80
    
    // MARK: - UI

    internal var thumbImageView: UIImageView!
    
    internal var descriptionLabel: UILabel!

    // MARK: - Initializer

    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SubViews

    private func loadSubViews() {
        loadThumbImageView()
        loadDescriptionLabel()
    }
    
    // MARK: - Prepare UI

    private func loadThumbImageView() {
        thumbImageView = UIImageView()
        addSubview(thumbImageView)
        
        let dimensionConstraints = thumbImageView.align(width: minimumThumbWidth, height: minimumThumbWidth)
        let superViewConstraint = thumbImageView.alignWithSuperView(activate: false)
        let centerConstraint = thumbImageView.alignCenterWithSuperView(activate: false)
        
        let width = dimensionConstraints[.width]
        let height = dimensionConstraints[.height]
        let center = centerConstraint[.centerY]
        let leading = superViewConstraint[.leading]
        let top = superViewConstraint[.top]
        top?.priority = .defaultLow
        let bottom = superViewConstraint[.bottom]
        bottom?.priority = .defaultLow
        
        [center, width, height, leading, top, bottom].forEach { $0?.isActive = true }
    }
    
    private func loadDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        addSubview(descriptionLabel)

        let leading = descriptionLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: padding)
        let inset = UIEdgeInsets(top: padding, left: padding, bottom: -padding, right: -padding)
        let trailing = descriptionLabel.alignLessThanOrEqualToWithSuperView(inset: inset, activate: false)[.trailing]
        let bottom = descriptionLabel.alignLessThanOrEqualToWithSuperView(inset: inset, activate: false)[.bottom]
        let top = descriptionLabel.alignWithSuperView(inset: inset, activate: false)[.top]
        
        [leading, trailing, top, bottom].forEach { $0?.isActive = true }
    }
}
