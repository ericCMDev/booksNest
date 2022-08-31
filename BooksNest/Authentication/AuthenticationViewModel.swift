//
//  AuthenticationViewModel.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 10/4/22.
//

import Foundation


final class AuthenticationViewModel: ObservableObject {
   
    //info sobre @Published
    //para las propiedades de user y el error, así sabremos cuando el user se valida correctamente o le da error
    //posteriormente graccias a guardar estas propiedades podremos realizar acciones como por ejemplo:
    //si se ha validado correctamente, saltar a la vista principal de la app y si da error no entrar y mostrar el error por pantalla para que el user vea la info.
    
    @Published var user: User?
    @Published var messageError: String?
    @Published var linkedAccounts: [LinkedAccounts] = []
    @Published var showAlert: Bool = false
    @Published var isAccountLinked: Bool = false
    
    
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository = AuthenticationRepository()){
        self.authenticationRepository = authenticationRepository
        getCurrentUser()
    }
    
    
    func getCurrentUser() {
        
        self.user = authenticationRepository.getCurrentUser()
    }
    
    func createNewUser(email: String, password: String) {
        
        authenticationRepository.createNewUser(email: email,
                                               password: password) { [weak self] result in
            
            switch result {
                
            case .success(let user):
                
                self?.user =  user
                
            case .failure(let error):
                
                self?.messageError =  error.localizedDescription
                
            }
            
        }
        
    }
    
    func login(email: String, password: String) {
        
        authenticationRepository.login(email: email,
                                       password: password) { [weak self] result in
            
            switch result {
                
            case .success(let user):
                
                self?.user =  user
                
            case .failure(let error):
                
                self?.messageError =  error.localizedDescription
                
            }
       }
    }
    
    func loginFacebook() {
        
        authenticationRepository.loginFacebook() { [weak self] result in
            
            switch result {
                
            case .success(let user):
                
                self?.user =  user
                
            case .failure(let error):
                
                self?.messageError =  error.localizedDescription
                
            }
       }
    }
    
    
    func logout()
    {
        do{
            try authenticationRepository.logout()
            self.user = nil
        } catch {
            print("Error cerrando sesión")
        }
        
    }
    
    func getCurrentProvider() {
        
       linkedAccounts = authenticationRepository.getCurrentProvider()
       print ("User provider \(linkedAccounts)")
        
    }
    
    //comprovar quin està loguejat per habilitar / deshabilitar el de vinculació
    
    func isEmailAndPasswordLinked() -> Bool {
        
        linkedAccounts.contains(where: {$0.rawValue == "password"})
        
    }
    
    func isFacebookLinked() -> Bool {
        
        linkedAccounts.contains(where: {$0.rawValue == "facebook.com"})
        
    }
    
    func linkFacebook() {
        authenticationRepository.linkFacebook { [weak self] isSuccess in
            print("Linked Facebook \(isSuccess.description)")
            self?.isAccountLinked = isSuccess
            self?.showAlert.toggle()
            self?.getCurrentProvider()
        }
    }
    
    func linkEmailAndPassword(email: String, password:String) {
        authenticationRepository.linkEmailAndPassword(email: email, password: password) { [weak self] isSuccess in
            
            print("Linked email and password \(isSuccess.description)")
            self?.isAccountLinked = isSuccess
            self?.showAlert.toggle()
            self?.getCurrentProvider()
            
        }
    }
}
