//
//  LoginInteractor.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 17.09.2022.
//

import Foundation
import FirebaseAuth
import Firebase
class LoginInteractor : PresenterToInteractorLoginProtocol
{
    func login(email: String, password: String) {
        let auth = Auth.auth()
        
        auth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            
        }
    }
    
    
}

