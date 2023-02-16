//
//  VideosCollectionViewCell.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 22.01.2023.
//

import UIKit
import YouTubeiOSPlayerHelper

class VideosCollectionViewCell: UICollectionViewCell {

    @IBOutlet var videoPlayer: YTPlayerView!
    @IBOutlet weak var videoNameLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        videoPlayer.delegate = self
    }
    
    func saveModel(model: MovieVideos) {
        videoPlayer.load(withVideoId: model.key ?? "")
        videoNameLabel.text = model.name
        
        videoPlayer.clipsToBounds = true
        videoPlayer.layer.cornerRadius = 10.0
    }
    
}

extension VideosCollectionViewCell: YTPlayerViewDelegate {}

