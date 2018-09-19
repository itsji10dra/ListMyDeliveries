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

    private let deliveryViewHeight: CGFloat = 80
    
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
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: mapView.widthAnchor).isActive = true
    }
    
    private func loadDeliveryView() {
        deliveryView = DeliveryView()
        view.addSubview(deliveryView)
        deliveryView.layer.borderColor = UIColor.darkGray.cgColor
        deliveryView.layer.borderWidth = 1
        deliveryView.layer.masksToBounds = true
        deliveryView.translatesAutoresizingMaskIntoConstraints = false
        deliveryView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        deliveryView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        deliveryView.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        deliveryView.heightAnchor.constraint(equalToConstant: deliveryViewHeight).isActive = true
    }
    
    private func loadMessageLabel() {
        let padding: CGFloat = 8
        messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        view.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        messageLabel.topAnchor.constraint(equalTo: deliveryView.bottomAnchor, constant: padding).isActive = true
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
}
