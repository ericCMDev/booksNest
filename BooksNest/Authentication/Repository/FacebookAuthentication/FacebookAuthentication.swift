//
//  FacebookAuthentication.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 13/4/22.
//

import Foundation
import FacebookLogin

final class FacebookAuthentication {
    
    let loginManager = LoginManager()
    
    func loginFacebook(completionBlock: @escaping (Result<String, Error>) -> Void) {
        loginManager.logIn(permissions: ["email"],
                           from: nil) { loginManagerLoginResult, error in
            if let error = error {
                print("Error")
                completionBlock(.failure(error))
                return
            }
            let token = loginManagerLoginResult?.token?.tokenString
            completionBlock(.success(token ?? "Empty token"))
            
        }
    
    }
    
    func getAccessToken() -> String? {
        AccessToken.current?.tokenString
    }
    
    
}
