//
//  DeliveryCell.swift
//  ListMyDelivery
//
//  Created by Jitendra on 15/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

class DeliveryCell: UITableViewCell {

    // MARK: - UI Data

    private let padding: CGFloat = 8
    
    // MARK: - UI

    var deliveryView: DeliveryView!

    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        loadDeliveryView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overriding Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        deliveryView.thumbImageView.image = nil
        deliveryView.descriptionLabel.text = nil
    }
    
    // MARK: - Prepare UI

    private func loadDeliveryView() {
        deliveryView = DeliveryView()
        contentView.addSubview(deliveryView)
        deliveryView.alignWithSuperView()
    }
}
