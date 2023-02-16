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
    @IBOutlet weak var labelsView: UIView!
    @IBOutlet weak var viewImage: UIView!

    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func saveModel(model: MostPopularMovie) {
        imageMovie.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(model.poster_path ?? "")"))
        movieNameLabel.text = model.original_title
        overviewLabel.text = model.overview
        
        labelsView.layer.cornerRadius = 10.0
        labelsView.layer.borderWidth = 1.0
        labelsView.layer.borderColor = UIColor.lightGray.cgColor
        labelsView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        labelsView.layer.shadowColor = UIColor.lightGray.cgColor
        labelsView.layer.cornerRadius = 10.0
        imageMovie.layer.cornerRadius = 10.0
    }
    
}
