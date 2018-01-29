//
//  MovieViewController.swift
//  Movies
//
//  Created by Thiago Diniz on 27/01/18.
//  Copyright © 2018 Thiago Diniz. All rights reserved.
//

import UIKit
import Reusable
import StatefulViewController

class MovieViewController: UIViewController, StoryboardSceneBased {

    static var sceneStoryboard = StoryboardScene.Main.storyboard
    
    @IBOutlet weak var tableView: UITableView!
    
    var isLoaded = false
    var movie: MovieViewModel!
    var service: MovieService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationController?.navigationBar.setTransparentBar()
        self.setupTableview()
        self.service = MovieService(delegate: self)
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        }
        self.loadingView = LoadingView(frame: view.frame)
        self.emptyView = EmptyView(frame: view.frame, emptyMessage: L10n.Search.empty)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupInitialViewState()
        self.startLoading()
        self.service.movie(id: self.movie.id)
    }
    
    private func setupTableview() {
        self.tableView.register(cellType: SynopsisTableViewCell.self)
        self.tableView.register(cellType: ImagesCollectionView.self)
        self.tableView.register(cellType: VideoTableViewCell.self)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 90
    }
    
    private func configureUI() {
        self.tableView.tableHeaderView = MovieHeaderView(frame: self.tableView.frame, movie: self.movie, delegate: self)
        self.tableView.reloadDataWithAnimation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch StoryboardSegue.Main(rawValue: segue.identifier!)! {
        case .playVideo:
            if let key = sender as? String {
                let controller = segue.destination as! PlayerViewController
                controller.key = key
            }
        default:
            break
        }
    }
}

extension MovieViewController: StatefulViewController {
    
    func hasContent() -> Bool {
        return self.isLoaded
    }
}

extension MovieViewController: PlayVideoDelegate {
    func didClickPlayVideo(url: URL) {
        if let key = self.movie.movie.trailer {
            self.performSegue(withIdentifier: StoryboardSegue.Main.playVideo.rawValue, sender: key)
        }
    }
}

extension MovieViewController: FavoriteDelegate {
    func didSelectFavorite(isSelected: Bool) {
        Movie.favorite(self.movie.id, isSelected: isSelected)
        self.movie = MovieViewModel.getMovie(self.movie.id)
        FeedbackAlert(body: isSelected ? L10n.Movie.saved:L10n.Movie.removed, target: self).showSuccess()
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.movie.numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isLoaded {
            return self.movie.numerOfRows(section)
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch MovieSectionType.type(indexPath.section) {
        case .overview:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SynopsisTableViewCell.self)
            cell.bind(movie: self.movie)
            return cell
        case .images:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ImagesCollectionView.self)
            cell.images = self.movie.images
            return cell
        case .videos:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: VideoTableViewCell.self)
            cell.bind(movie: movie, delegate: self)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.movie.heighForRow(indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.movie.heightForFooter(section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.movie.heightForHeader(section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView.numberOfRows(inSection: section) > 0 {
            return MovieSectionView(frame: self.tableView.frame, title: self.movie.titleOfSection(section))
        }
        return nil
    }
}

extension MovieViewController: ResponseDelegate {
    func success(type: ResponseType) {
        switch type {
        case .movie:
            self.isLoaded = true
            self.movie = MovieViewModel.getMovie(self.movie.id)
            self.configureUI()
            self.endLoading()
        case .videos, .images:
            self.movie = MovieViewModel.getMovie(self.movie.id)
            self.tableView.reloadDataWithAnimation()
        default:
            break
        }
    }
    
    func failure(type: ResponseType, errorType: APIError) {
        self.isLoaded = false
        self.errorView = EmptyView(frame: view.frame, emptyMessage: errorType.description)
        self.endLoading(animated: true, error: errorType.error, completion: nil)
    }
}
