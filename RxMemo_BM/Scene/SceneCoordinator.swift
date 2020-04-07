//
//  SceneCoordinator.swift
//  RxMemo_BM
//
//  Created by 김삼복 on 07/04/2020.
//  Copyright © 2020 김삼복. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension UIViewController {
    var sceneViewController: UIViewController {
        return self.children.first ?? self
    }
}


class SceneCoordinator: SceneCoordinatorType {
    private let bag = DisposeBag()
    
    private var window: UIWindow
    private var currentVC: UIViewController
    
    required init(window: UIWindow) {
        self.window = window
        currentVC = window.rootViewController!
    }
    
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
        //전환 결과를 방출할 서브젝트 선언
        let subject = PublishSubject<Void>()
        
        let target = scene.instantiate()
        
        //트랜지션 스타일에 따라 실제 전환을 처리
        switch style {
        case .root:
            //currentVC = target 수정 전
            currentVC = target.sceneViewController
            window.rootViewController = target
            subject.onCompleted()
        case .push:
            print(currentVC)
            guard let nav = currentVC.navigationController else {
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }
            
            nav.rx.willShow
                .subscribe(onNext: { [unowned self] evt in
                    self.currentVC = evt.viewController.sceneViewController
                })
                .disposed(by: bag)
            
            nav.pushViewController(target, animated: animated)
            currentVC = target.sceneViewController
            
            subject.onCompleted()
        case .modal:
            currentVC.present(target, animated: animated){
                subject.onCompleted()
            }
            currentVC = target.sceneViewController
        }
        
        return subject.ignoreElements()
    }
    
    //Completable을 직접 생성하는 방식으로 구현
    @discardableResult
    func close(animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            if let presentingVC = self.currentVC.presentingViewController {
                self.currentVC.dismiss(animated: animated) {
                    self.currentVC = presentingVC.sceneViewController
                    completable(.completed)
                }
            } else if let nav = self.currentVC.navigationController{
                guard nav.popViewController(animated: animated) != nil else {
                    completable(.error(TransitionError.cannotPop))
                    return Disposables.create()
                }
                self.currentVC = nav.viewControllers.last!
                completable(.completed)
            } else {
                completable(.error(TransitionError.unknown))
            }
            
            return Disposables.create()
            
        }
    }
    
    
}
