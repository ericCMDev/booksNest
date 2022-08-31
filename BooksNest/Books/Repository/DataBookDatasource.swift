//
//  DataBookDatasource.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 3/5/22.
//

import Foundation

enum CustomError: Error {
    case MissingData
    
}

final class DataBookDatasource {
    
    func getBookData(title: String, author: String, ilustrator: String?,
                     description: String, year: Int, genre: String, userNotes: String,
                     language: String, bookLocation: String?, bookState: String?, cover: String?, completionBlock: @escaping (Result<BookModel, Error>) -> Void) {
        
        let bookModel = BookModel(title: title, author: author, ilustrator: ilustrator ?? "", description: description, year: year, genre: genre, userNotes: userNotes, language: language, bookLocation: bookLocation ?? "InLibrary", bookState: bookState ?? "", cover: cover)
        
        completionBlock(.success(bookModel))
        
        }
        
    }
    
