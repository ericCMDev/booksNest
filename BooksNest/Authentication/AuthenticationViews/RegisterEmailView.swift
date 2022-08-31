//
//  RegisterEmailView.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 10/4/22.
//

import SwiftUI

struct RegisterEmailView: View {
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""
    
    var body: some View {
        VStack{
            
            DismissView()
                
            
            Group {
                Text("Bienvenid@ a")
                Text("BooksNest")
                    .bold()
            }
            .padding(.horizontal, 8)
            .font(.system(.largeTitle, design: .rounded))
            .multilineTextAlignment(.center)
            .tint(.primary)
            
            Group{
                Text("Regístrate para poder acceder y guardar todos tus libros en una app")
                    .padding(.top, 2)
                    .padding(.bottom, 5)
                    .multilineTextAlignment(.center)
                TextField("Escribe tu cuenta de correo", text: $textFieldEmail)
                SecureField("Escribe tu contraseña", text: $textFieldPassword)
                    .padding(.bottom, 5)
                Button("Regístrate"){
                    authenticationViewModel.createNewUser(email: textFieldEmail,
                                                         password: textFieldPassword)
                }
                .padding()
                .frame(minWidth:0, maxWidth: 150)
                .foregroundColor(.black)
                .background(Color(.systemGray3))
                .cornerRadius(50)
                
                if let messageError = authenticationViewModel.messageError {
                    
                    Text(messageError)
                        .bold()
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.red)
                        .padding()
                
                }
                
                
            }
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal, 64)
            Spacer()
        }
    }
}

struct RegisterEmailView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterEmailView(authenticationViewModel: AuthenticationViewModel())
    }
}
