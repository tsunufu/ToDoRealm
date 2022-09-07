//
//  Post.swift
//  ToDoRealm
//
//  Created by ryo on 2022/09/07.
//

import Foundation
import RealmSwift

class Post: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var date: String = ""
    
}
