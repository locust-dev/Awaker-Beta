//
//  ProfileViewController.swift
//  Awaker
//
//  Created by Ilya Turin on 09.03.2022.
//

import UIKit
import RxSwift

final class ProfileViewController: NLViewController {
    

    var array = [1, 2, 3]
    
    let bag = DisposeBag()
    var subject = PublishSubject<Int>()
    
    let button = UIButton()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
    }
    
    private func drawSelf() {
       
        view.backgroundColor = .white
        button.backgroundColor = .purple
        tabBarItem.title   = "Profile"
        
        let sub = subject.subscribe { event in
            print(event)
        }
        
        subject.onNext(1)
        
        sub.disposed(by: bag)
      
        subject.onNext(2)
        
        
        view.addSubview(button)
        button.autoSetDimensions(to: CGSize(width: 100, height: 100))
        button.autoCenterInSuperview()
    }
    
}
