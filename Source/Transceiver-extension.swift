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
    
    var transceiverReceiveMyTransmits : Bool {return true}
    
    /// transmit data to all `Transceivers`
    ///
    /// You can specify the paths for the transmitted  data otherwise the paths well be `transceiverPaths` property
    ///
    ///     transceiverTransmit("Hello world", to: [.custom(path: "world")])
    ///
    /// - parameter data: Transmitted data
    /// - parameter paths: The paths you want to transmit data to ,  This parameter is optional and the default value is `transceiverPaths` property
    func transceiverTransmit(_ data : Any , to paths : Array<TransceiverPath>? = nil) {
        let paths = paths ?? transceiverPaths
        transceiverManager.transmit(data, to: paths, from: self)
    }
    
    /// Observe transmitted data from all the `Transceivers`
    ///
    /// This function add your observer to a `Set` , so adding more than one observer in the same path will only add one observer.
    ///
    /// This function hold a weak reference to Self , You  don't have to remove the observers on `deinit`
    ///
    ///
    ///
    /// Call this functions to set an observer on the `transceiverPaths`
    ///
    ///     func transceiverObserve()
    ///
    /// Or specify the paths
    ///
    ///     transceiverObserve(paths: [ .custom(path: "language") ])
    ///
    /// - important : You should call this function on every `Transceiver` at some point otherwise `transceiverDidReceive` function will not be called
    ///
    /// - parameter paths : The paths you want to observe , This parameter is optional and the default value is `transceiverPaths` property
    func transceiverObserve(paths : Array<TransceiverPath>? = nil) {
        let paths = paths ?? transceiverPaths
        transceiverManager.subscribe(self, to : paths) { [weak self] (data , path , sender)  in
            guard let self = self else {return}
            
            let receive = self.transceiverReceiveMyTransmits
            let equals = sender.value?.isEqual(self) ?? false
            
            guard !(!receive && equals)  else {return}
            
            self.transceiverDidReceive(data, from: path)
        }
    }
    
    
    /// Remove observers from the specified `TransceiverPaths`
    ///
    /// Remove observer from the specified `TransceiverPaths` from this  `Transceiver`
    ///
    /// - important : You don't have to remove  observed paths ,  The `transceiverManager` will do it when Self is deallocated from memory
    /// - parameter paths : The paths you want to remove the observer from
    func transceiverRemoveObservers(from paths : Array<TransceiverPath>) {
        transceiverManager.removeObservers(from: paths, subscriber: self)
    }
    
    /// Remove all observers from this `Transceiver`
    ///
    /// - important : You don't have to remove  observed paths ,  The `transceiverManager` will do it when Self is deallocated from memory
    func transceiverRemoveAllObservers() {
        transceiverManager.removeAllObservers(subscriber: self)
    }
}
