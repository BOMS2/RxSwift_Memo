//
//  TransitionModel.swift
//  RxMemo_BM
//
//  Created by 김삼복 on 07/04/2020.
//  Copyright © 2020 김삼복. All rights reserved.
//

import Foundation

//전환 방식을 표현하는 열거형 선언
enum TransitionStyle {
    case root
    case push
    case modal
}

//화면전환에서 에러형식
enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
