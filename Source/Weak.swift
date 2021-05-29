//
//  Weak.swift
//  Transceiver
//
//  Created by mazen baddad on 5/29/21.
//

import Foundation

/// Box that hold weak reference to `AnyObject`
public struct Weak<T:AnyObject> {
    weak var value : T?
}
