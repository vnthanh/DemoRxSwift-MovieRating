//
//  AnotherViewController.swift
//  DemoRxSwift
//
//  Created by ThanhVo on 4/27/18.
//  Copyright © 2018 ThanhVo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AnotherViewController: UIViewController {

    let bag = DisposeBag()
    @IBOutlet weak var firstSlider: UISlider!
    @IBOutlet weak var secondSlider: UISlider!
    
    let a: Variable<Float> = Variable(0)
    let b: Variable<Float> = Variable(0)
    
    @IBOutlet weak var aLabel: UILabel!
    @IBOutlet weak var bLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bind a, b float value to label
        a.asObservable().map { value -> String in
            return String(value)
            }.asObservable().bind(to: aLabel.rx.text).disposed(by: bag)
        
        b.asObservable().map { value -> String in
            return String(value)
            }.asObservable().bind(to: bLabel.rx.text).disposed(by: bag)
        
        // Bind a b to slider
        a.asObservable().bind(to: firstSlider.rx.value).disposed(by: bag)
        b.asObservable().bind(to: secondSlider.rx.value).disposed(by: bag)
        
        // Subscribe slider changes
        firstSlider.rx.value.asObservable().subscribe(onNext: { value in
            self.a.value = value.rounded()
        }).disposed(by: bag)
        
        secondSlider.rx.value.asObservable().subscribe(onNext: { value in
            self.b.value = value.rounded()
        }).disposed(by: bag)
        
        
        // Combine value emitted from a and b (add) and bind to result label
        let combine: Observable = Observable.combineLatest(a.asObservable(), b.asObservable(), resultSelector:
        {
            $0 + $1
        }).map({ value -> String in
            return "a+b= \(String(value))"
        })
        
        combine.bind(to: resultLabel.rx.text).addDisposableTo(bag)
    }
}
