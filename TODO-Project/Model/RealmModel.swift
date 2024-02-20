//
//  ToDoTable.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/15/24.
//

import Foundation
import RealmSwift

class TaskGroup : Object {
    @Persisted(primaryKey: true) var _id : ObjectId
    @Persisted var groupName : String
    @Persisted var regDate : Date
    @Persisted var type : String? //TODO: - 목록 유형은 추후에...
    
    @Persisted var icon : Icon? // embedded
    @Persisted var todo : List<ToDoTable>
    
    convenience init(groupName: String, icon : Icon?) {
        self.init()
        
        self.groupName = groupName
        self.regDate = Date()
        self.icon = icon
    }
}

class Icon : EmbeddedObject {
    @Persisted var colorHex : String // hex code로 저장
    @Persisted var systemIcon : String // system image 이름
}



class ToDoTable : Object {
    @Persisted(primaryKey: true) var _id : ObjectId
    @Persisted var title : String // 제목
    @Persisted var memo : String? // 메모(옵션)
    @Persisted var endDate : Date?
    @Persisted var tag : String?
    @Persisted var priority : String?
    @Persisted var regDate : Date
    @Persisted var flag : Bool
    @Persisted var completed : Bool
    
    @Persisted(originProperty: "todo") var taskGroup : LinkingObjects<TaskGroup>
    
    convenience init(title: String, memo: String? = nil, endDate: Date?,
                     tag: String?, priority: String?, flag : Bool, completed : Bool) {
        self.init()
        
        self.title = title
        self.memo = memo
        self.endDate = endDate
        self.tag = tag
        self.priority = priority
        self.regDate = Date()
        self.flag = flag
        self.completed = completed
    }

    var endDateFiltered : String? {
        get {
            return endDate?.toString(dateFormat: "yy/MM/dd")
        }
    }
}
