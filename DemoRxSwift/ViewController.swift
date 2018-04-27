//
//  ViewController.swift
//  DemoRxSwift
//
//  Created by ThanhVo on 4/23/18.
//  Copyright © 2018 ThanhVo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire

class MovieTableViewController: UIViewController {
    @IBOutlet weak var movieTable: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    let disposeBag = DisposeBag()
    var movies: Variable<[Movie]> = Variable([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeAdding(addButton: addButton)
        initMovies()
        
        // Bind movies to tablview
        movies.asObservable()
            .bind(to: movieTable.rx.items(cellIdentifier: "MovieCell", cellType: MovieTableViewCell.self)) { (row, movie, cell) in
                // Bind each movie fields to track them (along with track the movies themself)
                movie.title.asObservable().bind(to: cell.titleLabel.rx.text).disposed(by: self.disposeBag)
                movie.rating.asObservable().map({ rating -> String in
                    return String(rating.rounded())
                }).asObservable().bind(to: cell.ratingLabel.rx.text).disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
        
        
        // Cell selected handle
        movieTable.rx.modelSelected(Movie.self)
            .subscribe(onNext: {
                movie in
                
                // Present movie detail
                let detailMovieViewController = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
                detailMovieViewController.movie = movie
                self.navigationController?.pushViewController(detailMovieViewController, animated: true)
            }).disposed(by: disposeBag)
    }
    
    private func initMovies() {
        movies.value = [
            Movie(title: Variable("Die Hard"), rating: Variable(Float(5.0))),
            Movie(title: Variable("Twilight"), rating: Variable(Float(1.0)))
        ]
    }
    
    func subscribeAdding(addButton: UIButton) {
        let _ = addButton.rx.tap.asObservable()
            .subscribe(onNext: { _ in
                print("Add button tap")
                // Present movie detail
                let detailMovieViewController = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
                let newMovie = Movie()
                self.movies.value.append(newMovie)
                detailMovieViewController.movie = newMovie
                self.navigationController?.pushViewController(detailMovieViewController, animated: true)
            }).disposed(by: disposeBag)
    }
}
