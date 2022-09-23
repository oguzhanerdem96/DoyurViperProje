//
//  LoginRouter.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 17.09.2022.
//

import Foundation
class LoginRouter : PresenterToRouter
{
    static func createModule(ref: LoginVC) {
        ref.loginPresenter = LoginPresenter()
        ref.loginPresenter?.loginInteractor = LoginInteractor()
    }
    
}

