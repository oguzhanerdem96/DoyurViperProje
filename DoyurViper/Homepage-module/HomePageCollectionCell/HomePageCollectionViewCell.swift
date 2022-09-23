//
//  HomePageCollectionViewCell.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 20.09.2022.
//

import UIKit
import Kingfisher
class HomePageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var homePageImageView: UIImageView!
    @IBOutlet weak var homePageLbl: UILabel!
    
    @IBOutlet weak var homePagePrİceLbl: UILabel!
    
    @IBOutlet weak var hucre: UIView!
    
    
    
    
    
    
    
    
    
    
    func resimGoster(resimAdi:String){
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(resimAdi)"){
           
            
            DispatchQueue.main.async {
                self.homePageImageView.kf.setImage(with: url)
                
            }
            
        }
        
    }
}

