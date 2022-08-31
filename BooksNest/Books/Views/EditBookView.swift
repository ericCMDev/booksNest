//
//  EditBookView.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 10/5/22.
//

import SwiftUI

struct EditBookView: View {
    
    @ObservedObject var booksViewModel: BooksViewModel
    
    @State private var showingAlert = false
    @Environment(\.dismiss) private var dismiss
    @State var title: String
    @State var author: String
    @State var ilustrator: String
    @State var description: String
    @State var year: Int
    @State var genre: String
    @State var userNotes: String
    @State var language: String
    @State var cover: String
    var books: BookModel?
    
    var body: some View {
        
        VStack {
            
            DismissView()
            Group{
                Text("Editar libro")
                    .bold()
                    .font(.system(.title, design: .rounded))
                    .multilineTextAlignment(.center)
                    .tint(.primary)
            }
                
            Form {
                Section(header: Text("Información principal de tu nuevo libro")) {
                  
                    TextField("Título del libro", text: $title)
                    TextField("Author@s", text: $author)
                    TextField("Ilustrador@s", text: $ilustrator)
                    TextField("Género principal", text: $genre)
                    TextField("Idioma", text: $language)
                        
                    
                    TextField("Año de publicación", value: $year, formatter: NumberFormatter())
                }
                Section(header: Text("Descripción del libro")) {
                    TextEditor(text: $description)
                            .frame( height: 100)
                }
               
                    Section(header: Text("Notas")) {
                        TextEditor(text: $userNotes)
                        .frame( height: 80)
                    }
                
                    
            }
            Button(action: {
                if(title != "" && author != "" && genre != ""){
                    booksViewModel.updateBookInfo(book: books!, title: title, author: author, ilustrator: ilustrator, description: description, year: year, genre: genre, userNotes: userNotes, language: language)
                    dismiss()
                    
                }
                else{
                    
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
    }
        
    }
}
struct EditBookView_Previews: PreviewProvider {
    static var previews: some View {
        EditBookView(booksViewModel: BooksViewModel(), title: "", author: "", ilustrator: "", description: "", year: 0, genre: "", userNotes: "", language: "", cover: "")
    }
}
