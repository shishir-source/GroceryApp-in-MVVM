//
//  ResourcesViewModel.swift
//  GroceryMVVM
//
//  Created by Shishir Ahmed on 2/7/21.
//

import Foundation

struct GroceryItemViewModel {
    let id: String
    let title: String
    let image: String
    let price: String
    
    init(using groceryModel: Grocery){
        self.id = groceryModel.id
        self.title =  groceryModel.name
        self.image = groceryModel.image
        self.price = groceryModel.price
    }
}

struct CategoryViewModel {
    let id: String
    let title: String
    let description: String
    let image: String
    
    init(using categoryModel: Category) {
        self.id = categoryModel.id
        self.title = categoryModel.category
        self.description = categoryModel.description
        self.image = categoryModel.img
    }
}
