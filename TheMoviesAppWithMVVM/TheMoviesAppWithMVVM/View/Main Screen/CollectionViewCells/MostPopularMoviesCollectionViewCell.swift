//
//  MostPopularMoviesCollectionViewCell.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 18.01.2023.
//

import UIKit
import Kingfisher

class MostPopularMoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func saveModel(model: MostPopularMovie) {
        imageMovie.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(model.poster_path ?? "")"))
        movieNameLabel.text = model.original_title
        overviewLabel.text = model.overview
        self.imageMovie.layer.cornerRadius = 10.0
    }
    
}
