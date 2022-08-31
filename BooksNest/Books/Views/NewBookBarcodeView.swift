//
//  NewBookBarcodeView.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 7/5/22.
//

import SwiftUI
import SDWebImageSwiftUI
struct NewBookBarcodeView: View {
    
    @ObservedObject var booksViewModel: BooksViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var isPrensented = false
    @State private var isbn: String?
    @State private var showingAlert = false
    @State private var foundBooks: BooksAPI?
    @State var ilustrator: String = ""
    @State var userNotes: String = ""
    @State var bookLocation: String? = "InLibrary"
    @State var bookState: String? = ""
    
    
    var body: some View {
        NavigationView {
            
            VStack {
                HStack {
                    Button("Cancelar") {
                        dismiss()
                    }.frame(width: 260, alignment: .leading)
                        .padding(.vertical, 10)
        
                    Button(action: {
                        
                        self.isPrensented.toggle()
        
                    }) {
                        Label("", systemImage: "barcode.viewfinder")
                            .font(.title)
                            .padding()
                            
                    }.sheet(isPresented: $isPrensented)
                    {
                        DismissView()
                        BarCodeScanner(isbn: $isbn, foundBooks: $foundBooks)
                    }
                }
                Group{
                    Text("Escanea el nuevo libro")
                        .bold()
                        .font(.system(.title, design: .rounded))
                        .multilineTextAlignment(.center)
                        .tint(.primary)
                }
                    
                Form {
                    Section(header: Text("Información principal de tu nuevo libro")) {
                        
                        Text("ISBN: \(isbn ?? "")")
                        WebImage(url: URL(string: foundBooks?.items.first?.volumeInfo.imageLinks?.thumbnail ?? "https://i.imgur.com/sJ3CT4V.gif")).resizable().frame(width: 120, height: 130).cornerRadius(30)
                        Text("Título: \(foundBooks?.items.first?.volumeInfo.title ?? "")")
                        Text("Subtítulo: \(foundBooks?.items.first?.volumeInfo.subtitle ?? "")")
                        Text("Autor@: \(foundBooks?.items.first?.volumeInfo.authors?.first ?? "")")
                        TextField("Ilustrador: ", text: $ilustrator)
                        Text("Género: \(foundBooks?.items.first?.volumeInfo.categories?.first ?? "")")
                        Text("Idioma: \(foundBooks?.items.first?.volumeInfo.language ?? "")")
                        Text("Fecha publicación: \(foundBooks?.items.first?.volumeInfo.publishedDate ?? "")")
                        
                         
                    }
                    Section(header: Text("Descripción del libro")) {
                        Text("\(foundBooks?.items.first?.volumeInfo.description ?? "")")
                                .frame( height: 100)
                    }
                   
                        Section(header: Text("Notas")) {
                    TextEditor(text: $userNotes)
                            .frame( height: 80)
                        }
                    

                }
                Button(action: {
                    let title = foundBooks?.items.first?.volumeInfo.title ?? ""
                    let subtitle = foundBooks?.items.first?.volumeInfo.subtitle ?? ""
                    let author = foundBooks?.items.first?.volumeInfo.authors?.first ?? ""
                    let titleAndSubtitle = ("\(title) " + "\(subtitle)")
                    let strYear = foundBooks?.items.first?.volumeInfo.publishedDate ?? "0"
                    let intYear = Int(strYear)
                    let cover = foundBooks?.items.first?.volumeInfo.imageLinks?.thumbnail ?? "https://i.imgur.com/sJ3CT4V.gif"
                    if(title != "" && author != "" ){
                    booksViewModel.createManuallyBook(title: titleAndSubtitle,
                                                      author: foundBooks?.items.first?.volumeInfo.authors?.first ?? "Autor No encontrado",
                                                      ilustrator: ilustrator,
                                                      description: foundBooks?.items.first?.volumeInfo.description ?? "Sin descripción",
                                                      year: intYear ?? 0,
                                                      genre: foundBooks?.items.first?.volumeInfo.categories?.first ?? "Género no encontrado",
                                                      userNotes: userNotes,
                                                      language: foundBooks?.items.first?.volumeInfo.language ?? "Idioma no encontrado",
                                                      bookLocation: bookLocation,
                                                      bookState: bookState, cover: cover)
                        
                        dismiss()
                    }
                    else {
                        showingAlert = true
                    }
                    
                        
                        
    
                    
                    //HomeView(authenticationViewModel: authenticationViewModel, booksViewModel: booksViewModel)
                }, label: {
                    Label("Guardar", systemImage: "square.and.arrow.down.fill")
                        
                })
                .foregroundColor(.black)
                .frame(minWidth:0, maxWidth: 150)
                .padding(.all, 10)
                .background(Color(.systemGreen))
                .cornerRadius(50)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("No hay datos"), message: Text("Debe rellenar el título, autor@ y género"), dismissButton: .default(Text("Aceptar")))
                }
                if(booksViewModel.messageError != nil) {
                Text(booksViewModel.messageError!)
                        .bold()
                        .foregroundColor(.red)
                }
                
            }.navigationBarHidden(true)
            .alert(isPresented: $showingAlert) {
                    Alert(title: Text("No hay datos"), message: Text("Debe rellenar el título, autor@ y género"), dismissButton: .default(Text("Aceptar")))
                }
    }
}
}
struct NewBookBarcodeView_Previews: PreviewProvider {
    static var previews: some View {
        NewBookBarcodeView(booksViewModel: BooksViewModel())
    }
}
