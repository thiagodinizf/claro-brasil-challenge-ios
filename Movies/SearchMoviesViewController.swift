//
//  SearchMoviesViewController.swift
//  Movies
//
//  Created by Thiago Diniz on 26/01/2018.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import Foundation
import UIKit
import StatefulViewController

class SearchMoviesViewController: UIViewController {
    
    var movies: [MovieViewModel] = []
 
    @IBOutlet var collectionView: UICollectionView!
    
    var searchController: UISearchController!
    
    var service: MovieService!
    
    var searchTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = L10n.Search.title
        self.service = MovieService(delegate: self)
        self.collectionView.register(cellType: MovieCollectionViewCell.self)
        self.setupSearchbar()
        self.setupTitle()
        
        self.loadingView = LoadingView(frame: view.frame)
        self.emptyView = EmptyView(frame: view.frame, emptyMessage: L10n.Search.empty)
    }
    
    private func setupTitle() {
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = searchController
            self.navigationItem.largeTitleDisplayMode = .never
            self.navigationItem.hidesSearchBarWhenScrolling = false
        } else{
            self.navigationItem.titleView = searchController.searchBar
        }
    }
    
    private func setupSearchbar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = L10n.Search.barPlaceholder
        searchController.searchBar.sizeToFit()
        searchController.searchBar.tintColor = .white
        searchController.isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.isMovingToParentViewController {
            searchController.isActive = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupInitialViewState()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.searchTimer?.invalidate()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch StoryboardSegue.Main(rawValue: segue.identifier!)! {
        case .searchMovie:
            if let indexPath = sender as? IndexPath {
                let controller = segue.destination as! MovieViewController
                controller.movie = self.movies[indexPath.item]
            }
        default:
            break
        }
    }
}

extension SearchMoviesViewController: ResponseDelegate {
    func success(type: ResponseType) {
        switch type {
        case .search(let movies):
            if let movies = movies {
                self.movies = MovieViewModel.moviesAsView(movies)
                self.collectionView.reloadDataWithAnimation()
                self.endLoading()
            }
        default:
            ()
        }
    }
    
    func failure(type: ResponseType, errorType: APIError) {
        self.errorView = EmptyView(frame: view.frame, emptyMessage: errorType.description)
        self.endLoading(animated: true, error: errorType.error)
    }
}

extension SearchMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = self.movies[indexPath.item]
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MovieCollectionViewCell.self)
        cell.bind(movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ItemSize.insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return ItemSize.itemInsets()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ItemSize.collectionViewItemSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.searchController.searchBar.becomeFirstResponder()
        self.searchController.isActive = false
        performSegue(withIdentifier: StoryboardSegue.Main.searchMovie.rawValue, sender: indexPath)
    }
}

extension SearchMoviesViewController: StatefulViewController, StatefulPlaceholderView {
    
    func hasContent() -> Bool {
        return self.movies.count > 0
    }
}

extension SearchMoviesViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.searchTimer?.invalidate()
        self.clearResult()
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.searchTimer?.invalidate()
        if let searchString = searchController.searchBar.text {
            if !searchString.isEmpty && searchString.count > 2 {
                self.searchTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(SearchMoviesViewController.searchTimer(_:)), userInfo: searchString, repeats: false)
            }
        }
    }
    
    @objc func searchTimer(_ timer: Timer) {
        if let text = timer.userInfo as? String {
            self.startLoading()
            self.service.search(query: text)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = nil
        self.dismiss(animated: true, completion: nil)
        self.searchTimer?.invalidate()
    }
    
    func presentSearchController(_ searchController: UISearchController) {
        self.searchController.searchBar.becomeFirstResponder()
        self.searchTimer?.invalidate()
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        self.searchTimer?.invalidate()
    }
    
    private func clearResult() {
        self.movies = []
        self.collectionView.reloadDataWithAnimation()
        self.endLoading()
    }
}
