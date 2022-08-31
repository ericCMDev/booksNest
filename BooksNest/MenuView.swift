//
//  MenuView.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 14/4/22.
//

import SwiftUI

enum  MenuBookSheetView: String, Identifiable {
    
    //enumerador para identifcar si es login o nuevo registro
    
    case manual
    case scanning
    case search
    //case searching
    
    var id: String {
        return rawValue
    }
    
}


struct MenuView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @ObservedObject var booksViewModel: BooksViewModel
    @State private var showingAlert = false
    @State private var menuBookSheetView: MenuBookSheetView?
    
    //@State private var isbn: String?
    //@ObservedObject var foundBooks: Books

    
    var body: some View {
       
       
        VStack{
            Spacer()
       
                HStack {
                 
                       // ToolbarItemGroup(placement: .bottomBar) {
                            
                        NavigationLink(destination: LibraryView(booksViewModel: booksViewModel)) {
                                Image(systemName: "list.bullet")
                                .foregroundColor(Color.primary)
                                    .font(Font.largeTitle)
                        }.padding()
                     
                        NavigationLink(destination: LibraryView(booksViewModel: booksViewModel)) {
                            Image(systemName: "mappin")
                                .foregroundColor(Color.primary)
                                .font(Font.largeTitle)
                        }.padding()
                            
                        
                        Image(systemName: "plus.circle")
                        .onTapGesture {
                            showingAlert = true
                        }
                        .foregroundColor(Color.primary)
                        .font(Font.largeTitle)
                        .padding()
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Importante"), message: Text("Debe dejar pulsado unos segundos"), dismissButton: .default(Text("Aceptar")))
                        }
                        .contextMenu {
                            VStack {
                                Button(action:{
                                    menuBookSheetView = .manual
                                }){
                                    HStack{
                                        Text("Añadir manualmente")
                                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                        
                                    }
                                }
                                Button(action:{
                                    menuBookSheetView = .scanning
                                }){
                                    HStack{
                                        Text("Escanear")
                                        Image(systemName: "barcode.viewfinder")
                                        
                                    }
                                }
                                Button(action:{
                                    print("Buscar per internet")
                                    
                                }){
                                    HStack{
                                        Text("Buscar")
                                        Image(systemName: "magnifyingglass.circle")
                                        
                                    }
                                }
                            }
                        }
                        
                        NavigationLink(destination: SearchView(booksViewModel: booksViewModel)) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color.primary)
                                .font(Font.largeTitle)
                                
                        }.padding()
                        
                            
                    NavigationLink(destination: ConfigurationView(authenticationViewModel: authenticationViewModel)) {
                            Image(systemName: "gear")
                            .foregroundColor(Color.primary)
                            .font(Font.largeTitle)
                            
                            
                        }.padding()

                        
                        
                }
        }
        .sheet(item: $menuBookSheetView) { sheet in
            
            switch sheet {
                
            case .manual:
                NewBookManuallyView(booksViewModel: booksViewModel)
                
            case .scanning:
                
                NewBookBarcodeView(booksViewModel: booksViewModel)
               
             
            case .search:
                
                SearchView(booksViewModel: booksViewModel)
            }
        }
    }
            
        
        
        
        
    }


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(authenticationViewModel: AuthenticationViewModel(), booksViewModel: BooksViewModel())
    }
}
