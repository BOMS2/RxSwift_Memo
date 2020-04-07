//
//  CommonViewModel.swift
//  RxMemo_BM
//
//  Created by 김삼복 on 08/04/2020.
//  Copyright © 2020 김삼복. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

//title
class CommonViewModel: NSObject {
    //네비게이션 아이템에 쉽게 바인딩 가능
    let title: Driver<String>
    let sceneCoordinator: SceneCoordinatorType
    let storage: MemoStorageType
    
    //속성 초기화하는 생성자 부여
    init(title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = sceneCoordinator
        self.storage = storage
    }
}
