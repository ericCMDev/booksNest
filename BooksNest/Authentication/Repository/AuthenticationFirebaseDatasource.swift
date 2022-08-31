//
//  AuthenticationFirebaseDatasource.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 10/4/22.
//

import Foundation
import FirebaseAuth




final class AuthenticationFirebaseDatasource {
    
    
    private let facebookAuthentication = FacebookAuthentication()
    
    func getCurrentUser() -> User? {
        
        guard let email = Auth.auth().currentUser?.email else {
            return nil
        }
        return .init(email: email)
    }
    
    
    
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void){
        
        Auth.auth().createUser(withEmail: email, password: password) { AuthDataResult, error in
            
            if let error = error {
                print("Error al crear el usuario \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = AuthDataResult?.user.email ?? "No email"
            print("Nuevo usuario creado con la info \(email)")
            completionBlock(.success(.init(email: email)))
        }
    }
    
    func login(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void){
        
        Auth.auth().signIn(withEmail: email, password: password) { AuthDataResult, error in
            
            if let error = error {
                print("Error al hacer login \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = AuthDataResult?.user.email ?? "No email"
            print("Usuario \(email) logueado correctamente")
            completionBlock(.success(.init(email: email)))
        }
    }
    
    
    func loginWithFacebook(completionBlock: @escaping (Result<User, Error>) -> Void){
        
        facebookAuthentication.loginFacebook { result in
            switch result {
            case .success(let accessToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
                Auth.auth().signIn(with: credential) { authDataResult, error in
                    if let error = error {
                        print("Error creating user \(error.localizedDescription)")
                        completionBlock(.failure(error))
                        return
                    }
                    let email = authDataResult?.user.email ?? "No email"
                    print("New user created with info \(email)")
                    completionBlock(.success(.init(email: email)))

                }
                
            case .failure(let error):
                print("Error iniciando sesión con Facebook \(error.localizedDescription)")
                completionBlock(.failure(error)) 
                
            }
            
        }
        
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
    
    
    func currentProvider() -> [LinkedAccounts]{
        guard let currentUser = Auth.auth().currentUser else {
            return []
        }
        let linkedAccounts = currentUser.providerData.map { userInfo in
            
            LinkedAccounts(rawValue: userInfo.providerID)
            
        }.compactMap{ $0 } //netejar els valors nil
        return linkedAccounts
    }
    
    func linkFacebook(completionBlock: @escaping (Bool) -> Void){
        facebookAuthentication.loginFacebook { result in
            switch result {
            case .success(let accessToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
                Auth.auth().currentUser?.link(with: credential, completion: { authDataResult, error in
                    if let error = error {
                        print("Error linking a new user \(error.localizedDescription)")
                        completionBlock(false)
                        return
                    }
                    let email = authDataResult?.user.email ?? "No email"
                    print("New user linked with email \(email)")
                    completionBlock(true)
                })
            case .failure(let error):
                print("Error linking a new user \(error.localizedDescription)")
                completionBlock(false)
                
            }
        }
    }
    
    
    func getCurrentCredential() -> AuthCredential? {
        guard let providerId = currentProvider().last else {
            return nil
        }
        switch providerId {
        case .facebook:
            guard let accessToken = facebookAuthentication.getAccessToken() else {
                return nil
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
            return credential
        case .emailAndPassword, .unknown:
            return nil
        }
    }
    
    func linkEmailAndPassword(email: String, password: String, completionBlock: @escaping(Bool) -> Void) {
        guard let credential = getCurrentCredential() else {
            print("Error Creating Credential")
            completionBlock(false)
            return
        }
        Auth.auth().currentUser?.reauthenticate(with: credential, completion: { authDataResult, error in
            
            if let error = error {
                print("Error reauthenticating a user \(error.localizedDescription)")
                completionBlock(false)
                return
            }
            
            let emailAndPasswordCredential = EmailAuthProvider.credential(withEmail: email, password: password)
            
            
            Auth.auth().currentUser?.link(with: emailAndPasswordCredential, completion: { authDataResult, error in
                if let error = error {
                    print("Error linking a new user \(error.localizedDescription)")
                    completionBlock(false)
                    return
                }
                let email = authDataResult?.user.email ?? "No email"
                print("New user linked with email \(email)")
                completionBlock(true)
            })
        })
        
    }
    
}
