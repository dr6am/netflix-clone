//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Alejandro on 4/26/22.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    
    static let identifier = "TitleTableViewCell"
   
    
    private let titlePosterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        return label
    }()
    private let playTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(titlePosterUIImageView)
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(playTitleButton)
        
        
        applyConstraints()
    }
    
    private func applyConstraints() {
         let titlePosterUIImageViewConstraints = [
            titlePosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 0),
            titlePosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titlePosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8),
            titlePosterUIImageView.widthAnchor.constraint(equalToConstant: 100),

         ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlePosterUIImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: playTitleButton.trailingAnchor, constant: 50),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let playTitleButtonConstraints = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(titlePosterUIImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(playTitleButtonConstraints)
    }

    
    public func configure(with model: TitleViewModel){
        print(model.posterUrl)
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterUrl)") else {return}
        titlePosterUIImageView.sd_setImage(with: url)
        titleLabel.text = model.titleName
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
