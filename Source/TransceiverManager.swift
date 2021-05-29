//
//  TransceiverManager.swift
//  Transceiver
//
//  Created by mazen baddad on 5/28/21.
//

import Foundation

/// An object that manages `Transceivers`
public class TransceiverManager {
    
    internal static let shared : TransceiverManager = .init()
    
    private var subscriptions : Set<Subscription> = []
    
    /// Last data transmitted
    ///
    /// Last data transmitted to all `Transceivers` , This could be nil if there's no data transmitted yet
    /// - important : The value of this property contains the last transmitted data to all the `Transceivers` This is a shared property for all `Transceivers`
    public var lastTransportation : (data : Any , paths : Array<TransceiverPath> , sender : Weak<AnyObject>)? {
        didSet {
            guard let transportation = lastTransportation else {return}
            cleanupSubscription()
            for subscription in subscriptions where transportation.paths.contains(subscription.path){
                subscription.handler(transportation.data , subscription.path, transportation.sender)
            }
        }
    }
    
    private init() {}
    
    
    internal func subscribe(_ object: AnyObject,to paths : Array<TransceiverPath> , handler: @escaping (Any,TransceiverPath,Weak<AnyObject>) -> Void) {
        for path in paths {
            let sub = Subscription(subscriber: object, path: path, handler: handler)
            subscriptions.insert(sub)
        }
        cleanupSubscription()
    }
    
    
    internal func transmit(_ data : Any , to paths : Array<TransceiverPath> , from sender : AnyObject) {
        let sender = Weak(value :sender)
        self.lastTransportation = (data , paths , sender)
    }
    
    internal func removeObservers(from paths : Array<TransceiverPath> , subscriber: AnyObject) {
        cleanupSubscription()
        subscriptions = subscriptions.filter{ !(paths.contains($0.path) && $0.subscriber!.isEqual(subscriber))  }
    }
    
    internal func removeAllObservers(subscriber: AnyObject) {
        cleanupSubscription()
        subscriptions = subscriptions.filter{ !($0.subscriber!.isEqual(subscriber)) }
    }
    
    /// transmit data to all `Transceivers`
    ///
    /// - parameter data: Transmitted data
    /// - parameter paths: The paths you want to transmit data to
    /// - parameter sender: The data sender ( who transmitted this data )
    public static func transmit(_ data : Any, to paths : Array<TransceiverPath> , from sender : AnyObject) {
        shared.transmit(data , to : paths ,from: sender)
    }
    
    /// remove deallocated subscribers from `subscriptions`
    private func cleanupSubscription() {
        subscriptions = subscriptions.filter { $0.subscriber != nil }
    }
    
}
