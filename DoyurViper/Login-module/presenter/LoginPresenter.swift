//
//  LoginPresenter.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 17.09.2022.
//

import Foundation
class LoginPresenter : ViewToPresenterLoginProtocol
{
    var loginInteractor: PresenterToInteractorLoginProtocol?
    
    func loginUser(email: String, password: String) {
        loginInteractor?.login(email: email, password: password)
    }
    
}
