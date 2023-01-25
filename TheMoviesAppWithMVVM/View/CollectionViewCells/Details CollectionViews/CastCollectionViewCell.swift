//
//  CastCollectionViewCell.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 22.01.2023.
//

import UIKit
import Kingfisher

class CastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCast: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func saveModel(model: CastPersons) {
        imageCast.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(model.profile_path ?? "")"))
        personNameLabel.text = model.name
        
        imageCast.clipsToBounds = true
        imageCast.layer.cornerRadius = 10.0
    }
}

