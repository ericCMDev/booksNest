//
//  HomeView.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 10/4/22.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @ObservedObject var booksViewModel: BooksViewModel = BooksViewModel()
    
    var body: some View {
        NavigationView{
            
            VStack() {
                
                HStack() {
                    NavigationLink(destination: LibraryView(booksViewModel: booksViewModel)){
                        CardsHomeView(imageName: "books.vertical.fill", imageColor:.orange, name: "Biblioteca")
                            
                    }
                    NavigationLink(destination: WishListView(booksViewModel: booksViewModel)){
                        CardsHomeView(imageName: "bookmark.fill", imageColor:.blue, name: "Wish List")
                        
                    }
                    
                }.padding(.vertical, -10)
                HStack {
                  
                    NavigationLink(destination: ReadingView(booksViewModel: booksViewModel)){
                        CardsHomeView(imageName: "book.fill", imageColor: .red, name: "Leyendo")
                            
                        }
                    
                    NavigationLink(destination: ToReadView(booksViewModel: booksViewModel)){
                        CardsHomeView(imageName: "square.stack.3d.up.fill", imageColor: .purple, name: "Pendiente")
                        
                    }
                    
                }
                
                HStack {
                  
                    NavigationLink(destination: ReadenView(booksViewModel: booksViewModel)){
                        CardsHomeView(imageName: "checkmark.seal.fill", imageColor: .green, name: "Leído")
                        
                    }
                    
                    NavigationLink(destination: LoanedView(booksViewModel: booksViewModel)){
                        CardsHomeView(imageName: "person.badge.clock.fill", imageColor: .cyan, name: "Prestado")
                        
                    }
                    
                }
                .padding(.vertical, -10)
               
                    
               
                MenuView(authenticationViewModel: authenticationViewModel, booksViewModel: BooksViewModel())
                   
                
            }
            .navigationTitle("BooksNest")
            .padding()
            
            }
        
        }
    }


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(authenticationViewModel: AuthenticationViewModel())
    }
}
