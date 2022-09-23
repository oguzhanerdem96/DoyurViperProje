//
//  ProfileVC.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 16.09.2022.
//

import UIKit
import Firebase
import Alamofire

    class ProfileVC: UIViewController {
        @IBOutlet weak var emailTf: UILabel!
    var profilePresenterObject : ViewToPresenterProfileProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        ProfileRouter.createModule(ref: self)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        profilePresenterObject?.showInfoAll()
    }

        @IBAction func logOutBtn(_ sender: Any) {
            do {
                try Auth.auth().signOut() }
            catch { print("already logged out") }
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "toLogin") as! LoginVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        }
        

   

}
extension ProfileVC : PresenterToViewProfileProtocol
{
    func sendDataToView(email: String) {
        
        self.emailTf.text = email
    }
    
}

