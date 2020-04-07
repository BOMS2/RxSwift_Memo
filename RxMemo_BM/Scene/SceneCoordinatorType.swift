//
//  SceneCoordinatorType.swift
//  RxMemo_BM
//
//  Created by 김삼복 on 07/04/2020.
//  Copyright © 2020 김삼복. All rights reserved.
//

import Foundation
import RxSwift

//공통적으로 구현해야하는걸 선언
protocol SceneCoordinatorType {
    //새로운 scene을 표시
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable
    
    //@discardableResult를 추가해서 return 없어도 에러 안남
    @discardableResult
    func close(animated: Bool) -> Completable
}
