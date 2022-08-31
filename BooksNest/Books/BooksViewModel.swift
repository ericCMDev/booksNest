//
//  BooksViewModel.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 26/4/22.
//

import Foundation


final class BooksViewModel: ObservableObject {
    @Published var books: [BookModel] = []
    @Published var messageError: String?
    
    private let booksRepository: BooksRepository
    
    init(booksRepository: BooksRepository = BooksRepository()) {
        self.booksRepository = booksRepository
    }
    
   //create manually
    func createManuallyBook(title: String, author: String, ilustrator: String,
                       description: String, year: Int, genre: String, userNotes: String,
                            language: String, bookLocation: String?, bookState: String?, cover: String?) {
        
        booksRepository.createManuallyBook(title: title, author: author, ilustrator: ilustrator, description: description, year: year, genre: genre, userNotes: userNotes, language: language, bookLocation: bookLocation, bookState: bookState, cover: cover) { [weak self] result in
            
            switch result {
            case .success(let book):
                print("book \(book.title) added correctly")
                
            case .failure(let error):
                self?.messageError = error.localizedDescription
                
            }
        }
        
    }
  //updates
    func updateBookLocation(book: BookModel, bookLocation: String) {
        let updatedBook = BookModel(id: book.id, title: book.title, author: book.author, ilustrator: book.ilustrator, description: book.description, year: book.year, genre: book.genre, userNotes: book.userNotes, language: book.language, bookLocation: bookLocation, bookState: book.bookState, cover: book.cover)
        
        booksRepository.update(book: updatedBook)
    }
    
    func updateBookState(book: BookModel, bookLocation: String, bookState: String) {
        let updatedBook = BookModel(id: book.id, title: book.title, author: book.author, ilustrator: book.ilustrator, description: book.description, year: book.year, genre: book.genre, userNotes: book.userNotes, language: book.language, bookLocation: bookLocation, bookState: bookState, cover: book.cover)
        
        booksRepository.update(book: updatedBook)
    }
    
    func updateBookInfo(book: BookModel, title: String, author: String, ilustrator: String,
                        description: String, year: Int, genre: String, userNotes: String,
                        language: String) {
        let updatedBook = BookModel(id: book.id, title: title, author: author, ilustrator: ilustrator,
                                    description: description, year: year, genre: genre, userNotes: userNotes,
                                    language: language, bookLocation: book.bookLocation, bookState: book.bookState, cover: book.cover)
        
        booksRepository.update(book: updatedBook)
    }
    
    func deleteBook(book: BookModel){
        booksRepository.delete(book: book)
    }
    
    
    
    
    
    //funció get de tots els llibres de la app
    func getAllBooks() {
        booksRepository.getAllBooks { [weak self] result in
            
            switch result {
            case .success(let bookModels):
                self?.books = bookModels
                
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
            
        }
    }
    
    //función get de tots llibres de la biblioteca
    func getAllLibraryBooks() {
        booksRepository.getAllLibraryBooks { [weak self] result in
            
            switch result {
            case .success(let bookModels):
                self?.books = bookModels
                
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
            
        }
    }
    
    //función get de tots llibres de la wishList
    func getWishListBooks() {
        booksRepository.getWishListBooks{ [weak self] result in
            
            switch result {
            case .success(let bookModels):
                self?.books = bookModels
                
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
            
        }
    }
    
    //funció get de tots els llibres marcats com a llegits
    func getReadenBooks() {
        booksRepository.getReadenBooks{ [weak self] result in
            
            switch result {
            case .success(let bookModels):
                self?.books = bookModels
                
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
            
        }
    }
    
    //funció get de tots els llibres pendents de llegir
    func getToReadBooks() {
        booksRepository.getToReadBooks{ [weak self] result in
            
            switch result {
            case .success(let bookModels):
                self?.books = bookModels
                
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
            
        }
    }
    
    //funció get de tots els llibres que s'estan llegint
    func getReadingBooks() {
        booksRepository.getReadingBooks{ [weak self] result in
            
            switch result {
            case .success(let bookModels):
                self?.books = bookModels
                
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
            
        }
    }
    
    //funció get de tots els llibres prestats
    func getLoanedBooks() {
        booksRepository.getLoanedBooks{ [weak self] result in
            
            switch result {
            case .success(let bookModels):
                self?.books = bookModels
                
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
            
        }
    }
    
    
    
    
    
    
}
