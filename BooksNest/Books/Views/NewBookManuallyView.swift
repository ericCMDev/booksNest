//
//  NewBookManuallyView.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 3/5/22.
//

import SwiftUI

struct NewBookManuallyView: View {
    
    @ObservedObject var booksViewModel: BooksViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showingAlert = false
    
    @State var title: String = ""
    @State var author: String = ""
    @State var ilustrator: String = "Sin ilustrador"
    @State var description: String = ""
    @State var year: Int = 2022
    @State var genre: String = ""
    @State var userNotes: String = ""
    @State var language: String = "ESP"
    @State var bookLocation: String? = "InLibrary"
    @State var bookState: String? = ""
    var years = Array(1900...2022)
    @State var cover: String? = ""
    
    var body: some View {
        NavigationView {
            
            VStack {
                Button("Cancelar") {
                            dismiss()
                }.frame(width: 350, alignment: .leading)
                    .padding(.vertical, 10)
                
                Group{
                    Text("Añadir nuevo libro")
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
                        Picker("Idioma", selection: $language, content: {
                            Text("Español").tag("ESP")
                            Text("English").tag("ENG")
                            Text("Català").tag("CAT")
                        })
                        
                        //Text("Año de publicación")
                        Picker("Año de publicación", selection: $year) {
                            ForEach(years, id: \.self) {
                                Text("\($0.formatted(.number.grouping(.never)))")
                            }
                        }//.pickerStyle(WheelPickerStyle())
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
                    booksViewModel.createManuallyBook(title: title, author: author, ilustrator: ilustrator, description: description, year: year, genre: genre, userNotes: userNotes, language: language, bookLocation: bookLocation, bookState: bookState, cover: cover)
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
                
            }.navigationBarHidden(true)
        }
    }
    
        
}

struct NewBookManuallyView_Previews: PreviewProvider {
    static var previews: some View {
        NewBookManuallyView(booksViewModel: BooksViewModel())
    }
}


