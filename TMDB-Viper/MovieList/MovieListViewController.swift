//
//  MovieListViewController.swift
//  TMDB-Viper
//
//  Created by Icung on 25/08/23.
//

import UIKit
import Combine

class MovieListViewController: BaseViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var genre: String
    private var page = 1
    private var movies: [Result] = []
    
    var presenter: ViewToPresenterMovieListProtocol?
    
    init(with genre: String) {
        self.genre = genre
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = genre
        setupTableView()
        loadMovies()
    }
}

extension MovieListViewController {
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: "MovieListTableViewCell")
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
    }
    
    private func loadMovies() {
        Task {
            await presenter?.updateView(genre: genre, page: page)
        }
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath)
        (cell as? MovieListTableViewCell)?.movie = movies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == movies.count {
            loadMovies()
        }
    }
}

extension MovieListViewController: PresenterToViewMovieListProtocol {
    func showMovieList() {
        isLoading = false
        guard let results = presenter?.getMovieList()?.results else {
            return
        }
        
        movies += results
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.tableView.reloadData()
            isLoading = false
        }
        page += 1
    }
}
