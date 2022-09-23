//
//  DetailsRouter.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 17.09.2022.
//

import Foundation
class DetailspageRouter : PresenterToRouterDetaySayfaProtocol {
    static func createModule(ref: DetailsVC) {
        ref.detaySayfaPresenterNesnesi = DetaySayfaPresenter()
        ref.detaySayfaPresenterNesnesi?.detaySayfaInteractor = DetailspageInteractor()
    }
}
