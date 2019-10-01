//
//  WrappedCache.swift
//  Nike
//
//  Created by Varun on 01/10/19.
//  Copyright © 2019 Varun. All rights reserved.
//

import Foundation

class WrappedCache<Key, Value> where Key: AnyObject, Value: AnyObject {
    
    let cache = NSCache<Key, Value>()
    
    subscript(key: Key) -> Value? {
        get {
            return cache.object(forKey: key)
        }
        set {
            if let newValue = newValue {
                cache.setObject(newValue, forKey: key)
            }
            else {
                cache.removeObject(forKey: key)
            }
        }
    }
}
