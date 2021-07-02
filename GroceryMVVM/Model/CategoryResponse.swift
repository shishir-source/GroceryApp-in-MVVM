//
//  CategoryResponse.swift
//  GroceryMVVM
//
//  Created by Shishir Ahmed on 2/7/21.
//

import Foundation

struct CategoryResponse: Codable {
    let categories: [Category]
    enum CodingKeys: String, CodingKey {
        case categories = "data"
    }
}

struct Category: Codable {
    var id, category, description, img: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case category = "categry"
        case description = "catedes"
        case img = "cateimg"
    }
}

// MARK: - GroceryResponse
struct GroceryResponse: Codable {
    var groceries: [Grocery]

    enum CodingKeys: String, CodingKey {
        case groceries = "CateFilterData"
    }
}

// MARK: - CateFilterDatum
struct Grocery: Codable {
    var id, name, category, cateFilterDatumDescription: String
    var price, mrp, quantity, quantitytype: String
    var image, homepage, offer, instock: String

    enum CodingKeys: String, CodingKey {
        case id, name, category
        case cateFilterDatumDescription = "description"
        case price, mrp, quantity, quantitytype, image, homepage, offer, instock
    }
}
