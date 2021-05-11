//
//  MovieViewModel.swift
//  Rest API
//
//  Created by Egor Syrtcov on 4/28/21.
//

import Foundation

final class MovieViewModel {
    
    private let apiService = ApiService()
    private var popularMovie = [Movie]()
    
    func fetchPopularMovie(completion: @escaping () -> ()) {
        
        apiService.getPopularMoviesData { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.popularMovie = listOf.movies
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return popularMovie.count != 0 ? popularMovie.count : 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Movie {
        return popularMovie[indexPath.row]
    }
}
