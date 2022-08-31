//
//  SearchView.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 16/5/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchView: View {
    @ObservedObject var booksViewModel: BooksViewModel
    @State var search = ""
    
    var body: some View {
        
        List {
            Text("Buscar libro")
            .font(.largeTitle)
            .bold()
            ForEach(booksViewModel.books.filter{(self.search.isEmpty ? true : $0.title.localizedStandardContains(self.search))}, id: \.id) { books in
               
               
                NavigationLink(destination: BookView(booksViewModel: booksViewModel, title: books.title, author: books.author, ilustrator: books.ilustrator, description: books.description, year: books.year, genre: books.genre, userNotes: books.userNotes, language: books.language, bookLocation: books.bookLocation, bookState: books.bookState, books: books)) {
                
                        VStack {
                                HStack {
                                    
                                    WebImage(url: URL(string: books.cover ?? "No cover")).resizable().frame(width: 60, height: 80).cornerRadius(10)
                                    
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
        }
        .task {
            booksViewModel.getAllBooks()
            
        }
        .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always))
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(booksViewModel: BooksViewModel())
    }
}
