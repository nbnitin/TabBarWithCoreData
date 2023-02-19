//
//  GetGifsViewModel.swift
//  CoreDataWithTabBar
//
//  Created by Nitin Bhatia on 17/02/23.
//

import Foundation

class GetGifsViewModel {
    private let repo = GetGifsViewRepo()
    
    func getAllGifs() async -> AllGifModel? {
        await withCheckedContinuation({continuity in
            repo.getGifData(url: EndPoints.getAllGifs.getURL, completion: {res in
                continuity.resume(returning: res)
            })
        })
    }
}
