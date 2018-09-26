//
//  ListDeliveryVC+TableViewDelegates.swift
//  ListMyDelivery
//
//  Created by Jitendra on 15/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

extension ListDeliveryVC: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.height
        
        if bottomEdge >= scrollView.contentSize.height {    //We reached bottom
            loadDeliveries()
        }
    }
}

extension ListDeliveryVC: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: DeliveryCell
        
        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? DeliveryCell {
            cell = reusableCell
        } else {
            cell = DeliveryCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        let info = deliveryInfoArray[indexPath.row]
        
        cell.deliveryView.descriptionLabel.text = info.description
        cell.deliveryView.thumbImageView.setImage(with: info.imageUrl, useDiskCache: isOffline)
        
        return cell
    }
}

extension ListDeliveryVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushDetailsSceneForModel(at: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
