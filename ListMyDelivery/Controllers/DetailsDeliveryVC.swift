//
//  DetailsDeliveryVC.swift
//  ListMyDelivery
//
//  Created by Jitendra on 15/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit
import MapKit

class DetailsDeliveryVC: UIViewController {

    // MARK: - UI

    private var mapView: MKMapView!
    
    private var deliveryView: DeliveryView!
    
    private var messageLabel: UILabel!
    
    // MARK: - UI Data

    private let padding: CGFloat = 8

    private lazy var portraintConstraints: [NSLayoutConstraint] = []

    private lazy var landscapeConstraints: [NSLayoutConstraint] = []
    
    // MARK: - Data
    
    internal var detailsInfo: DetailsViewModel!
    
    // MARK: - View Hierarchy
    
    override func loadView() {
        super.loadView()
        
        title = "Delivery Details"
        view.backgroundColor = UIColor.white
            
        loadMapView()
        loadDeliveryView()
        loadMessageLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMapData()
        loadDeliveryData()
        loadMessage()
    }
    
    // MARK: - Prepare UI
    
    private func loadMapView() {
        mapView = MKMapView()
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        let portraitConstraint = [mapView.topAnchor.constraint(equalTo: view.topAnchor),
                                  mapView.widthAnchor.constraint(equalTo: view.widthAnchor),
                                  mapView.heightAnchor.constraint(equalTo: mapView.widthAnchor),
                                  mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor)]
        portraintConstraints.append(contentsOf: portraitConstraint)
        
        let landscapeConstraint = [mapView.topAnchor.constraint(equalTo: view.topAnchor),
                                   mapView.widthAnchor.constraint(equalTo: view.heightAnchor),
                                   mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                   mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)]
        landscapeConstraints.append(contentsOf: landscapeConstraint)
    }
    
    private func loadDeliveryView() {
        deliveryView = DeliveryView()
        view.addSubview(deliveryView)
        deliveryView.layer.borderColor = UIColor.darkGray.cgColor
        deliveryView.layer.borderWidth = 1
        deliveryView.layer.masksToBounds = true
        deliveryView.translatesAutoresizingMaskIntoConstraints = false
        
        let portraitConstraint = [deliveryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                  deliveryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                  deliveryView.topAnchor.constraint(equalTo: mapView.bottomAnchor)]
        portraintConstraints.append(contentsOf: portraitConstraint)
        
        let landscapeConstraint = [deliveryView.leadingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: padding),
                                   deliveryView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                                   deliveryView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)]
        landscapeConstraints.append(contentsOf: landscapeConstraint)
    }
    
    private func loadMessageLabel() {
        messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        view.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let portraitConstraint = [messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                                  messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
                                  messageLabel.topAnchor.constraint(equalTo: deliveryView.bottomAnchor, constant: padding)]
        portraintConstraints.append(contentsOf: portraitConstraint)
        
        let landscapeConstraint = [messageLabel.leadingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: padding),
                                   messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                   messageLabel.topAnchor.constraint(equalTo: deliveryView.bottomAnchor, constant: padding)]
        landscapeConstraints.append(contentsOf: landscapeConstraint)
    }
    
    // MARK: - Data Loading
    
    private func loadMapData() {
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: detailsInfo.coordinates, span: span)
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = detailsInfo.coordinates
        annotation.title = detailsInfo.address
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
        mapView.setCenter(detailsInfo.coordinates, animated: true)
    }

    private func loadDeliveryData() {
        deliveryView.descriptionLabel.text = detailsInfo.description
        deliveryView.thumbImageView.setImage(with: detailsInfo.imageUrl)
    }
    
    private func loadMessage() {
        let isOnline = ReachabilityManager.shared.isReachable
        messageLabel.isHidden = isOnline
        messageLabel.text = "Note: Map might not load in offline mode."
    }
    
    // MARK: - ViewController
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        let isPortrait = traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular
        
        if isPortrait {
            NSLayoutConstraint.deactivate(landscapeConstraints)
            NSLayoutConstraint.activate(portraintConstraints)
        } else {
            NSLayoutConstraint.deactivate(portraintConstraints)
            NSLayoutConstraint.activate(landscapeConstraints)
        }
    }
}
