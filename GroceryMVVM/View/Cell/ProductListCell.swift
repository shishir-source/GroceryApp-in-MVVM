//
//  ProductListCell.swift
//  GroceryMVVM
//
//  Created by Shishir Ahmed on 2/7/21.
//


import UIKit
import Kingfisher

class ProductListCell: UICollectionViewCell {
    //MARK: - Properties
    
    static let cellName = "ProductListCell"
    
    private let titlLabel : UILabel = {
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
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(backImage)
        backImage.anchorView(top: self.topAnchor, left: self.leftAnchor, bottom: bottomAnchor, width: self.height)
        
        addSubview(titlLabel)
        titlLabel.anchorView(left: backImage.rightAnchor, paddingLeft: 20)
        titlLabel.centerY(inView: backImage)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
    }
    //MARK: - Setup Layouts
    //MARK: - Helper Functions
    
    func configure(usingViewModel viewModel: GroceryItemViewModel ) {
        titlLabel.text = viewModel.title
        let url = URL(string: "http://shishir.xyz/grocery/admin/itemimg/\(viewModel.image)")
        backImage.kf.setImage(with: url)
    }
    
    //MARK: - Selectors

}
