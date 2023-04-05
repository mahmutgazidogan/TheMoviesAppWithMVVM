//
//  CastDetailsViewController.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 25.01.2023.
//

import UIKit
import Kingfisher

protocol CastDetailsOutput {
    func saveDatas()
    func getBiography()
}

class CastDetailsViewController: UIViewController {
    
    var detailsList: CastPersons?
    let castDetailsViewModel: CastDetailsViewModelProtocol = CastDetailsViewModel()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewForImages: UIView!
    @IBOutlet weak var bigPersonImage: UIImageView!
    @IBOutlet weak var smallPersonImage: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personJobLabel: UILabel!
    @IBOutlet weak var biographyTitleLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    @IBOutlet weak var moviesTitleLabel: UILabel!
    @IBOutlet weak var moviesCV: UICollectionView!
    @IBOutlet weak var tvsTitleLabl: UILabel!
    @IBOutlet weak var tvsCV: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        castDetailsViewModel.fetchPersonDetails(id: detailsList?.id ?? 0)
        castDetailsViewModel.fetchMovieCredits(id: detailsList?.id ?? 0)
        castDetailsViewModel.fetchTvCredits(id: detailsList?.id ?? 0)
        setupUI()
        setupCastDetails()
    }
    
    private func setupUI() {
        self.scrollView.delegate = self
        self.navigationController?.delegate = self
        self.moviesCV.delegate = self
        self.moviesCV.dataSource = self
        self.tvsCV.delegate = self
        self.tvsCV.dataSource = self
        castDetailsViewModel.setDelegate(output: self)
    }
    
    private func setupCastDetails() {
        bigPersonImage.kf.setImage(with: URL(string: Constants.imageURL + (detailsList?.profile_path ?? "")))
        smallPersonImage.kf.setImage(with: URL(string: Constants.imageURL + (detailsList?.profile_path ?? "")))
        personNameLabel.text = detailsList?.name
        personJobLabel.text = detailsList?.known_for_department
        castDetailsDrawings()
    }
    
    private func castDetailsDrawings() {
        bigPersonImage.layer.opacity = 0.5
        smallPersonImage.clipsToBounds = true
        smallPersonImage.layer.cornerRadius = 10.0
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension CastDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0: return castDetailsViewModel.movieCredits.count
        case 1: if castDetailsViewModel.tvCredits.count == 0 {
            return 1
        } else {
            return castDetailsViewModel.tvCredits.count
        }
        default: return Int()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesCell", for: indexPath) as? CastMoviesCollectionViewCell else { return UICollectionViewCell() }
            cell.saveModel(model: castDetailsViewModel.movieCredits[indexPath.row])
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tvsCell", for: indexPath) as? TVsCollectionViewCell else { return UICollectionViewCell() }
            if castDetailsViewModel.tvCredits.count == 0 {
                cell.tvImage.kf.setImage(with: URL(string: "https://icon-library.com/images/no-data-icon/no-data-icon-12.jpg"))
                cell.tvNameLabel.text = ""
            } else {
                cell.saveModel(model: castDetailsViewModel.tvCredits[indexPath.row])
            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension CastDetailsViewController: UINavigationControllerDelegate { }

extension CastDetailsViewController: UIScrollViewDelegate { }

extension CastDetailsViewController: CastDetailsOutput {
    func getBiography() {
        guard let biography = castDetailsViewModel.personDetails?.biography, castDetailsViewModel.personDetails?.biography != "" else {
            activityIndicator.startAnimating()
            biographyLabel.text = "Biography data has not found!"
            activityIndicator.stopAnimating()
            return
        }
        activityIndicator.startAnimating()
        biographyLabel.text = biography
        activityIndicator.stopAnimating()
    }
    
    func saveDatas() {
        self.moviesCV.reloadData()
        self.tvsCV.reloadData()
    }
    
}
