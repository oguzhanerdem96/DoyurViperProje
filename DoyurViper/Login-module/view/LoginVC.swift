//
//  LoginVC.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 16.09.2022.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    var loginPresenter : ViewToPresenterLoginProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()

        loginTextField.autocorrectionType = .no
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        if loginTextField.text != "" && loginPassword.text != "" {
            let auth = Auth.auth()
            auth.signIn(withEmail: loginTextField.text!, password: loginPassword.text!) { (authdata, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(OKAction)
                    self.present(alert, animated: true)

                } else {
                    //self.navigationController?.popToRootViewController(animated: true)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarControllerID") as! UITabBarController
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }

            }
        } else {
            let alert = UIAlertController(title: "Error", message:"username/password ?", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(OKAction)
            self.present(alert, animated: true)
        }
    }
    
    
    }
    


