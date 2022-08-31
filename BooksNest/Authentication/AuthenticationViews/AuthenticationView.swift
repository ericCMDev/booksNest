//
//  ContentView.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 9/4/22.
//

import SwiftUI

enum  AuthenticationSheetView: String, Identifiable {
    
    //enumerador para identifcar si es login o nuevo registro
    
    case register
    case login
    
    var id: String {
        return rawValue
    }
    
}


struct AuthenticationView: View {
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var authenticationSheetView: AuthenticationSheetView?
    
    var body: some View {
        VStack {
            Image("loginBackground")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.4)
                .overlay(
                    Text("Iniciar sesión")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .padding(.bottom, 500)
                    
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 300, height: 370)
                        .foregroundColor(Color(.white))
                        .opacity(0.8)
                )
                .overlay(
                    Text("¿Ya tienes una cuenta?")
                        .font(.system(.title, design: .rounded))
                        .padding(.bottom, 250)
                    
                )
                .overlay(
                    Button {
                        authenticationSheetView = .login
                        
                    } label: {
                        Label("Entrar con tu email", systemImage: "envelope.fill")
                            .foregroundColor(.black)
                    }
                    .frame(minWidth:0, maxWidth: 200)
                    .padding()
                    .background(Color(.systemGray3))
                    .cornerRadius(50)
                    .padding(.top, -80)
                )
                .overlay(
                    Button {
                        authenticationViewModel.loginFacebook()
                        
                    } label: {
                        HStack{
                            
                            Image("facebookIcon")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Entrar con Facebook")
                                .foregroundColor(.black)
                            
                        }
                            
                    }
                    .frame(minWidth:0, maxWidth: 200)
                    .padding()
                    .background(Color(.systemGray3))
                    .cornerRadius(50)
                    .padding(.top, 50)
                )
               /* .overlay(
                    Button {
                        print("Login")
                        
                    } label: {
                        HStack{
                            
                            Image("googleIcon")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Entrar con Google")
                                .foregroundColor(.black)
                            
                        }
                    }
                    .frame(minWidth:0, maxWidth: 200)
                    .padding()
                    .background(Color(.systemGray3))
                    .cornerRadius(50)
                    .padding(.top, 210)
                    
                )*/
            
                .overlay(
                    HStack{
                        
                        Button {
                            
                            authenticationSheetView = .register
                            
                        } label: {
                            Text("¿No tienes una cuenta?")
                            Text("Regístrate")
                                .underline()
                                .bold()
                        }
                        .padding(.top, 480)
                        .tint(.black)
                    }
                    
                )
           
        }
        .sheet(item: $authenticationSheetView) { sheet in
            
            switch sheet {
                
            case .register:
                RegisterEmailView(authenticationViewModel: authenticationViewModel)
                
            case .login:
                LoginEmailView(authenticationViewModel: authenticationViewModel)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(authenticationViewModel: AuthenticationViewModel())
    }
}
