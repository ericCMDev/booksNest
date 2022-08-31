//
//  BookAPIModel.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 7/5/22.
//

import Foundation

struct BooksAPI: Decodable {
    let items: [BookItem]
}

struct BookItem: Decodable {
    
    let id: String
    let volumeInfo: VolumeInfo
}



struct VolumeInfo: Decodable {
    
    let title: String?
    let subtitle: String?
    let authors: [String]?
    let publishedDate: String?
    let description: String?
    let language: String?
    let categories: [String]?
    let imageLinks: Cover?
    
}

struct Cover: Decodable {
    
    let thumbnail: String?
    
    
}

