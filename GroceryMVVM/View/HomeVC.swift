//
//  HomeVC.swift
//  GroceryMVVM
//
//  Created by Shishir Ahmed on 2/7/21.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: - Data Properties
    
    private var productVM = ProductVM()
    
    //MARK: - View Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Grocery With MVVM"
        
        view.addSubview(collectionView)
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.size.height - 100).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.cellName)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Fetch Data
        
        fetchData()
    }

    //MARK: - Setup Layouts
    //MARK: - Helper Functions
    //MARK: - Selectors
    
    //MARK: - Api Call
    
    private func fetchData() {
        
        productVM.getCategories { flag in
            if flag {
                self.productVM.categories.bind {  [weak self] _ in
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    
}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productVM.categories.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.cellName, for: indexPath) as! ProductCell
        cell.configure(usingViewModel: productVM.categories.value![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
        return CGSize(width: collectionView.frame.size.width / 2 - 20, height: collectionView.frame.size.width / 2 - 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailsVC()
        vc.category = productVM.categories.value![indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
