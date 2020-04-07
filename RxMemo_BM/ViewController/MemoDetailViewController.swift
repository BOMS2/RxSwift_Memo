//
//  MemoDetailViewController.swift
//  RxMemo_BM
//
//  Created by 김삼복 on 07/04/2020.
//  Copyright © 2020 김삼복. All rights reserved.
//

import UIKit

class MemoDetailViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoDetailViewModel!
    
    @IBOutlet weak var listTableView: UITableView!
    
    @IBOutlet weak var deleteButton: UIToolbar!
    @IBOutlet weak var editButton: UIToolbar!
    
    @IBOutlet weak var shareButton: UIToolbar!
    
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
    }

}
