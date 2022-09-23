//
//  RegisterRouter.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 17.09.2022.
//

import Foundation
class RegisterRouter : PresenterToRouterRegisterProtocol
{
    static func createModule(ref: RegisterViewController) {
        ref.registerPresneterObject = RegisterPresenter()
        ref.registerPresneterObject?.registerInteractor = RegisterInteractor()
    }
}
