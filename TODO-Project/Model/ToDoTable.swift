//
//  ToDoTable.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/15/24.
//

import Foundation
import RealmSwift

class ToDoTable : Object {
    @Persisted(primaryKey: true) var _id : ObjectId
    @Persisted var title : String // 제목
    @Persisted var memo : String? // 메모(옵션)
    @Persisted var endDate : Date
    @Persisted var tag : String
    @Persisted var priority : String
    
    convenience init(title: String, memo: String? = nil, endDate: Date, tag: String, priority: String) {
        self.init()
        
        self.title = title
        self.memo = memo
        self.endDate = endDate
        self.tag = tag
        self.priority = priority
    }
}
