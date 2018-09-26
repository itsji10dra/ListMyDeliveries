//
//  PagingViewModel.swift
//  ListMyDelivery
//
//  Created by Jitendra on 17/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation

///
/// T: Expected array result from server
/// E: Desired array model object
///

class PagingViewModel<T, E> where T:Decodable, T: Storable {
    
    typealias PagingDataResult = ((_ data: [E]?, _ error: Error?, _ offset: UInt) -> Void)
    
    // MARK: - Private Properties
    
    private lazy var receivedDataSource: [T] = []

    private lazy var dataSource: [E] = []
    
    private var dataTask: URLSessionDataTask?
    
    private lazy var networkManager = NetworkManager()
    
    private var loadedAllData: Bool = false
    
    // MARK: - Public Properties
    
    private let transform: (([T]) -> [E])
    
    private let endPoint: EndPoint
    
    // MARK: - Initializer
    
    init(endPoint: EndPoint, transform block: @escaping (([T]) -> [E])) {
        self.endPoint = endPoint
        self.transform = block
    }
    
    // MARK: - De-Initializer
    
    deinit {
        dataTask?.cancel()
    }
    
    // MARK: - Public Methods
    
    @discardableResult
    public func loadMoreData(handler: @escaping PagingDataResult) -> (isLoading: Bool, offset: UInt) {
        
        let recordsDownloaded = dataSource.count
        
        let offset = UInt(recordsDownloaded == 0 ? 0 : (recordsDownloaded + 1))
        
        guard loadedAllData == false else { return (false, offset) }

        guard ReachabilityManager.shared.isReachable else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in  //Adding delay, so that loading view can be shown.
                self?.loadLocalData(for: offset, completion: handler)
            }
            return (true, offset)
        }
        
        guard dataTask?.state != .running else { return (true, offset) } //Do not load, if last data task is already in progress.
        
        loadData(for: offset, completion: handler)
        
        return (true, offset)
    }
    
    public func dataSource(at index: Int) -> T? {
        
        return index < receivedDataSource.count ? receivedDataSource[index] : nil
    }
    
    public func clearDataSource() {
        
        loadedAllData = false
        receivedDataSource.removeAll()
        dataSource.removeAll()
    }
    
    // MARK: - Private Methods
    
    private func loadData(for offset: UInt = 0, completion: @escaping PagingDataResult) {
        
        print("🍏 Online | Offset:", offset, " ↔️ Endpoint:", endPoint.rawValue)
        
        guard let url = URLManager.getURLForEndpoint(endPoint, offset: offset) else { return }
        
        dataTask = networkManager.dataTaskFromURL(url,
                                                  completion: { [weak self] (result: Result<[T]>) in
                                                    
                switch result {
                case .success(let response):
                    print(" • Success. Records received: ", response.count)
                    
                    guard let data = self?.transform(response) else { return completion([], nil, offset) }
                    
                    self?.receivedDataSource.append(contentsOf: response)

                    self?.dataSource.append(contentsOf: data)
                    
                    completion(self?.dataSource, nil, offset)
                    
                    self?.loadedAllData = data.isEmpty
                    
                    self?.persistData(response)
                    
                case .failure(let error):
                    print(" • Failed. Reason: ", error.localizedDescription)
                    completion(nil, error, offset)
                }
                
                print("--------------------------------------------------------------------------------------")
        })
        
        dataTask?.resume()
    }
    
    private func loadLocalData(for offset: UInt = 0, completion: @escaping PagingDataResult) {

        print("🍎 Offline | Offset:", offset)

        let objects: [T.StorageClass] = RealmManager.shared.get(with: Int(offset))
        
        let response: [T] = objects.map { T.convertFromStorage($0) }
        
        print(" • Success. Records received: ", response.count)
        
        let data = transform(response)
        
        receivedDataSource.append(contentsOf: response)
        
        dataSource.append(contentsOf: data)
        
        completion(dataSource, nil, offset)
        
        self.loadedAllData = (offset != 0) && data.isEmpty
    }
    
    private func persistData(_ data: [T]) {
        
        let realmObjects = data.map { $0.convertToStorage() }
        
        RealmManager.shared.save(data: realmObjects)
    }
}
