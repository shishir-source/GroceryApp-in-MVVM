//
//  ProductCell.swift
//  GroceryMVVM
//
//  Created by Shishir Ahmed on 2/7/21.
//


import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {
    //MARK: - Properties
    
    static let cellName = "QuickCashCell"
    
    private let titlLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "this is title"
        label.textColor = .white
        return label
    }()
    
    private let descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "this is title"
        label.textColor = .white
        return label
    }()
    
    private let backImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    private let bottomView = UIView()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(backImage)
        backImage.anchorView(top: self.topAnchor, left: self.leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        addSubview(bottomView)
        bottomView.anchorView( left: self.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20 ,height: self.height / 3)
        bottomView.backgroundColor = .black
        bottomView.alpha = 0.5
        
        bottomView.addSubview(titlLabel)
        
        titlLabel.anchorView(top: bottomView.topAnchor, paddingTop: 10)
        titlLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
        
        bottomView.addSubview(descriptionLabel)
        descriptionLabel.anchorView(top: titlLabel.bottomAnchor)
        descriptionLabel.centerX(inView: titlLabel)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
    }
    //MARK: - Setup Layouts
    //MARK: - Helper Functions
    
    func configure(usingViewModel viewModel: CategoryViewModel ) {
        titlLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        let url = URL(string: "http://shishir.xyz/grocery/admin/itemimg/\(viewModel.image)")
        backImage.kf.setImage(with: url)
    }
    
    //MARK: - Selectors

}

