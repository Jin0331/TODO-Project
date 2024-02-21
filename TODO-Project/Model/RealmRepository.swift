//
//  ToDoTableRepository.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/18/24.
//

import UIKit
import RealmSwift

//TODO: - 제네릭을 활용할 수 있는 방법? -> Column이 다르므로, 공통적인 사항은 제네릭 적용할 수 있을 듯
//TODO: - Argument를 받을 수 있을 때는 쉽게 할 수 있지만, Void -> type 일경우에는...

final class RealmRepository {
    
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
    
    func createItem<T:Object>(_ item : T) {
        
        do {
            try realm.write {
                realm.add(item)
                print("Realm Create")
            }
        } catch {
            print(error)
        }
        
    }
    
    func removeItem<T:Object>(_ item : T) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
    //MARK: - GroupTask Table 관련
    func createRelation(destination : TaskGroup, from : ToDoTable) {
        do {
            try realm.write {
                destination.todo.append(from)
            }
        } catch {
            print(error)
        }
        
    }
    
    
    func fetch() -> Results<TaskGroup> {
        
        return realm.objects(TaskGroup.self)
        
    }
    
    //MARK: - ToDo Table 관련
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
}


