//
//  HomepageRouter.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 17.09.2022.
//

import Foundation
class AnasayfaRouter : PresenterToRouterAnasayfaProtocol {
    static func createModule(ref: HomePageVC) {
        
        let presenter : ViewToPresenterAnasayfaProtocol & InteractorToPresenterAnasayfaProtocol = AnasayfaPresenter()
        
        
        ref.anasayfaPresenterNesnesi = presenter
      
        ref.anasayfaPresenterNesnesi?.anasayfaInteractor = AnasayfaInteractor()
        ref.anasayfaPresenterNesnesi?.anasayfaView = ref
        
        ref.anasayfaPresenterNesnesi?.anasayfaInteractor?.anasayfaPresenter = presenter
        
    }
}
