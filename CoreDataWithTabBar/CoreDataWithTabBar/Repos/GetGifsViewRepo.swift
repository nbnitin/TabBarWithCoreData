//
//  GetGifsViewRepo.swift
//  CoreDataWithTabBar
//
//  Created by Nitin Bhatia on 17/02/23.
//

import Foundation


class GetGifsViewRepo {
    func getGifData(url:String,completion : @escaping(_ data:AllGifModel?)->Void) {
        
        APICaller.shared.CallApi(url: url, method: .get, completionHandler: {res in
            if let data = res.data {
                let obj = try? JSONDecoder().decode(AllGifModel.self, from: data)
                completion(obj)
                return
            }
        })
        
        
    }
}
