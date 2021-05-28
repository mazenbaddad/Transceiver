//
//  TransceiverPath.swift
//  Transceiver
//
//  Created by mazen baddad on 5/28/21.
//

import Foundation

/// `TransceiverPath` with only to cases : `main` and `custom(path: String)`
public enum TransceiverPath : Equatable , Hashable{
    case main
    case custom(path : String)
    
    public var path : String {
        switch self {
        case .custom(path: let path):
            return path
        default :
            return "transceiver.main.path"
        }
    }
}
