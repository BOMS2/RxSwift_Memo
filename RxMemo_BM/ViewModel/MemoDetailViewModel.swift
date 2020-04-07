//
//  MemoDetailViewModel.swift
//  RxMemo_BM
//
//  Created by 김삼복 on 07/04/2020.
//  Copyright © 2020 김삼복. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Action

class MemoDetailViewModel: CommonViewModel {
    let memo: Memo
    
    //이전 scene에서 저장된 메모
    private var formatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "Ko_kr")
        f.dateStyle = .medium
        f.timeStyle = .medium
        return f
    }()
    
    var contents: BehaviorSubject<[String]>.Observer
    
    init(memo: Memo, title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType){
        self.memo = memo
        
        contents = BehaviorSubject<[String]>(value: [
            memo.content, formatter.string(from: memo.insertData)
        ])
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
    
    //백버튼과 바인딩할 액션 추가
       lazy var popAction = CocoaAction{ [unowned self] in
           return self.sceneCoordinator.close(animated: true).asObservable().map { _ in }
           
       }
}
