//
//  Book.swift
//  BookShow
//
//  Created by Vido Valianto on 3/1/19.
//  Copyright © 2019 Vido Valianto. All rights reserved.
//

import Foundation

struct Book : Codable {
    var title : String!
    var imageLinks : String!
    var authors : String!
    var averageRating : String!
    
    mutating func hasNilField() {
        if([title] as [Any?]).contains(where: { $0 == nil}){
            self.title = "Not Known"
        }
//        if([imageLinks] as [Any?]).contains(where: { $0 == nil}){
//            self.imageLinks = "Not Known"
//        }
        if([authors] as [Any?]).contains(where: { $0 == nil}){
            self.authors = "Not Known"
        }
        if([averageRating] as [Any?]).contains(where: { $0 == nil}){
            self.averageRating = "0"
        }
        
    }
    func allNilField() -> Bool {
        return((([title] as [Any?]).contains(where: { $0 == nil})) &&
            ([imageLinks] as [Any?]).contains(where: { $0 == nil}) &&
            ([authors] as [Any?]).contains(where: { $0 == nil}) &&
            ([averageRating] as [Any?]).contains(where: { $0 == nil}))
        
    }
    
}




