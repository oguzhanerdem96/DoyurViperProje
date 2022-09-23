//
//  BasketVC.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 16.09.2022.
//

import UIKit
import Firebase
import Kingfisher



class BasketVC: UIViewController {

    @IBOutlet weak var userCardTextField: UITextField!
    @IBOutlet weak var userCardTextView: UITextView!
    @IBOutlet weak var BasketTableView: UITableView!
    @IBOutlet weak var PriceLbl: UILabel!
    var basketCell : BasketTableViewCell?
    var adet = 1
    var yemek:TumYemekler?
    var toplamSepet = 0
    var textToplam : Int = 0
    var toplam : Int = 0
    var sepetSayfaPresenterNesnesi:ViewToPresenterSepetSayfaProtocol?
    var yemekler = [SepetYemekler]()
    let userDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        BasketTableView.delegate = self
        BasketTableView.dataSource = self
        
        SepetSayfaRouter.createModule(ref: self)
    
    
    }
   
    
    @IBAction func odemeBtn(_ sender: Any) {
        print("\(PriceLbl.text!) ile sepet onaylandı. ")
        toggleNavigation()
    }
    override func viewWillAppear(_ animated: Bool) {
        sepetSayfaPresenterNesnesi?.yemekleriAl(kullanici_adi:"\(Auth.auth().currentUser?.email ?? "")")
        get_total()
        
    }
    @IBAction func deleteBarBtn(_ sender: Any) {
        toggleDeleteAll()

    }
    func silBarButton(){
        for yemek in yemekler {
            sepetSayfaPresenterNesnesi?.sil(sepet_yemek_id: yemek.sepet_yemek_id!, kullanici_adi: yemek.kullanici_adi!)
        }
    }
    
    func get_total(){
        var total = 0

        for yemek in yemekler {
            total += Int(yemek.yemek_siparis_adet!)! * Int(yemek.yemek_fiyat!)!
        
        }
        PriceLbl.text = "\(String(total)) TL"
        
    }
    
    @objc func cellDeleteBtn(sender: UIButton) {
        let index = IndexPath(row: sender.tag, section: 0)
        print(index.row)
        let yemek = yemekler[index.row]
        
        let alert = UIAlertController(title: "Do you want to delete '\(yemek.yemek_adi!)' in the cart?", message: "", preferredStyle: .alert)
        let tamamAction = UIAlertAction(title: "Delete \(yemek.yemek_adi!)", style: .destructive){ [weak self] action in
            self!.sepetSayfaPresenterNesnesi?.sil(sepet_yemek_id: yemek.sepet_yemek_id!, kullanici_adi: yemek.kullanici_adi!)
        }
        alert.addAction(tamamAction)
        let iptalAction = UIAlertAction(title: "Cancel", style: .cancel){ action in
            
        }
        alert.addAction(iptalAction)
        present(alert, animated: true, completion: nil)
        
        
    }

    
    
    
}
extension BasketVC : PresenterToViewSepetSayfaProtocol {
    func vieweVeriGonder(sepetYemeklerListe:Array<SepetYemekler>) {
        self.yemekler = sepetYemeklerListe
        
        DispatchQueue.main.async {
            self.BasketTableView.reloadData()
            self.get_total()
        }
    }

}

extension BasketVC : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemekler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let yemek = yemekler[indexPath.row]
        let hucre = tableView.dequeueReusableCell(withIdentifier: "BasketCell", for: indexPath) as! BasketTableViewCell
        hucre.selectionStyle = .none
        
        hucre.delegate = self
        
        hucre.UrunAdi.text = yemek.yemek_adi!
        hucre.SayiBtn.text = "\(yemek.yemek_siparis_adet!)"

        
        
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                hucre.UrunImage.kf.setImage(with: url)
            }
        }
        
        toplam = Int(yemek.yemek_siparis_adet!)! * Int(yemek.yemek_fiyat!)!
        hucre.UrunFiyat.text = "\(toplam) TL"
        
        
        

        hucre.CıkarBtn.addTarget(self, action: #selector(cellDeleteBtn), for: .touchUpInside)
        hucre.CıkarBtn.tag = indexPath.row

        

        hucre.selectionStyle = .none
        
        return hucre
        
        
    }
    
    
    
    // Hücredeki veriyi silme
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Delete"){ (contextualAction,view,bool) in
            
            let yemek = self.yemekler[indexPath.row]
            
            
            let alert = UIAlertController(title: "\(yemek.yemek_adi!) delete from cart?", message: "", preferredStyle: .alert)
            let iptalAction = UIAlertAction(title: "Cancel", style: .cancel){ action in
                
            }
            alert.addAction(iptalAction)
            let evetAction = UIAlertAction(title: "Yes", style: .destructive){ action in
                self.sepetSayfaPresenterNesnesi?.sil(sepet_yemek_id: yemek.sepet_yemek_id!, kullanici_adi: yemek.kullanici_adi!)
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }



}
extension BasketVC {
   
    
    func toggleNavigation() {
        let alert = UIAlertController(title: "Your order has been confirmed.", message: "Thank you for your order.", preferredStyle: .alert)
        let tamamAction = UIAlertAction(title: "Ok", style: .default){ [weak self] action in
            // ürünler silindi
            for yemek in self!.yemekler {
                self!.sepetSayfaPresenterNesnesi?.sil(sepet_yemek_id: yemek.sepet_yemek_id!, kullanici_adi: yemek.kullanici_adi!)
            }
          
//
//
//            }
            self?.tabBarController?.selectedIndex = 0
            
        }
        alert.addAction(tamamAction)
        present(alert, animated: true, completion: nil)

    }
    

    func toggleDeleteAll() {
        let alert = UIAlertController(title: "Do you want to delete all items in the cart?", message: "", preferredStyle: .alert)
        let tamamAction = UIAlertAction(title: "Delete All", style: .destructive){ [weak self] action in
            self?.silBarButton()
        }
        alert.addAction(tamamAction)
        let iptalAction = UIAlertAction(title: "Cancel", style: .cancel){ action in
            
        }
        alert.addAction(iptalAction)
        present(alert, animated: true, completion: nil)

    }
    
}


extension BasketVC : TableViewCellDelegate {
     func didTapPlusBtnFromUser(_ cell: BasketTableViewCell) {
        let indexPath =  BasketTableView.indexPath(for: cell)
        let siparisAdet = Int(yemekler[indexPath!.row].yemek_siparis_adet!)! + 1
        print(siparisAdet)

        yemekler[indexPath!.row].yemek_siparis_adet = String(siparisAdet)

        BasketTableView.reloadData()
        get_total()
    }


    func didTapMinesBtnFromUser(_ cell: BasketTableViewCell) {
        let indexPath =  BasketTableView.indexPath(for: cell)
        let siparisAdet = Int(yemekler[indexPath!.row].yemek_siparis_adet!)! - 1

        if siparisAdet > 0 {
            yemekler[indexPath!.row].yemek_siparis_adet = String(siparisAdet)
        } else {
                sepetSayfaPresenterNesnesi?.sil(sepet_yemek_id:yemekler[indexPath!.row].sepet_yemek_id!, kullanici_adi: yemekler[indexPath!.row].kullanici_adi!)

        }

        BasketTableView.reloadData()
        get_total()

    }

}

  

