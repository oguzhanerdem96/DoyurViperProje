//
//  HomePageVC.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 16.09.2022.
//

import UIKit

class HomePageVC: UIViewController {
    @IBOutlet weak var searchBarHomePage: UISearchBar!
    
    @IBOutlet weak var collectionViewHomePage: UICollectionView!
    var yemekListe = [TumYemekler]()
    var anasayfaPresenterNesnesi:ViewToPresenterAnasayfaProtocol?
    var filterFoodList = [TumYemekler]()
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewHomePage.delegate = self
        collectionViewHomePage.dataSource = self
        let foodTasarim = UICollectionViewFlowLayout()
        foodTasarim.sectionInset = UIEdgeInsets(top: 8, left: 3, bottom: 8, right: 3)
        foodTasarim.minimumLineSpacing = 10
        foodTasarim.minimumInteritemSpacing = 10
        let width = collectionViewHomePage.frame.size.width
        let cellWidht = (width - 20) / 2
        foodTasarim.itemSize = CGSize(width: cellWidht, height: cellWidht*1.1)
       collectionViewHomePage.collectionViewLayout = foodTasarim
        
        
        AnasayfaRouter.createModule(ref: self)
        searchBarHomePage.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        anasayfaPresenterNesnesi?.yemekleriYukle()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            let yemek = sender as? TumYemekler
            let gidilecekVC = segue.destination as! DetailsVC
            gidilecekVC.yemek = yemek
        }
    
}
}
    extension HomePageVC : PresenterToViewAnasayfaProtocol {
    func vieweVeriGonder(yemekListesi: Array<TumYemekler>) {
        self.yemekListe = yemekListesi
        self.filterFoodList = yemekListesi
        DispatchQueue.main.async {
            self.collectionViewHomePage.reloadData()
        }
    }
    }

    // SEARCH
    extension HomePageVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterFoodList = self.yemekListe.filter{yemek in
            if yemek.yemek_adi!.lowercased().contains(searchText.lowercased()){
                return true
            }
            if searchText == ""{
                return true
            }
            return false
        }
        self.collectionViewHomePage.reloadData()
        
        anasayfaPresenterNesnesi?.ara(aramaKelimesi: searchText)
    }
    }


    extension HomePageVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
      


            return filterFoodList.count
      
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       
       
            return CGFloat(15)

        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

       let collectionView = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewHucre", for: indexPath) as! HomePageCollectionViewCell
            let yemek = filterFoodList[indexPath.row]
            let hucre = collectionView
            
        hucre.homePageImageView.image = UIImage(named: yemek.yemek_resim_adi!)
        hucre.homePageLbl.text = yemek.yemek_adi
        hucre.homePagePrİceLbl.text = "\(yemek.yemek_fiyat!) TL"
        hucre.resimGoster(resimAdi: "\(yemek.yemek_resim_adi!)")
        
            

            return hucre
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
                print("Girdi")
            let yemek = filterFoodList[indexPath.row]
                performSegue(withIdentifier: "toDetay", sender: yemek)
           
           
         
            
            
        }
        
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionView {
            return CGSize(width: CGFloat(160), height: CGFloat(45))
        } else {
            return CGSize(width: CGFloat(202), height: CGFloat(241))
        }
        
    }











