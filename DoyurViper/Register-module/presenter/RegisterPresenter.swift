//
//  RegisterPresenter.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 17.09.2022.
//

import Foundation
class RegisterPresenter : ViewToPresenterRegisterProtocol
{
    var registerInteractor: PresenterToInteractorRegisterProtocol?
    
    func registerUser(email: String, password: String) {
        registerInteractor?.register(email: email, password: password)
    }
    
}
