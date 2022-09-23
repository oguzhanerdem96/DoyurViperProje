//
//  LoginProtocols.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 17.09.2022.
//

import Foundation

protocol ViewToPresenterLoginProtocol
{
    var loginInteractor : PresenterToInteractorLoginProtocol? {get set}
    func loginUser(email : String, password : String )
}

protocol PresenterToInteractorLoginProtocol
{
    func login(email : String, password : String )
}

protocol PresenterToRouter
{
    static func createModule(ref:LoginVC)
}
