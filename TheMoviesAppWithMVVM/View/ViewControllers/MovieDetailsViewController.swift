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
    
//    @IBOutlet weak var navBar: UINavigationBar!
//    @IBOutlet weak var navItem: UINavigationItem!
//    @IBOutlet weak var backButton: UIBarButtonItem!
    
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
        movieDetailsViewModel.fetchCast(id: dataList?.id ?? 0)
        movieDetailsViewModel.fetchVideos(id: dataList?.id ?? 0)
        setupUI()
        setupDetails()
        getNavCont()
    }
    
    private func setupUI() {
        self.scrollView.delegate = self
        self.navigationController?.delegate = self
        self.videosCV.delegate = self
        self.videosCV.dataSource = self
        self.castCV.delegate = self
        self.castCV.dataSource = self
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
        navigationController?.navigationBar.layer.opacity = 0.01
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "CastDetailsStoryboard", bundle: nil)
        let castDetailVC = storyboard.instantiateViewController(withIdentifier: "CastDetailVC") as! CastDetailsViewController
        let detailsList = movieDetailsViewModel.castDetails[indexPath.row]
        castDetailVC.detailsList = detailsList
        self.navigationController?.pushViewController(castDetailVC, animated: true)
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

extension MovieDetailsViewController: UINavigationControllerDelegate {
    func getNavCont() -> UINavigationController? {
        var backButton: UIBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.layer.opacity = 0.1
        return navigationController
    }
}

extension MovieDetailsViewController: UIScrollViewDelegate { }

extension MovieDetailsViewController: MovieDetailsOutput {
    func saveDatas() {
        self.videosCV.reloadData()
        self.castCV.reloadData()
    }
}
