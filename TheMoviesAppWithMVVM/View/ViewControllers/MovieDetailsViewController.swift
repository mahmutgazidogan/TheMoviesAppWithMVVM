//
//  MovieDetailsViewController.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 22.01.2023.
//

import UIKit
import Cosmos

protocol MovieDetailsOutput {
    func saveDatas()
}

class MovieDetailsViewController: UIViewController {
   
    var dataList: MostPopularMovie?
    let movieDetailsViewModel: MovieDetailsViewModelProtocol = MovieDetailsViewModel()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewForImages: UIView!
    @IBOutlet weak var bigMovieImage: UIImageView!
    @IBOutlet weak var smallMovieImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var videosLabel: UILabel!
    @IBOutlet weak var videosCV: UICollectionView!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var castCV: UICollectionView!
    @IBOutlet weak var moviesRate: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailsViewModel.fetchVideos(id: dataList?.id ?? 0)
        movieDetailsViewModel.fetchCast(id: dataList?.id ?? 0)
        setupUI()
        setupDetails()
        
    }
    
    private func setupUI() {
        self.videosCV.delegate = self
        self.videosCV.dataSource = self
        self.castCV.delegate = self
        self.castCV.dataSource = self
        
//        videosCV.register(VideosCollectionViewCell.self, forCellWithReuseIdentifier: "videosCell")
//        castCV.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: "castCell")
        movieDetailsViewModel.setDelegate(output: self)
        movieDetailsViewModel.movieDetailsOutput?.saveDatas()
    }
    
    private func setupDetails() {
        bigMovieImage.kf.setImage(with: URL(string: Constants.imageURL + (dataList?.poster_path ?? "")))
        smallMovieImage.kf.setImage(with: URL(string: Constants.imageURL + (dataList?.poster_path ?? "")))
        movieNameLabel.text = dataList?.original_title
        overviewLabel.text = dataList?.overview
        moviesRate.rating = (dataList?.vote_average ?? 0.0) / 2
        detailDrawings()
    }
    
    private func detailDrawings() {
        bigMovieImage.layer.opacity = 0.1
        smallMovieImage.clipsToBounds = true
        smallMovieImage.layer.cornerRadius = 10.0
        moviesRate.backgroundColor = viewForImages.backgroundColor
        //navigationController?.navigationBar.layer.opacity = 0.1
        //navigationController?.navigationItem.titleView?.layer.opacity = 0.1
        
    }

}

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0: return movieDetailsViewModel.videoDetails.count
        case 1: return movieDetailsViewModel.castDetails.count
        default: return Int()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videosCell", for: indexPath) as? VideosCollectionViewCell else { return UICollectionViewCell() }
            cell.saveModel(model: movieDetailsViewModel.videoDetails[indexPath.row])
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "castCell", for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell() }
            cell.saveModel(model: movieDetailsViewModel.castDetails[indexPath.row])
            return cell
            
        default:
            return UICollectionViewCell()
        }

    }
    
}

extension MovieDetailsViewController: MovieDetailsOutput {
    func saveDatas() {
        self.videosCV.reloadData()
        self.castCV.reloadData()
    }
}
