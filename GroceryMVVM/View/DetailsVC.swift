//
//  DetailsVC.swift
//  GroceryMVVM
//
//  Created by Shishir Ahmed on 2/7/21.
//

import UIKit

class DetailsVC: UIViewController {
    
    //MARK: - Data properties
    var category: CategoryViewModel? {
        didSet{
            
            guard let cat = category else {return}
            let url = URL(string: "http://shishir.xyz/grocery/admin/itemimg/\(cat.image)")
            backImage.kf.setImage(with: url)
            
            //Fetch Data
            
            fetchData(id: cat.id)
        }
    }
    
    private var productVM = ProductVM()
    
    //MARK: - View Properties
    
    let button: UIButton = {
        let btn = UIButton()
        btn.setTitle("Go Back", for: .normal)
        btn.backgroundColor = .red
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private let backImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .clear
        return image
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.zero
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.clipsToBounds = true
        collection.backgroundColor = .clear
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        
        view.addSubview(backImage)
        backImage.anchorView(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 200)
        
        view.addSubview(collectionView)
        collectionView.anchorView(top: backImage.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductListCell.self, forCellWithReuseIdentifier: ProductListCell.cellName)
        
    }
    
    //MARK: - Setup Layouts
    //MARK: - Helper Functions
    //MARK: - Selectors
    
    @objc func gotoList() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Api Call
    
    private func fetchData(id: String) {
        
        productVM.getGroceries(categoryId: id, completion: { flag in
            if flag {
                self.productVM.groceries.bind {  [weak self] _ in
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                }
            }
        })
    }
    
}

extension DetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productVM.groceries.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCell.cellName, for: indexPath) as! ProductListCell
        cell.configure(usingViewModel: productVM.groceries.value![indexPath.row])
        cell.backgroundColor = .gray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width , height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    }
}

