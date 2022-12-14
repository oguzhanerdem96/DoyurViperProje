//
//  RegisterInteractor.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 17.09.2022.
//

import Foundation
import Firebase
import FirebaseAuth


class RegisterInteractor : PresenterToInteractorRegisterProtocol
{
    func register(email: String, password: String) {
        let auth = Auth.auth()
        auth.createUser(withEmail: email, password: password) { (authresult, error) in
            
            if let user = authresult?.user
            {
                print(user)
            }else
            {
                print("User can't enter.")
            }
        }
        
    }
    
}
