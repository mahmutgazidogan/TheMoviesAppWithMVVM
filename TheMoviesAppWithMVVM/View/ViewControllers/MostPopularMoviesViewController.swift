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
    @IBOutlet weak var searchBar: UISearchBar! = UISearchBar()
    
    var makingSearch: Bool = false
    var searchedMovie: [MostPopularMovie] = [MostPopularMovie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mostPopularMovieViewModel.fetchMovies()
        setupUI()
        setNavCont()
        getNavCont()
    }

    private func setupUI(){
        self.mostPopularMoviesCV.delegate = self
        self.mostPopularMoviesCV.dataSource = self
        self.searchBar.delegate = self
        self.navigationController?.delegate = self
        mostPopularMovieViewModel.setDelegate(output: self)
        mostPopularMovieViewModel.mostPopularMoviesOutput?.saveDatas()
    }
    
    private func setNavCont() {
        var leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
        
        cell.labelsView.layer.cornerRadius = 10.0
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
}

extension MostPopularMoviesViewController: UINavigationControllerDelegate {
    func getNavCont() -> UINavigationController? {
        navigationController?.navigationBar.layer.opacity = 1.0
        return navigationController
    }
}

extension MostPopularMoviesViewController: MostPopularMoviesOutput {
    func saveDatas() {
        mostPopularMoviesCV.reloadData()
    }
}
