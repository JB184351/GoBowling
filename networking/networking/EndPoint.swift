//
//  EndPoint.swift
//  networking
//
//  Created by Justin Bengtson on 7/3/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import Foundation
import Network

let connection = NWConnection(host: "example.com", port: .imaps, using: .tls)

connection.stateUpdateHandler = { (newState) in
    switch(newState) {
    case .ready: break
    // Handle connection established
    case .waiting(let error): break
    // Handle connection waiting for network
    case .failed(let error): break
    // Handle fatal connection error
    default:
        break
    }
}
