//
//  MovieDetailsViewController.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 22.01.2023.
//

import UIKit


class MovieDetailsViewController: UIViewController {
   
    var data: MostPopularMovie?
    let movieDetailsViewModel: MovieDetailsViewModelProtocol = MovieDetailsViewModel()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailsViewModel.fetchVideos(id: data?.id ?? 0)
    }
    
    private func detailsService() {
        
    }
    

}

