//
//  GroceryService.swift
//  GroceryMVVM
//
//  Created by Shishir Ahmed on 2/7/21.
//

import UIKit
import Alamofire

class GroceryService {
    static let shared = GroceryService()
    private init() {}
    
    enum Endpoints {
        static let base = "http://shishir.xyz/grocery/app"
        static let token = "aa6ba6c6f4f4fd5e88c18f285a0168bc2a20f67d9de11062f5421ba77c90c1c5aa6ba6c6f4f4fd5e88c18f285a0168bc2a20f67d9de11062f5421ba77c90c1c5"
        
        case getGroceryCategories
        case getGroceries
        
        var stringValue: String {
            switch self {
            case .getGroceryCategories:
                return Endpoints.base+"/getcategory"
            case .getGroceries:
                return Endpoints.base+"/categoryfilter"
            }
        }
        
        var url: URL {
            return URL(string: stringValue) ?? URL(string: Endpoints.base)!
        }
    }
}

extension GroceryService: GroceriesAPI {
    
    
    func fetchCategories(success: @escaping CategoriesClosure, failure: @escaping ErrorClosure) {
        
        let headers: HTTPHeaders = [
            "APNWEJET-API-KEY": "connectWEJET2k20"
        ]
        
        let parameters: Parameters = [
            "token": Endpoints.token
        ]
        AF.request(Endpoints.getGroceryCategories.url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: CategoryResponse.self) { (response) in
                switch response.result{
                case .success(let result):
                    success(200, result.categories)
                case .failure(let error):
                    failure("Error fetching Categories: \(error)")
                }
            }
    }
    
    func fetchGroceries(categoryId: String , success: @escaping GroceriesClosure, failure: @escaping ErrorClosure) {
        let headers: HTTPHeaders = [
            "APNWEJET-API-KEY": "connectWEJET2k20"
        ]
        
        let parameters: Parameters = [
            "token": Endpoints.token,
            "category": categoryId
        ]
        
        AF.request(Endpoints.getGroceries.url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: GroceryResponse.self) { (response) in
                switch response.result{
                case .success(let result):
                    success(200, result.groceries)
                case .failure(let error):
                    failure("Error fetching Categories: \(error)")
                }
            }

    }
    
}
