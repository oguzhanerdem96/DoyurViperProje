//
//  ProfilRouter.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 17.09.2022.
//

import Foundation
class ProfileRouter : PresenterToRouterProfileProtocol
{
    static func createModule(ref: ProfileVC) {
        
        let presenter = ProfilePresenter()
        ref.profilePresenterObject = presenter
        ref.profilePresenterObject?.profileInteractor = ProfileInteractor()
        ref.profilePresenterObject?.profileView = ref
        ref.profilePresenterObject?.profileInteractor?.profilePresenter = presenter
    
    }
    
}

