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
    
    // MARK: - UI

    var thumbImageView: UIImageView!
    
    var descriptionLabel: UILabel!

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
        thumbImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        thumbImageView.widthAnchor.constraint(equalTo: thumbImageView.heightAnchor, multiplier: 1).isActive = true
        thumbImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        thumbImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func loadDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: padding).isActive = true
        descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -padding).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -padding).isActive = true
    }
}
