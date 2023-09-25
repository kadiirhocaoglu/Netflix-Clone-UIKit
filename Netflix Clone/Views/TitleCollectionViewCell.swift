//
//  TitleCollectionViewCell.swift
//  Netflix Clone
//
//  Created by Kadir Hocaoğlu on 25.09.2023.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    let identifier = "TitleCollectionViewCell"
    
    
    private let posterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with model: String) {
        guard  let url: URL = URL(string: model) else {return}
        posterImageView.sd_setImage(with: url, completed: nil)
        
    }
    
}
