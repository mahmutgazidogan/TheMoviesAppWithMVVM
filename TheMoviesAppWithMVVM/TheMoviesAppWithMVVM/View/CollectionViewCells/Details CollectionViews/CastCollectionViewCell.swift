//
//  CastCollectionViewCell.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 22.01.2023.
//

import UIKit
import Kingfisher

protocol CastCollectionViewProtocol {
    func update(items: [CastPersons])
}

class CastCollectionView: NSObject {
    private lazy var items: [CastPersons] = []
}

class CastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCast: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    
    func saveModel(model: CastPersons) {
        imageCast.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(model.profile_path ?? "")"))
        personNameLabel.text = model.name
    }
}

extension CastCollectionView: CastCollectionViewProtocol {
    func update(items: [CastPersons]) {
        self.items = items
    }
}
