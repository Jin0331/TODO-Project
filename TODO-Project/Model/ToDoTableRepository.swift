//
//  ToDoTableRepository.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/18/24.
//

import UIKit
import RealmSwift

final class ToDoTableRepository {
    
    private let realm = try! Realm()
    
    enum sortedKey : String, CaseIterable {
        case title
        case endDate
        case priority
        
        var title : String {
            switch self {
            case .title:
                return "제목"
            case .endDate:
                return "마감일"
            case .priority:
                return "우선순위"
            }
        }
        
        var sortedImage : String {
            switch self {
            default :
                return "arrow.clockwise.square"
            }
        }
    }
    
    func realmLocation() {
        print(realm.configuration.fileURL!)
    }
    
    func createItem(_ item : ToDoTable) {
        
        do {
            try realm.write {
                realm.add(item)
                print("Realm Create")
            }
        } catch {
            print(error)
        }
        
    }
    
    func fetch() -> Results<ToDoTable> {
        
        return realm.objects(ToDoTable.self)
        
    }
    
    func fetchComplete() -> Results<ToDoTable> {
        
        return realm.objects(ToDoTable.self).where {
            $0.completed == true
        }
        
    }
    
    
    func fetchSort(_ sortKey : String) -> Results<ToDoTable> {
        
        return realm.objects(ToDoTable.self).sorted(byKeyPath: sortKey, ascending: true)
    }
    
//    func fetchNowDate() -> Results<ToDoTable> {
//        
//        return realm.objects(ToDoTable.self).where{
//            $0.endDate == Date().formatted("yy.MM.dd")
//        }
//    }
    
    
    //3. 한 레코드에서 여러 컬럼 정보를 변경하고 싶을 떄
    func updateItem(id : ObjectId, money : Int, category : String) {
        do {
            try realm.write {
                realm.create(ToDoTable.self,
                             value: ["id": id, "money":money, "category":category],
                             update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    
//    //1. 한 레코드에 특정 컬럼값을 수정하고 싶은 경우
//    func updateFavoite(_ item : ToDoTable) {
//        
//        do {
//            try realm.write {
//                item.favorite.toggle()
//            }
//        } catch {
//            print(error)
//        }
//    }
}


