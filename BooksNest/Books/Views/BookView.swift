//
//  BookView.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 24/4/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookView: View {
    
    enum  EditSheetView: String, Identifiable {
        
        case edit
        
        
        var id: String {
            return rawValue
        }
        
    }
    
    @State private var editSheetView: EditSheetView?
    
    @ObservedObject var booksViewModel: BooksViewModel
 
    @State var title: String
    @State var author: String
    @State var ilustrator: String
    @State var description: String
    @State var year: Int
    @State var genre: String
    @State var userNotes: String
    @State var language: String
    @State var bookLocation: String?
    @State var bookState: String?
     var books: BookModel?
    //@State var whereIsBook: String = ""
   // @State var buttonColor: Color
    @State var selected = false
    @State var cover: String?
    var body: some View {
       
            VStack {
                VStack {
                    RoundedRectangle(cornerRadius: 0)
                        .opacity(0.8)
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity, maxHeight: 320, alignment: .top)
                        
                }.overlay(

                VStack {
                    HStack {
                        Group {
                            Button {
                                editSheetView = .edit
                            } label: {
                                Image(systemName: "pencil")
                                    .foregroundColor(.primary)
                            }
                            .padding(.all, 11)
                            .background(Color(.systemGray4))
                            .cornerRadius(50)
                            .frame(width: 300, height: 30, alignment: .trailing)
                            
                            Button {
                                booksViewModel.deleteBook(book: books!)
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundColor(.primary)
                            }
                            .padding(.all, 8)
                            .background(Color(.red))
                            .cornerRadius(50)
                        }
                        
                    }
                    
                    HStack {
                        Button(action: {
                            
                            booksViewModel.updateBookLocation(book: books!, bookLocation: "InLibrary")
                        }, label: {
                            Label("Biblioteca", systemImage: "books.vertical.fill")
                                .foregroundColor(.primary)
                        })
                        .frame(minWidth:0, maxWidth: 110)
                        .padding(.all, 8)
                        .background(Color.orange)
                        .cornerRadius(50)
                        
                        
                        
                        Button {
                            booksViewModel.updateBookLocation(book: books!, bookLocation: "InWishList")
                        } label: {
                            Label("WishList", systemImage: "bookmark.fill")
                                .foregroundColor(.primary)
                        }
                        .frame(minWidth:0, maxWidth: 110)
                        .padding(.all, 8)
                        .background(Color(.systemCyan))
                        .cornerRadius(50)
                        
                        
                    }
                    HStack {
                        
                        Button {
                            booksViewModel.updateBookState(book: books!, bookLocation: "InLibrary", bookState: "ToRead")
                        } label: {
                            Text("Pendiente")
                                .foregroundColor(.primary)
                        }
                        .frame(minWidth:0, maxWidth: 78)
                        .padding(.all, 8)
                        .background(Color(.systemGray3))
                        .cornerRadius(50)
                        
                        Button {
                            booksViewModel.updateBookState(book: books!, bookLocation: "InLibrary", bookState: "Reading")
                        } label: {
                            Text("Leyendo")
                                .foregroundColor(.primary)
                        }
                        .frame(minWidth:0, maxWidth: 70)
                        .padding(.all, 8)
                        .background(Color(.systemGray3))
                        .cornerRadius(50)
                        
                        Button {
                            booksViewModel.updateBookState(book: books!, bookLocation: "InLibrary", bookState: "Readen")
                        } label: {
                            Text("Leído")
                                .foregroundColor(.primary)
                        }
                        .frame(minWidth:0, maxWidth: 60)
                        .padding(.all, 8)
                        .background(Color(.systemGray3))
                        .cornerRadius(50)
                        
                        Button {
                            booksViewModel.updateBookState(book: books!, bookLocation: "InLibrary", bookState: "Loaned")
                        } label: {
                            Text("Prestado")
                                .foregroundColor(.primary)
                        }
                        .frame(minWidth:0, maxWidth: 70)
                        .padding(.all, 8)
                        .background(Color(.systemGray3))
                        .cornerRadius(50)
                    }
                    
                    Text(title)
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(.white)
                        .bold()
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .padding(.horizontal)
                    
                    WebImage(url: URL(string: cover ?? "https://i.imgur.com/sJ3CT4V.gif")).resizable().frame(width: 120, height: 160).cornerRadius(10)
                    
                    
                                        
                    Spacer()
                    
                })
                
                Spacer()
                Form {
                    
                    HStack {
                        HStack {
                            Image(systemName:"pencil")
                            Text(author)
                                .font(.system(.body, design: .rounded))
                                .bold()
                                .multilineTextAlignment(.leading)
                        }
                        .padding(.horizontal)
                        HStack {
                        Image(systemName:"paintbrush.pointed")
                            Text(ilustrator)
                                .font(.system(.body, design: .rounded))
                                .bold()
                                .multilineTextAlignment(.trailing)
                        }
                
                    }
                    Section {
                        HStack {
                            VStack {
                                Text("Idioma: ")
                                    .foregroundColor(.secondary)
                                Text(language)
                            }
                            VStack {
                                Text("Año de publicación: ")
                                    .foregroundColor(.secondary)
                                Text("\(year)")
                            }
                            VStack {
                                Text("Género principal: ")
                                    .foregroundColor(.secondary)
                                Text(genre)
                            }
                        }
                    }
                    Section {
                        VStack {
                            Text("Descripción: ")
                                .foregroundColor(.secondary)
                            Text(description)
                            
                        }
                    }
                    Section {
                        VStack {
                            Text("Notas: ")
                                .foregroundColor(.secondary)
                            Text(userNotes)
                            
                        }
                    }
                    
                }
                
                
            }.sheet(item: $editSheetView) { sheet in
                
                switch sheet {
                    
                case .edit:
                    //RegisterEmailView(authenticationViewModel: authenticationViewModel)
                    
                    EditBookView(booksViewModel: booksViewModel, title: title, author: author, ilustrator: ilustrator, description: description, year: year, genre: genre, userNotes: userNotes, language: language,  cover: cover ?? "" , books: books)
                    
                }
            }
            
        
                    
        }
        
    }


struct BookView_Previews: PreviewProvider {
    static var previews: some View {
       // BookView(booksViewModel: BooksViewModel(), title: "" )
        BookView(booksViewModel: BooksViewModel(), title: "", author: "", ilustrator: "", description: "", year: 0, genre: "", userNotes: "", language: "", bookLocation: "", bookState: "" )
    }
}


