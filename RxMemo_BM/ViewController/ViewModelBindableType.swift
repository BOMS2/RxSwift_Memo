//
//  ViewModelBindableType.swift
//  RxMemo_BM
//
//  Created by 김삼복 on 07/04/2020.
//  Copyright © 2020 김삼복. All rights reserved.
//

import UIKit

protocol ViewModelBindableType {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set}
    func bindViewModel()
}

//실제 뷰모델을 저장하고 바인드 뷰모델 메소드를 자동으로 호출하는 메소드
//개별 뷰에서 바인드뷰모델을 직접 호출할 필요가 없어서 코드가 단순해짐
extension ViewModelBindableType where Self: UIViewController{
    mutating func bind(viewModel: Self.ViewModelType){
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        bindViewModel()
    }
}
