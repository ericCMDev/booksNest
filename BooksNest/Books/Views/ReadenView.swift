//
//  ReadenView.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 1/5/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReadenView: View {
    
    @ObservedObject var booksViewModel: BooksViewModel
    
    var body: some View {
        
        
            
            List {
                
                Text("Leídos")
                .font(.largeTitle)
                .bold()
                        ForEach(booksViewModel.books) { books in
                            VStack {
                                NavigationLink(destination: BookView(booksViewModel: booksViewModel, title: books.title, author: books.author, ilustrator: books.ilustrator, description: books.description, year: books.year, genre: books.genre, userNotes: books.userNotes, language: books.language, bookLocation: books.bookLocation, bookState: books.bookState, books: books))
                               {
                                
                                    HStack {
                                        
                                        WebImage(url: URL(string: books.cover ?? "https://i.imgur.com/sJ3CT4V.gif")).resizable().frame(width: 60, height: 80).cornerRadius(10)
                                        
                                        VStack{
                                           
                                            Text(books.title)
                                                .fontWeight(.bold)
                                                .frame(height: 50, alignment: .leading)
                                                .foregroundColor(.primary)
                                                .lineLimit(2)
                                                .padding(.horizontal)
                                                
                                            HStack {
                                            Image(systemName:"pencil")
                                                    .frame(alignment: .leading)
                                            Text(books.author)
                                                .font(.system(size: 15))
                                                
                                            }
                                            HStack {
                                            Image(systemName:"paintbrush.pointed")
                                            Text(books.ilustrator)
                                                .font(.system(size: 15))
                                            }
                
                                        }
                                        Spacer()
                                    }
                            }
                            
                        }
                }
            
            }.task {
                booksViewModel.getReadenBooks()
            }
    }
}

struct ReadenView_Previews: PreviewProvider {
    static var previews: some View {
        ReadenView(booksViewModel: BooksViewModel())
    }
}
