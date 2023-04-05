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
    
    private let searcher = UISearchController(searchResultsController: nil)
    
    var makingSearch: Bool = false
    var searchedMovie: [MostPopularMovie] = [MostPopularMovie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mostPopularMovieViewModel.fetchMovies()
        setNavCont()
        setupUI()
        createSearchBar()
    }

    private func setupUI(){
        title = "Home"
        self.mostPopularMoviesCV.delegate = self
        self.mostPopularMoviesCV.dataSource = self
        mostPopularMovieViewModel.setDelegate(output: self)
        mostPopularMovieViewModel.mostPopularMoviesOutput?.saveDatas()
    }
    
    private func createSearchBar() {
        navigationItem.searchController = searcher
        searcher.searchBar.delegate = self
        searcher.searchBar.placeholder = "Search a movie..."
    }
    
    private func setNavCont() {
        navigationController?.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.isOpaque = false
    }
    
}

extension MostPopularMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if makingSearch == false {
            return mostPopularMovieViewModel.dataList.count
        } else {
            return searchedMovie.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if makingSearch == false {
            let storyboard: UIStoryboard = UIStoryboard(name: "MovieDetailsStoryboard", bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! MovieDetailsViewController
            let dataList = mostPopularMovieViewModel.dataList[indexPath.row]
            detailVC.dataList = dataList
            self.navigationController?.pushViewController(detailVC, animated: true)
        } else {
            let storyboard: UIStoryboard = UIStoryboard(name: "MovieDetailsStoryboard", bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! MovieDetailsViewController
            let dataList = searchedMovie[indexPath.row]
            detailVC.dataList = dataList
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesCell", for: indexPath) as? MostPopularMoviesCollectionViewCell else { return UICollectionViewCell() }
        
        collectionView.layer.backgroundColor = view.backgroundColor?.cgColor
        
        if makingSearch == false {
            
            cell.saveModel(model: mostPopularMovieViewModel.dataList[indexPath.row])
            
        } else {
            cell.saveModel(model: searchedMovie[indexPath.row])
        }
        return cell
    }
    
}

extension MostPopularMoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            makingSearch = false
        } else {
            makingSearch = true
            searchedMovie = mostPopularMovieViewModel.dataList.filter({ $0.original_title?.lowercased().contains(searchText.lowercased()) ?? false })
        }
        mostPopularMoviesCV.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        title = "Home"
        makingSearch = false
        mostPopularMovieViewModel.fetchMovies()
        mostPopularMovieViewModel.mostPopularMoviesOutput?.saveDatas()
    }
}

extension MostPopularMoviesViewController: UINavigationControllerDelegate { }

extension MostPopularMoviesViewController: MostPopularMoviesOutput {
    func saveDatas() {
        mostPopularMoviesCV.reloadData()
    }
}
