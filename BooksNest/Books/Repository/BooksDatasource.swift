//
//  BooksDatasource.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 26/4/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseFirestoreSwift
import UIKit
import SwiftUI

struct BookModel: Decodable, Identifiable, Encodable {
    @DocumentID var id: String?
    let title: String
    let author: String
    let ilustrator: String
    let description: String
    let year: Int
    let genre: String
    let userNotes: String
    let language: String
    let bookLocation: String?
    let bookState: String?
    let cover: String?
 
}


final class BooksDatasource {
    private let database = Firestore.firestore()
    private let collection = "books"
    
    
    //funcio per crear nou llibre
    func createNewBook(book: BookModel, completionBlock: @escaping (Result<BookModel, Error>) -> Void){
        do {
        _ = try database.collection(collection).addDocument(from: book)
            completionBlock(.success(book))
        } catch {
            completionBlock(.failure(error))
        }
    }
    //funció per actualizar info
    func updateBook(book: BookModel) {
        guard let documentId = book.id else {
            return
        }
        do {
            _ = try database.collection(collection).document(documentId).setData(from: book)
        }catch {
            print("Error updating book in our database")
        }
    }
    
    //query per eliminar llibre
    
    func delete(book: BookModel) {
        guard let documentId = book.id else {
            return
        }
        database.collection(collection).document(documentId).delete()
    }
    
    
    //query de tots els llibres
    func getAllBooks(completionBlock: @escaping (Result<[BookModel], Error>) -> Void) {
        database.collection(collection)
            .addSnapshotListener { query, error in
                if let error = error {
                    print("Error getting all the books \(error.localizedDescription)")
                    completionBlock(.failure(error))
                    return
                }
                guard let documents = query?.documents.compactMap({ $0 }) else {
                    completionBlock(.success([]))
                    return
                }
                let books = documents.map { try? $0.data(as: BookModel.self) }
                    .compactMap { $0 }
                completionBlock(.success(books))
            }
    }
    
    //query de tots els llibres de la biblioteca
    func getAllLibraryBooks(completionBlock: @escaping (Result<[BookModel], Error>) -> Void) {
        database.collection(collection).whereField("bookLocation", isEqualTo: "InLibrary")
            .addSnapshotListener { query, error in
                if let error = error {
                    print("Error getting all the books \(error.localizedDescription)")
                    completionBlock(.failure(error))
                    return
                }
                guard let documents = query?.documents.compactMap({ $0 }) else {
                    completionBlock(.success([]))
                    return
                }
                let books = documents.map { try? $0.data(as: BookModel.self) }
                    .compactMap { $0 }
                completionBlock(.success(books))
                
             /*   let storageRef = Storage.storage().reference(withPath: "covers/ESDLA.jpg")
                storageRef.getData(maxSize: 4 * 1024 * 1024) { data, error in
                    
                    if let error = error {
                        print("Error recuperant imatge \(error.localizedDescription)")
                        return
                    }
                    if let data = data {
                        let image = UIImage(data: data)
                    }
                }*/
            }
    }
    
    func getWishListBooks(completionBlock: @escaping (Result<[BookModel], Error>) -> Void) {
        database.collection(collection).whereField("bookLocation", isEqualTo: "InWishList")
            .addSnapshotListener { query, error in
                if let error = error {
                    print("Error getting all the books \(error.localizedDescription)")
                    completionBlock(.failure(error))
                    return
                }
                guard let documents = query?.documents.compactMap({ $0 }) else {
                    completionBlock(.success([]))
                    return
                }
                let books = documents.map { try? $0.data(as: BookModel.self) }
                    .compactMap { $0 }
                completionBlock(.success(books))
            }
    }
    
    //query dels llibres de la biblioteca llegits
    func getReadenBooks(completionBlock: @escaping (Result<[BookModel], Error>) -> Void) {
        database.collection(collection).whereField("bookLocation", isEqualTo: "InLibrary").whereField("bookState", isEqualTo: "Readen")
            .addSnapshotListener { query, error in
                if let error = error {
                    print("Error getting all the books \(error.localizedDescription)")
                    completionBlock(.failure(error))
                    return
                }
                guard let documents = query?.documents.compactMap({ $0 }) else {
                    completionBlock(.success([]))
                    return
                }
                let books = documents.map { try? $0.data(as: BookModel.self) }
                    .compactMap { $0 }
                completionBlock(.success(books))
            }
    }
    //query de tots els llibres de la biblioteca pendents de llegir
    func getToReadBooks(completionBlock: @escaping (Result<[BookModel], Error>) -> Void) {
        database.collection(collection).whereField("bookLocation", isEqualTo: "InLibrary").whereField("bookState", isEqualTo: "ToRead")
            .addSnapshotListener { query, error in
                if let error = error {
                    print("Error getting all the books \(error.localizedDescription)")
                    completionBlock(.failure(error))
                    return
                }
                guard let documents = query?.documents.compactMap({ $0 }) else {
                    completionBlock(.success([]))
                    return
                }
                let books = documents.map { try? $0.data(as: BookModel.self) }
                    .compactMap { $0 }
                completionBlock(.success(books))
            }
    }
    
    //query de tots els llibres de la biblioteca que s'estan llegint
    func getReadingBooks(completionBlock: @escaping (Result<[BookModel], Error>) -> Void) {
        database.collection(collection).whereField("bookLocation", isEqualTo: "InLibrary").whereField("bookState", isEqualTo: "Reading")
            .addSnapshotListener { query, error in
                if let error = error {
                    print("Error getting all the books \(error.localizedDescription)")
                    completionBlock(.failure(error))
                    return
                }
                guard let documents = query?.documents.compactMap({ $0 }) else {
                    completionBlock(.success([]))
                    return
                }
                let books = documents.map { try? $0.data(as: BookModel.self) }
                    .compactMap { $0 }
                completionBlock(.success(books))
            }
    }
    
    //query de tots els llibres de la biblioteca que estan prestats
    func getLoanedBooks(completionBlock: @escaping (Result<[BookModel], Error>) -> Void) {
        database.collection(collection).whereField("bookLocation", isEqualTo: "InLibrary").whereField("bookState", isEqualTo: "Loaned")
            .addSnapshotListener { query, error in
                if let error = error {
                    print("Error getting all the books \(error.localizedDescription)")
                    completionBlock(.failure(error))
                    return
                }
                guard let documents = query?.documents.compactMap({ $0 }) else {
                    completionBlock(.success([]))
                    return
                }
                let books = documents.map { try? $0.data(as: BookModel.self) }
                    .compactMap { $0 }
                completionBlock(.success(books))
            }
    }
    
   
    
}


