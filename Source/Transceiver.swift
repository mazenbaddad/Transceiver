//
//  Transceiver.swift
//  Transceiver
//
//  Created by mazen baddad on 5/28/21.
//

import Foundation

/// A type that can both transmit and receive communications .
public protocol Transceiver {
    
    /// Shared manager for all `Transceivers`
    var transceiverManager: TransceiverManager {get}
    
    /// The paths for transmit and receive data.
    ///
    /// `TransceiverPaths` is the paths that the `Transceiver` will transmit and receive data from `Default value` is .main.
    ///
    /// You can Implement the `transceiverPaths` and change it to the paths you desire .
    ///
    ///     var transceiverPaths: Array<TransceiverPath> = [.main , .custom(path: "language")]
    ///
    var transceiverPaths : Array<TransceiverPath> {get}
    
    
    /// Whether the `Transceiver` Receive his own transmits or not.
    ///
    /// You can Implement `transceiverReceiveMyTransmits` and change it to the flag you desire .
    ///
    /// Default value is True.
    ///
    ///     var observeMyTransmits : Bool = true
    var transceiverReceiveMyTransmits : Bool {get}

    /// Called when data transmitted on the same paths the `Transceiver` observed.
    ///
    /// In case the `Transceiver` observe more than one path  , You have to handle paths cases.
    ///
    ///     func transceiverDidReceive(_ data: Any, from transceiverPath: TransceiverPath) {
    ///            switch transceiverPath {
    ///         case .main:
    ///                print(data)
    ///        case .custom(path: "language") :
    ///            guard let language = data as? Language else {return}
    ///            // update ui
    ///        default:
    ///            break
    ///        }
    ///      }
    ///
    /// - parameter data: Received data
    /// - parameter transceiverPath: Data path (Where the data come from)
    func transceiverDidReceive(_ data : Any , from transceiverPath : TransceiverPath)
}
