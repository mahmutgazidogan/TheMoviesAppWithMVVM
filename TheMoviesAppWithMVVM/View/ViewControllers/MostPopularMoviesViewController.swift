//
//  MostPopularMoviesViewController.swift
//  TheMoviesAppWithMVVM
//
//  Created by Mahmut Gazi Doğan on 18.01.2023.
//

import UIKit


protocol MostPopularMoviesOutput {
    func saveDatas()
}

class MostPopularMoviesViewController: UIViewController {
    
    let mostPopularMovieViewModel: MostPopularMovieViewModelProtocol = MostPopularMovieViewModel()
    
    @IBOutlet weak var mostPopularMoviesCV: UICollectionView!
    @IBOutlet weak var mostPopularsLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mostPopularMovieViewModel.fetchMovies()
        setupUI()
    }

    
    private func setupUI(){
        self.mostPopularMoviesCV.delegate = self
        self.mostPopularMoviesCV.dataSource = self
        mostPopularMovieViewModel.setDelegate(output: self)
        mostPopularMovieViewModel.mostPopularMoviesOutput?.saveDatas()
    }
    
}

extension MostPopularMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mostPopularMovieViewModel.dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "MovieDetailsStoryboard", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! MovieDetailsViewController
        let dataList = mostPopularMovieViewModel.dataList[indexPath.row]
        detailVC.dataList = dataList
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesCell", for: indexPath) as? MostPopularMoviesCollectionViewCell else { return UICollectionViewCell() }

        /// Cell graphics
        
        //cell.translatesAutoresizingMaskIntoConstraints = false
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 10.0
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        collectionView.layer.backgroundColor = view.backgroundColor?.cgColor
        // cell.imageMovie.topAnchor.constraint(greaterThanOrEqualTo: cell.topAnchor, constant: 50.0).isActive = true
        // cell.topAnchor.constraint(lessThanOrEqualTo: cell.imageMovie.topAnchor, constant: -60.0).isActive = true
        // cell.imageMovie.topAnchor.constraint(lessThanOrEqualTo: cell.topAnchor, constant: 50.0).isActive = true
        
        cell.saveModel(model: mostPopularMovieViewModel.dataList[indexPath.row])
        return cell
    }
    
}

extension MostPopularMoviesViewController: MostPopularMoviesOutput {
    func saveDatas() {
        mostPopularMoviesCV.reloadData()
    }
}
