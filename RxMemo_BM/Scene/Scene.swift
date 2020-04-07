//
//  Scene.swift
//  RxMemo_BM
//
//  Created by 김삼복 on 07/04/2020.
//  Copyright © 2020 김삼복. All rights reserved.
//

import UIKit

//앱에서 구현할 scene을 열거형으로 선언
enum Scene {
    case list(MemoListViewModel)
    case detail(MemoDetailViewModel)
    case compose(MemoComposeViewModel)
}

//스토리보드에 있는 신을 생성하고 연관값에 저장된 뷰모델을 바인딩해서 리턴
extension Scene {
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
            switch self {
            case .list(let viewModel):
                guard let nav = storyboard.instantiateViewController(withIdentifier: "ListNav") as? UINavigationController else {
                    fatalError()
            }
        
                guard var listVC = nav.viewControllers.first as?
                    MemoListViewController else {
                    fatalError()
                }
                
                listVC.bind(viewModel: viewModel)
                return nav
            case .detail(let viewModel):
                guard var detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? MemoDetailViewController else {
                    fatalError()
                }
                detailVC.bind(viewModel: viewModel)
                return detailVC
            case .compose(let viewModel):
                guard let nav = storyboard.instantiateViewController(withIdentifier: "ComposeNav") as? UINavigationController else {
                        fatalError()
                }
                guard var ComposeNav = nav.viewControllers.first as?
                    MemoComposeViewController else {
                    fatalError()
                }
                ComposeNav.bind(viewModel: viewModel)
                return nav
        }
    }
}
