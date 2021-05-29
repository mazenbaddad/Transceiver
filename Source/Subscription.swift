//
//  Subscription.swift
//  Transceiver
//
//  Created by mazen baddad on 5/29/21.
//

import Foundation


internal struct Subscription : Hashable{
    
    weak var subscriber : AnyObject?
    var path : TransceiverPath
    var handler : (Any, TransceiverPath , Weak<AnyObject>) -> Void
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(path)
    }
    
    static func == (lhs: Subscription, rhs: Subscription) -> Bool {
        return lhs.path == rhs.path && ( lhs.subscriber?.isEqual(rhs.subscriber) ?? false)
    }
}
