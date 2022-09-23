//
//  BaskerRouter.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 17.09.2022.
//

import Foundation
class SepetSayfaRouter : PresenterToRouterSepetSayfaProtocol {
    static func createModule(ref: BasketVC) {

        let presenter : ViewToPresenterSepetSayfaProtocol & InteractorToPresenterSepetSayfaProtocol = SepetSayfaPresenter()

        ref.sepetSayfaPresenterNesnesi = presenter

        ref.sepetSayfaPresenterNesnesi?.sepetSayfaInteractor = SepetSayfaInteractor()
        ref.sepetSayfaPresenterNesnesi?.sepetSayfaView = ref

        ref.sepetSayfaPresenterNesnesi?.sepetSayfaInteractor?.sepetSayfaPresenter = presenter

    }
}
