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
    
    func fetchAll() -> Results<ToDoTable> {
        
        return realm.objects(ToDoTable.self).where {
            $0.completed == false
        }
        
    }

    func fetchComplete() -> Results<ToDoTable> {
        
        return realm.objects(ToDoTable.self).where {
            $0.completed == true
        }
    }
    
    func fetchFlag() -> Results<ToDoTable> {
        
        return realm.objects(ToDoTable.self).where {
            $0.flag == true && $0.completed == false
        }
    }
    
        
    func fetchToday() -> Results<ToDoTable> {
        
        let start = Calendar.current.startOfDay(for: Date()) // 현재시간
        let end : Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        
        return realm.objects(ToDoTable.self).where {
            $0.completed == false
        }.filter("endDate >= %@ && endDate < %@", start as NSDate, end as NSDate)
    }
    
    func fetchTomorrow() -> Results<ToDoTable> {
        
        let start = Calendar.current.startOfDay(for: Date()) // 현재시간
        let end : Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        
        return realm.objects(ToDoTable.self).where {
            $0.completed == false
        }.filter("endDate >= %@", end as NSDate)
    }
    
    
    func fetchSort(dataList: Results<ToDoTable>, sortKey : String) -> Results<ToDoTable> {
        
        return dataList.sorted(byKeyPath: sortKey, ascending: true)
    }
    
    
    //TODO: - flag랑 complete 나중에
    func updateItem(id : ObjectId, title : String, memo : String?, endDate : Date?, tag : String?, priority : String?) {
        do {
            try realm.write {
                realm.create(ToDoTable.self,
                             value: ["_id": id, "title":title, "memo": memo, "endDate" : endDate,"tag":tag, "priority":priority], update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func updateComplete(_ item : ToDoTable) {
        
        do {
            try realm.write {
                item.completed.toggle()
            }
        } catch {
            print(error)
        }
    }
    
    func updateFlag(_ item : ToDoTable) {
        
        do {
            try realm.write {
                item.flag.toggle()
            }
        } catch {
            print(error)
        }
    }
    
    func removeItem(_ item : ToDoTable) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
}


