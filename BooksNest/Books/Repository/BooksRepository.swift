//
//  BooksRepository.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 26/4/22.
//

import Foundation
import AVFAudio


final class BooksRepository {
    private let booksDatasource: BooksDatasource
    private let dataBookDatasource: DataBookDatasource
    
    init(booksDatasource: BooksDatasource = BooksDatasource(),
         dataBookDatasource: DataBookDatasource = DataBookDatasource()) {
        self.booksDatasource = booksDatasource
        self.dataBookDatasource = dataBookDatasource
    }
    
    func createManuallyBook(title: String, author: String, ilustrator: String,
                          description: String, year: Int, genre: String, userNotes: String,
                            language: String, bookLocation: String?, bookState: String?, cover: String?, completionBlock: @escaping (Result<BookModel, Error>) -> Void) {
        

        
        dataBookDatasource.getBookData(title: title, author: author, ilustrator: ilustrator, description: description, year: year, genre: genre, userNotes: userNotes, language: language, bookLocation: bookLocation, bookState: bookState, cover: cover) { [weak self] result in
            
            switch result {
            case .success(let bookModel):
                self?.booksDatasource.createNewBook(book: bookModel, completionBlock: completionBlock)
            case .failure(let error):
                completionBlock(.failure(error))
            }
        }
        
    }
    
    func update(book: BookModel) {
        booksDatasource.updateBook(book: book)
    }
    
    func delete(book: BookModel) {
        booksDatasource.delete(book: book)
    }
    
    func getAllBooks(completionBlock: @escaping (Result<[BookModel], Error>) -> Void) {
        
        booksDatasource.getAllBooks(completionBlock: completionBlock)
    }
    
    func getAllLibraryBooks(completionBlock: @escaping (Result<[BookModel], Error>) -> Void) {
        
        booksDatasource.getAllLibraryBooks(completionBlock: completionBlock)
    }
    func getWishListBooks(completionBlock: @escaping (Result<[BookModel], Error>) -> Void) {
        
        booksDatasource.getWishListBooks(completionBlock: completionBlock)
    }
    
    func getReadenBooks(completionBlock: @escaping (Result<[BookModel], Error>) -> Void) {
        
        booksDatasource.getReadenBooks(completionBlock: completionBlock)
    }
    
    func getToReadBooks(completionBlock: @escaping (Result<[BookModel], Error>) -> Void) {
        
        booksDatasource.getToReadBooks(completionBlock: completionBlock)
    }
    
    func getReadingBooks(completionBlock: @escaping (Result<[BookModel], Error>) -> Void) {
        
        booksDatasource.getReadingBooks(completionBlock: completionBlock)
    }
    
    func getLoanedBooks(completionBlock: @escaping (Result<[BookModel], Error>) -> Void) {
        
        booksDatasource.getLoanedBooks(completionBlock: completionBlock)
    }
}
