//
//  Main.swift
//  Rest API
//
//  Created by Egor Syrtcov on 4/28/21.
//

import UIKit

final class Main: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        loadPopularMoviesData()
    }
    
    private func setupTableView() {
        tableView.register(MainCell.nib(), forCellReuseIdentifier: MainCell.identifier)
        tableView.rowHeight = 120
    }
    
    private func loadPopularMoviesData() {
        viewModel.fetchPopularMovie { [weak self] in
            self?.tableView.delegate = self
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }
}

extension Main: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier, for: indexPath) as? MainCell else { return UITableViewCell() }
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        return cell
    }
}
