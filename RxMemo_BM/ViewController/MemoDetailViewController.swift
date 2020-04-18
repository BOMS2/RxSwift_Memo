//
//  MemoDetailViewController.swift
//  RxMemo_BM
//
//  Created by 김삼복 on 07/04/2020.
//  Copyright © 2020 김삼복. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx

class MemoDetailViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoDetailViewModel!
    
    @IBOutlet weak var listTableView: UITableView!
    

    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.contents
            .bind(to: listTableView.rx.items) { tableView, row, value in
                switch row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell")!
                    cell.textLabel?.text = value
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell")!
                    cell.textLabel?.text = value
                    return cell
                default:
                    fatalError()
                }
        }
        
        .disposed(by: rx.disposeBag)
        
        
        //편집버튼은 액션 활용
        editButton.rx.action = viewModel.makeEditAction()
        
        
        //뒤로가기 버튼을 교체하는 코드
        //        var backButton = UIBarButtonItem(title: nil, style: .done, target: nil, action: nil)
        //
        //                viewModel.title
        //                    .drive(backButton.rx.title)
        //                    .disposed(by: rx.disposeBag)
        //
        //                backButton.rx.action = viewModel.popAction
        //                navigationItem.hidesBackButton = true
        //        //        navigationItem.backBarButtonItem = backButton
        //                navigationItem.leftBarButtonItem = backButton
                
                
        
        
        //sharebutton 구현, 탭속성 활용
        shareButton.rx.tap
            .throttle(.microseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [ weak self] _ in
                guard let memo = self?.viewModel.memo.content else { return }
                
                let vc = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
                self?.present(vc, animated: true, completion: nil)
                
            })
            .disposed(by: rx.disposeBag)
    }

}
