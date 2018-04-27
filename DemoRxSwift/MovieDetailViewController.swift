//
//  MovieDetailViewController.swift
//  DemoRxSwift
//
//  Created by ThanhVo on 4/27/18.
//  Copyright © 2018 ThanhVo. All rights reserved.
//

import UIKit
import  RxSwift

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    var movie: Movie?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Bind movie to textField and slider
        movie?.title.asObservable().bind(to: titleTextField.rx.text).disposed(by: disposeBag)
        movie?.rating.asObservable().bind(to: ratingSlider.rx.value).disposed(by: disposeBag)
        
        // We need to do 2-ways binding ?
        titleTextField.rx.text.asObservable().subscribe(onNext: { _ in
            self.movie?.title.value = self.titleTextField.text!
        }).disposed(by: disposeBag)
        
        ratingSlider.rx.value.asObservable().subscribe(onNext: { _ in
            self.movie?.rating.value = self.ratingSlider.value
            self.sliderValueLabel.text = String(self.ratingSlider.value.rounded())
        }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
