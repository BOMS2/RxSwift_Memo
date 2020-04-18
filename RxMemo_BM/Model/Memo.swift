//
//  Memo.swift
//  RxMemo_BM
//
//  Created by 김삼복 on 07/04/2020.
//  Copyright © 2020 김삼복. All rights reserved.
//

import Foundation
import RxDataSources

struct Memo: Equatable, IdentifiableType {
    //메모 저장
    var content: String
    //생성 날짜 저장
    var insertData: Date
    //메모를 구분할 때 사용하는 속성
    var identity: String
    
    //생성자 추가
    init(content: String, insertData: Date = Date()){
        self.content = content
        self.insertData = insertData
        self.identity = "\(insertData.timeIntervalSinceReferenceDate)"
    }
    
    //새로운 메모 업데이트
    init(original: Memo, updatedContent: String){
        self = original
        self.content = updatedContent
    }
}
