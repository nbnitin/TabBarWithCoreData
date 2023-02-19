//
//  AllGifModel.swift
//  CoreDataWithTabBar
//
//  Created by Nitin Bhatia on 17/02/23.
//

import Foundation

struct AllGifModel : Decodable {
    let data : [DataImages]?
}

struct DataImages : Decodable {
    let images : Images?
}

struct Images: Decodable {
    let fixedHeightSmall : ImagesInfo?
    
    enum CodingKeys : String, CodingKey {
        case fixedHeightSmall = "fixed_height_small"
    }
    
    init(from decoder: Decoder) throws {
        let deco = try? decoder.container(keyedBy: CodingKeys.self)
        self.fixedHeightSmall = try? deco?.decodeIfPresent(ImagesInfo.self, forKey: .fixedHeightSmall)
    }
}

struct ImagesInfo : Decodable {
    let height,width,size,url : String?
}
