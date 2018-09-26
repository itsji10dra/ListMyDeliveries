//
//  ReachabilityManager.swift
//  ListMyDelivery
//
//  Created by Jitendra on 17/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Reachability

class ReachabilityManager {

    static let shared: ReachabilityManager = { return ReachabilityManager() } ()

    // MARK: - Public

    public var isReachable: Bool {
        return reachability?.connection != Reachability.Connection.none
    }

    // MARK: - Private

    private var reachability = Reachability()

    // MARK: - Initializer

    private init() {
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to Start Notifier")
        }
    }
    
    // MARK: - De-Initializer

    deinit {
        reachability?.stopNotifier()
    }
}
