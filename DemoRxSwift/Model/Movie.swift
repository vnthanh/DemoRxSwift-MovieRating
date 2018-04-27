//
//  Movie.swift
//  DemoRxSwift
//
//  Created by ThanhVo on 4/26/18.
//  Copyright © 2018 ThanhVo. All rights reserved.
//

import RxSwift


class Movie {
    var title: Variable<String>
    var rating: Variable<Float>
    
    init() {
        title = Variable("")
        rating = Variable(Float(5.0))
    }
    
    init(title: Variable<String>, rating: Variable<Float>) {
        self.title = title
        self.rating = rating
    }
}
