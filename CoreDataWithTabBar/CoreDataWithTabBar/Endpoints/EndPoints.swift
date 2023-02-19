//
//  EndPoints.swift
//  CoreDataWithTabBar
//
//  Created by Nitin Bhatia on 17/02/23.
//

import Foundation

let API_KEY : String = "R554pM79ToHRGJXnvAWRioINvyWtc40b"

enum EndPoints : String {
    case getAllGifs = "https://api.giphy.com/v1/gifs/trending?offset=0&limit=20&api_key="
    
    var getURL : String {
        switch self {
        case .getAllGifs:
            return EndPoints.getAllGifs.rawValue + API_KEY
        }
    }
}
