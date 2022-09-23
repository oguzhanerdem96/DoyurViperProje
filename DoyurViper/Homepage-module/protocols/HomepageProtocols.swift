//
//  HomepageProtocols.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 17.09.2022.
//

import Foundation
protocol ViewToPresenterAnasayfaProtocol {
    var anasayfaInteractor:PresenterToInteractorAnasayfaProtocol? {get set}
    var anasayfaView:PresenterToViewAnasayfaProtocol? {get set}
    
    func yemekleriYukle()
    func ara(aramaKelimesi:String)
    
}

protocol PresenterToInteractorAnasayfaProtocol {
    var anasayfaPresenter:InteractorToPresenterAnasayfaProtocol? {get set}
    
    func tumYemekleriAl()
    func yemekAra(aramaKelimesi:String)
    
}

protocol InteractorToPresenterAnasayfaProtocol {
    func presenteraVeriGonder(yemekListesi:Array<TumYemekler>)
}

protocol PresenterToViewAnasayfaProtocol {
    func vieweVeriGonder(yemekListesi:Array<TumYemekler>)
}

protocol PresenterToRouterAnasayfaProtocol {
    static func createModule(ref:HomePageVC)
}
