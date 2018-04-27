//
//  MovieTableViewCell.swift
//  DemoRxSwift
//
//  Created by ThanhVo on 4/26/18.
//  Copyright © 2018 ThanhVo. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func configureCell(movie: Movie) {
        titleLabel.text = movie.title.value
        ratingLabel.text = String(movie.rating.value)
    }
}

