//
//  ResultCell.swift
//  AnimalAPP
//
//  Created by hui liu on 12/8/20.
//

import UIKit
import SDWebImage

class ResultCell: UICollectionViewCell {
        
    var result: Result! {
        didSet {
            titleLabel.text = result.title
            scoreLabel.text = "\(result.score)"
            iconImageView.sd_setImage(with: URL(string: result.imageURL))
        }
    }
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "anime NAME?"
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "8.88?"
        return label
    }()
    
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        contentView.isUserInteractionEnabled = true
        
        let infoStackView = VerticalStackView(arrangedSubviews: [titleLabel, scoreLabel])
        addSubview(infoStackView)
        
        let horizontalStackView = UIStackView(arrangedSubviews: [iconImageView,infoStackView, getButton])
        horizontalStackView.spacing = 12
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .fillProportionally
        horizontalStackView.isUserInteractionEnabled = true
        
        
        addSubview(horizontalStackView)
        horizontalStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
