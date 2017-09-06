//
//  RealmResultExtension.swift
//  InTouchAppDemo
//
//  Created by Rahul Umap on 06/09/17.
//  Copyright © 2017 Rahul Umap. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
