//
//  FileManager+Extension.swift
//  ListMyDelivery
//
//  Created by Jitendra on 18/09/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation

extension FileManager {
    
    public func libraryPath() -> URL? {
        return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first
    }
}
