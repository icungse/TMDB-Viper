//
//  GenreListViewController.swift
//  TMDB-Viper
//
//  Created by Icung on 24/08/23.
//

import UIKit

class GenreListViewController: BaseViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var presenter: ViewToPresenterGenreListProtocol?
    var genres: Genres?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Genre"
        isLoading = true
        Task {
            await presenter?.updateView()
        }
        setupTableView()
    }
}

extension GenreListViewController {
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(GenreTableViewCell.self, forCellReuseIdentifier: "GenreTableViewCell")
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
    }
}


extension GenreListViewController: PresenterToViewGenreListProtocol {
    func showGenreList() {
        genres = presenter?.getGenreList()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.isLoading = false
            self.tableView.reloadData()
        }
    }
}

extension GenreListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres?.genres.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreTableViewCell", for: indexPath)
        (cell as? GenreTableViewCell)?.genreText = genres?.genres[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let genre = genres?.genres[indexPath.row].name else {
            return
        }
        
        let controller = MovieListRouter.createModule(with: genre)
        navigationController?.pushViewController(controller, animated: true)
    }
}
