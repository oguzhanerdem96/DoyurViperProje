//
//  DetailsVC.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 16.09.2022.
//

import UIKit
import Kingfisher
import Firebase


class DetailsVC: UIViewController {
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var detailPriceLbl: UILabel!
    @IBOutlet weak var detailAzaltLbl: UIView!
    @IBOutlet weak var detailNumara: UILabel!
    @IBOutlet weak var detailsArttır: UIButton!
    
    
    
    
    let userDefault = UserDefaults.standard
    var yemek:TumYemekler?
    var detaySayfaPresenterNesnesi:ViewToPresenterDetaySayfaProtocol?
    
    var adet = 1
    var toplam = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 255/255, green: 229/225, blue: 204/255, alpha: 1)
        if let y = yemek {
            detailsImageView.image = UIImage(named: y.yemek_resim_adi!)
            detailLbl.text = "\(y.yemek_adi!)"
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(y.yemek_resim_adi!)") {
                DispatchQueue.main.async {
                    self.detailsImageView.kf.setImage(with: url)
                }

}
            detailPriceLbl.text = "\(y.yemek_fiyat!) TL"

}
        DetailspageRouter.createModule(ref: self)
        self.tabBarController?.tabBar.isHidden = true
}
override func viewWillDisappear(_ animated: Bool) {
    self.tabBarController?.tabBar.isHidden = false
    }
    

    @IBAction func detailAddBtn(_ sender: Any) {
        if let k = detailNumara.text,let y = yemek{
            detaySayfaPresenterNesnesi?.adet(yemek_adi: y.yemek_adi!, yemek_resim_adi: y.yemek_resim_adi!, yemek_fiyat: y.yemek_fiyat!, yemek_siparis_adet: k, kullanici_adi: "\(Auth.auth().currentUser?.email ?? "")")
            
        }
        if let y = yemek {
            print("\(y.yemek_adi!) - \(detailNumara.text!) adet \(detailPriceLbl.text!) fiyatla sepete eklendi.")
        }
        
        // home ekranına geri dönüldü
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func detailAzaltBtn(_ sender: Any) {
        
        adet -= 1
        
        if let b = yemek?.yemek_fiyat! {
            if let a = Int(b){
                toplam = a * adet
                detailPriceLbl.text = "\(toplam) TL"
            }
    }
        detailNumara.text = String(adet)
    }
    @IBAction func detailArttırBtn(_ sender: Any) {
        adet += 1
        
        if let b = yemek?.yemek_fiyat! {
            if let a = Int(b){
                toplam = a * adet
                detailPriceLbl.text = "\(toplam) TL"
            }
    }
        detailNumara.text = String(adet)
}
}

