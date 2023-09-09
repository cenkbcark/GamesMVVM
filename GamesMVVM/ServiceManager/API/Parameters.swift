//
//  Parameters.swift
//  GamesMVVM
//
//  Created by Cenk Bahadır Çark on 10.09.2023.
//

import Foundation

enum Parameter {
    case id(String)
    
    var queryItem: URLQueryItem {
        switch self {
        case .id(let value):
            return URLQueryItem(name: "id", value: value)
        }
    }
}
