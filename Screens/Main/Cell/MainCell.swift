//
//  MainCell.swift
//  Rest API
//
//  Created by Egor Syrtcov on 5/8/21.
//

import UIKit

final class MainCell: UITableViewCell {
    
    static let identifier = "MainCell"
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    
    private var urlString: String = ""
    
    static func nib() -> UINib {
        return UINib(nibName: "MainCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCellWithValuesOf(_ movie: Movie) {
        updateUI(title: movie.title,
                 releaseDate: movie.year,
                 rating: movie.rate,
                 overview: movie.overview,
                 poster: movie.posterImage)
    }
    
    private func updateUI(title: String?,
                          releaseDate: String?,
                          rating: Double?,
                          overview: String?,
                          poster: String?) {
        self.movieTitle.text = title
        self.movieYear.text = Date.convertDataFormater(releaseDate)
        guard let rate = rating else { return }
        self.movieRate.text = String(rate)
        self.movieOverview.text = overview
        
        guard let posterString = poster else { return }
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        
        guard let posterImageURL = URL(string: urlString) else {
            self.moviePoster.image = UIImage(named: "noImageAvailable")
            return
        }
        
        //Before we download the image we clear out the old one
        self.moviePoster.image = nil
        getImageDataFrom(url: posterImageURL)
        
    }
    
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Empty Data")
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self?.moviePoster.image = image
                }
            }
        }.resume()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
