//
//  MemoryStorage.swift
//  RxMemo_BM
//
//  Created by 김삼복 on 07/04/2020.
//  Copyright © 2020 김삼복. All rights reserved.
//

import Foundation
import RxSwift

//메모리에 메모 저장
class MemoryStorage: MemoStorageType{
    //메모를 저장할 배열 선언
    private var list = [
        Memo(content: "Hello, RxSwift", insertData: Date().addingTimeInterval(-10)),
        Memo(content: "BOMS2", insertData: Date().addingTimeInterval(-20))
    ]
    
    //기본값을 list로 하려고 lazy로 선언, 외부에서 직접 접근 안해서 private
    private lazy var store = BehaviorSubject<[Memo]>(value: list)
    
    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)
        list.insert(memo, at: 0)
        
        store.onNext(list)
        
        return Observable.just(memo)
    }
    
    @discardableResult
    func memoList() -> Observable<[Memo]> {
        return store
    }
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updated = Memo(original: memo, updatedContent: content)
        
        //원본 인스턴스를 새로운 인스턴스로 업데이트
        if let index = list.firstIndex(where: { $0 == memo}) {
            list.remove(at: index)
            list.insert(updated, at: index)
        }
        
        store.onNext(list)
        
        return Observable.just(updated)
    }
    
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> {
        if let index = list.firstIndex(where: { $0 == memo}) {
            list.remove(at: index)
        }
        
        store.onNext(list)
        
        return Observable.just(memo)
    }
    
    
}
