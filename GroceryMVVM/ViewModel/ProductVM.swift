//
//  ProductVM.swift
//  GroceryMVVM
//
//  Created by Shishir Ahmed on 3/7/21.
//

import Foundation

class ProductVM {
    
    var categories: Observable<[CategoryViewModel]> = Observable([])
    var groceries: Observable<[GroceryItemViewModel]> = Observable([])
    
    func getCategories(completion: @escaping(_ flag: Bool) -> Void) {
        GroceryService.shared.fetchCategories { success, data in
            self.categories.value = data.compactMap({CategoryViewModel(using: $0)})
            completion(true)
        } failure: { failure in
            completion(false)
            print("failure", failure)
        }

    }
    
    func getGroceries(categoryId: String, completion: @escaping(_ flag: Bool) -> Void) {
        GroceryService.shared.fetchGroceries(categoryId: categoryId) { success, data in
            self.groceries.value = data.compactMap({GroceryItemViewModel(using: $0)})
            completion(true)
        } failure: { failure in
            completion(false)
        }

    }
}
