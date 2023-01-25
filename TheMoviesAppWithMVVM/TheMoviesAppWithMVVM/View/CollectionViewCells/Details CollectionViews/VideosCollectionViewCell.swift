//
//  VideosCollectionViewCell.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 22.01.2023.
//

import UIKit

protocol VideosCollectionViewProtocol {
    func update (items: [MovieVideos])
}

class VideosCollectionView: NSObject {
    private lazy var items: [MovieVideos] = []
}

class VideosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var videoPlayer: YTPlayerView!
    @IBOutlet weak var videoNameLabel: UILabel!
    
    func saveModel(model: MovieVideos) {
        videoPlayer.load(withVideoId: model.key ?? "", playerVars: ["playsInline": "1"])
        videoNameLabel.text = model.name
    }
}

extension VideosCollectionView: VideosCollectionViewProtocol {
    func update(items: [MovieVideos]) {
        self.items = items
    }
}

extension VideosCollectionViewCell: YTPlayerViewDelegate {}

