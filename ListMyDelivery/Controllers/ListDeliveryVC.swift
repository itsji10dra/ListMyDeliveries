//
//  ListDeliveryVC.swift
//  ListMyDelivery
//
//  Created by Jitendra on 15/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

class ListDeliveryVC: UIViewController {

    // MARK: - UI
    
    private var deliveryTableView: UITableView!
    
    private var loadingView: LoadingView!
    
    private var refreshControl: UIRefreshControl!
    
    internal let cellIdentifier = "DeliveryCell"
        
    private let loadingViewHeight: CGFloat = 50
    
    // MARK: - Data

    struct DeliveryListInfo {
        
        let description: String
        
        let imageUrl: URL
    }
    
    internal var pagingModel: PagingViewModel<Delivery, DeliveryListInfo>!

    lazy var deliveryInfoArray: [DeliveryListInfo] = []

    internal var isOffline: Bool { //If offline, use disk cached images
        return ReachabilityManager.shared.isReachable == false
    }

    // MARK: - View Hierarchy
    
    override func loadView() {
        super.loadView()
                
        title = "Things to Deliver"
        view.backgroundColor = UIColor.white
        
        loadDeliveryTableView()
        loadRefreshControlView()
        loadLoadingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pagingModel = PagingViewModel<Delivery, DeliveryListInfo>(endPoint: .deliveries,
                                                                  transform: { result -> [DeliveryListInfo] in
            return result.map ({ DeliveryListInfo(description: $0.description, imageUrl: $0.imageUrl) })
        })

        loadDeliveries()
    }
    
    // MARK: - Prepare UI

    private func loadDeliveryTableView() {
        deliveryTableView = UITableView()
        deliveryTableView.dataSource = self
        deliveryTableView.delegate = self
        deliveryTableView.separatorInset.left = 0
        deliveryTableView.rowHeight = UITableView.automaticDimension
        deliveryTableView.estimatedRowHeight = UITableView.automaticDimension
        
        view.addSubview(deliveryTableView)
        deliveryTableView.translatesAutoresizingMaskIntoConstraints = false
        
        deliveryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        deliveryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        deliveryTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

        let bottomConstraint = deliveryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomConstraint.priority = .defaultLow
        bottomConstraint.isActive = true
    }
    
    private func loadRefreshControlView() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        deliveryTableView.addSubview(refreshControl)
    }
    
    private func loadLoadingView() {
        loadingView = LoadingView()
        loadingView.backgroundColor = UIColor.lightGray
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loadingView.topAnchor.constraint(equalTo: deliveryTableView.bottomAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView.hide()
    }
    
    // MARK: - Network

    internal func loadDeliveries() {
        
        let loadingInfo = pagingModel.loadMoreData { [weak self] (data, error, offset) in
            
            ActivityIndicator.stopAnimating()
            
            DispatchQueue.main.async {
                guard let weakSelf = self else { return }
                if let data = data {
                    let oldRecordsCount = weakSelf.deliveryInfoArray.count
                    let newRecordsCount = data.count
                    let newIndexPaths = (oldRecordsCount..<newRecordsCount).map { IndexPath(row: $0, section: 0) }
                    weakSelf.deliveryInfoArray = data
                    weakSelf.deliveryTableView.beginUpdates()
                    weakSelf.deliveryTableView.insertRows(at: newIndexPaths, with: .middle)
                    weakSelf.deliveryTableView.endUpdates()
                    weakSelf.loadingView.hide()
                    if offset == 0 {
                        if weakSelf.isOffline && newRecordsCount == 0 {
                            weakSelf.showErrorAlert(with: "Make sure you have an active internet connection to get the list of deliveries.")
                        }
                    } else if let indexPath = newIndexPaths.first {
                        weakSelf.deliveryTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    }
                } else if let error = error {
                    if offset == 0 {
                        weakSelf.showErrorAlert(with: error.localizedDescription)
                    } else {
                        weakSelf.loadingView.showMessage("Error loading data...", animateLoader: false, autoHide: 5.0)
                    }
                }
            }
        }
        
        if loadingInfo.isLoading {
            if loadingInfo.offset == 0 {
                ActivityIndicator.startAnimating()
            } else {
                loadingView.showMessage("Loading...", animateLoader: true)
            }
        } else {
            loadingView.hide()
        }
    }
    
    @objc
    private func refreshList() {
        refreshControl.endRefreshing()
        guard ReachabilityManager.shared.isReachable else { return }
        pagingModel.clearDataSource()
        loadDeliveries()
    }
    
    // MARK: - Alert
    
    private func showErrorAlert(with message: String) {
        
        let alertController = UIAlertController(title: "Error",
                                                message: message,
                                                preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.loadDeliveries()
        }
        alertController.addAction(retryAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    internal func pushDetailsSceneForModel(at index: Int) {

        guard let info = pagingModel.dataSource(at: index) else { return }
        
        let detailsVC = DetailsDeliveryVC()
        detailsVC.detailsInfo = DetailsViewModel(with: info)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
