//
//  SearchMovieTableViewCell.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/07/20.
//

import UIKit

class SearchMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageVIew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    func configureCell(data: Movie) {
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.text = data.title
        releaseLabel.text = "\(data.releaseDate) | \(data.runtime)분 | \(data.rate)점"
        overViewLabel.text = data.overview
        overViewLabel.numberOfLines = 0
    }
}
