//
//  ErrorModel.swift
//  CoreDataWithTabBar
//
//  Created by Nitin Bhatia on 16/02/23.
//

import Foundation


struct ErrorModel : Error {
    
    let code : Int?
    let message : String?
    let domain : String?
    
}
