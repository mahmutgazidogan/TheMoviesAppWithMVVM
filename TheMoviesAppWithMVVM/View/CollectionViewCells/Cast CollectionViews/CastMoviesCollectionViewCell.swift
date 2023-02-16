//
//  CastMoviesCollectionViewCell.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 26.01.2023.
//

import UIKit
import Kingfisher

class CastMoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func saveModel(model: PeopleMovieCredits) {
        if model.poster_path == nil {
            movieImage.kf.setImage(with: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/No_picture_available.png/401px-No_picture_available.png"))
        } else {
            movieImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(model.poster_path ?? "")"))
        }
        
        movieNameLabel?.text = model.original_title
        
        movieImage.clipsToBounds = true
        movieImage.layer.cornerRadius = 10.0
    }
    
}
