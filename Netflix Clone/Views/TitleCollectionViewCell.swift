//
//  TitleCollectionViewCell.swift
//  Netflix Clone
//
//  Created by Alejandro on 4/26/22.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with model: MovieTitle){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.poster_path)") else {return}
        
        posterImageView.sd_setImage(with: url)
    }
    
}
