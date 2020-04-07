//
//  MemoListViewController.swift
//  RxMemo_BM
//
//  Created by 김삼복 on 07/04/2020.
//  Copyright © 2020 김삼복. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MemoListViewController: UIViewController , ViewModelBindableType {

    var viewModel: MemoListViewModel!
    
    
    @IBOutlet weak var listTableView: UITableView!
    
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //뷰모델과 뷰를 바인딩
    //선택한 메모가 액션으로 전달되고 액션에 구현되어있는 코드가 실행
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.memoList
            .bind(to: listTableView.rx.items(cellIdentifier: "cell")) { row, memo, cell in
                cell.textLabel?.text = memo.content
        }
        .disposed(by: rx.disposeBag)
        
        addButton.rx.action = viewModel.makeCreateAction()
        
        Observable.zip(listTableView.rx.modelSelected(Memo.self),
                       listTableView.rx.itemSelected)
            .do(onNext: { [unowned self] (_, indexPath) in
                self.listTableView.deselectRow(at: indexPath, animated: true)
                })
            .map { $0.0 }
            .bind(to: viewModel.detailAction.inputs)
            .disposed(by: rx.disposeBag)
    }


}
