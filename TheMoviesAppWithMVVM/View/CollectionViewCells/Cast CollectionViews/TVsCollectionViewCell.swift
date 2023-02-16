//
//  TVsCollectionViewCell.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 26.01.2023.
//

import UIKit
import Kingfisher

class TVsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tvImage: UIImageView!
    @IBOutlet weak var tvNameLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func saveModel(model: PeopleTvCredits) {
        if model.poster_path == nil {
            tvImage.kf.setImage(with: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/No_picture_available.png/401px-No_picture_available.png"))
        } else {
            tvImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(model.poster_path ?? "")"))
        }
        
        tvNameLabel.text = model.original_name
        
        tvImage.clipsToBounds = true
        tvImage.layer.cornerRadius = 10.0
    }
    
}
