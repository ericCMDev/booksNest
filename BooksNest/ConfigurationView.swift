//
//  ConfigurationView.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 13/4/22.
//

import SwiftUI

struct ConfigurationView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var expandVerificationWithEmailForm: Bool = false
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""
    
    var body: some View {
    
        VStack{
            
            
            Text("Configuración")
                .font(.system(.largeTitle, design: .rounded))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 18)
                .padding(.top, 30)
                
          
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .frame(width: 320, height: 150)
                .foregroundColor(Color(.systemGray2))
                .overlay(
                    VStack{
                        
                        Text("Usuario conectado: \(authenticationViewModel.user?.email ?? "No user")")
                            .multilineTextAlignment(.center)
                        Button("Cerrar sesión") {
                            authenticationViewModel.logout()
                            
                        }
                        .padding()
                    }
                )
                
                
          /*  RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .frame(width: 320, height: 150)
                .foregroundColor(Color(.systemGray2))
                .overlay(*/
                    VStack{
                       
                            
                        
                        Text("Vincular cuentas a la sesión actual")
                            .padding()
                        Button(action: {
                            expandVerificationWithEmailForm.toggle()
                            print("Vincular email y contraseña")
                        }, label: {
                            Label("Vincular con email", systemImage: "envelope.fill")
                        })
                        .disabled(authenticationViewModel.isEmailAndPasswordLinked())
                        if expandVerificationWithEmailForm {
                            
                            Group{
                                Text("Vincula tu cuenta de correo a esta sesión")
                                    .padding(.top, 2)
                                    .padding(.bottom, 5)
                                    .multilineTextAlignment(.center)
                                
                                    TextField("Escribe tu cuenta de correo", text: $textFieldEmail)
                                    .multilineTextAlignment(.center)
                                    SecureField("Escribe tu contraseña", text: $textFieldPassword)
                                        .padding(.bottom, 5)
                                        .multilineTextAlignment(.center)
                                        
                                
                                    Button("Aceptar"){
                                        authenticationViewModel.linkEmailAndPassword(email: textFieldEmail, password: textFieldPassword)
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
                        }
                        
                        Button(action: {
                            authenticationViewModel.linkFacebook()
                            
                        }, label: {
                            HStack{
                                
                                Image("facebookIcon")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("Vincular a Facebook")
                                    
                                
                            }
                                
                        })
                        .disabled(authenticationViewModel.isFacebookLinked())
                        .padding()
                    }
                    
               // )
                .padding()
            Spacer()
            
        }.task {
            authenticationViewModel.getCurrentProvider()
        }
        .alert(authenticationViewModel.isAccountLinked ? "¡Cuenta vinculada!" : "Error", isPresented: $authenticationViewModel.showAlert) {
            Button("Aceptar"){
                print("Dismiss alert")
                if authenticationViewModel.isAccountLinked {
                    expandVerificationWithEmailForm = false
                }
            }
        } message: {
            Text(authenticationViewModel.isAccountLinked ? "✅ Cuenta vinculada correctamente" : "❌ Error al vincular cuentas")
        }

    }
}


struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView(authenticationViewModel: AuthenticationViewModel())
    }
}
