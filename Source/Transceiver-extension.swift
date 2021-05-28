//
//  Transceiver-extension.swift
//  Transceiver
//
//  Created by mazen baddad on 5/28/21.
//

import Foundation

public extension Transceiver where Self:AnyObject {
    
    var transceiverManager: TransceiverManager { return TransceiverManager.shared}
    
    var transceiverPaths : Array<TransceiverPath> {return [.main]}
    
    var observeMyTransmits : Bool {return true}
}
