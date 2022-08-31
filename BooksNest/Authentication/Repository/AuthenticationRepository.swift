//
//  AuthenticationRepository.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 10/4/22.
//

import Foundation

final class AuthenticationRepository{
    private let authenticationFirebaseDatasource: AuthenticationFirebaseDatasource
    init(authenticationFirebaseDatasource: AuthenticationFirebaseDatasource = AuthenticationFirebaseDatasource()){
        
        self.authenticationFirebaseDatasource = authenticationFirebaseDatasource
        
    }
    
    func getCurrentUser() -> User? {
        
        authenticationFirebaseDatasource.getCurrentUser()
    }
    
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        
        authenticationFirebaseDatasource.createNewUser(email: email,
                                                       password: password,
                                                       completionBlock: completionBlock)
        
    }
    
    func login(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        
        authenticationFirebaseDatasource.login(email: email,
                                               password: password,
                                               completionBlock: completionBlock)
        
    }
    
    
    func loginFacebook(completionBlock: @escaping (Result<User, Error>) -> Void) {
        
        authenticationFirebaseDatasource.loginWithFacebook(completionBlock: completionBlock)
        
    }
    
    
    
    
    func logout() throws
    {
       try authenticationFirebaseDatasource.logout()
    }
    
    func getCurrentProvider() -> [LinkedAccounts]{
        
        authenticationFirebaseDatasource.currentProvider()
        
    }
    
    func linkFacebook(completionBlock: @escaping (Bool) -> Void){
        authenticationFirebaseDatasource.linkFacebook(completionBlock: completionBlock)
    }
    
    
    func linkEmailAndPassword(email: String, password: String, completionBlock: @escaping (Bool) -> Void) {
        authenticationFirebaseDatasource.linkEmailAndPassword(email: email,
                                                              password: password,
                                                              completionBlock: completionBlock)
    }
}

