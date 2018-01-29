//
//  FavoriteMoviesViewController.swift
//  Movies
//
//  Created by Thiago Diniz on 25/01/2018.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import UIKit
import StatefulViewController

class FavoriteMoviesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [MovieViewModel] = [] {
        didSet{
            self.collectionView.reloadDataWithAnimation()
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(cellType: MovieCollectionViewCell.self)
        self.loadingView = LoadingView(frame: view.frame)
        self.emptyView = EmptyView(frame: view.frame, emptyMessage: L10n.Favorite.empty)
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .always
        }
        self.title =  L10n.Favorite.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupInitialViewState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startLoading()
        self.movies = MovieViewModel.getFavorites()
        self.endLoading()
    }
 
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch StoryboardSegue.Main(rawValue: segue.identifier!)! {
        case .favoriteMovie:
            if let indexPath = sender as? IndexPath {
                let controller = segue.destination as! MovieViewController
                controller.movie = self.movies[indexPath.item]
            }
        default:
            break
        }
    }
}

extension FavoriteMoviesViewController: StatefulViewController, StatefulPlaceholderView {
    
    func hasContent() -> Bool {
        return self.movies.count > 0
    }
}

extension FavoriteMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        performSegue(withIdentifier: StoryboardSegue.Main.favoriteMovie.rawValue, sender: indexPath)
    }
}
