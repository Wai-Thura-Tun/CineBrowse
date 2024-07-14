//
//  NetworkMonitor.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/13/24.
//

import Foundation
import Network

protocol NetworkMonitorDelegate: AnyObject {
    func onChangeConnection()
}

class NetworkMonitor {
    static let shared: NetworkMonitor = .init()
    
    private let monitor: NWPathMonitor
    private let queue: DispatchQueue
    
    weak var delegate: NetworkMonitorDelegate?
    
    private(set) var isConnected: Bool = true {
        didSet {
            self.delegate?.onChangeConnection()
        }
    }
    
    private init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global()
        
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}
