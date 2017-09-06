//
//  InTouchContactListModel.swift
//  InTouchAppDemo
//
//  Created by Rahul Umap on 06/09/17.
//  Copyright © 2017 Rahul Umap. All rights reserved.
//

import Foundation
import RealmSwift

class ListModel: Object {
    dynamic var id = 0
    dynamic var contact_name = ""
    dynamic var contact_number = ""
    dynamic var contact_city = ""
    dynamic var contact_organization = ""
}
