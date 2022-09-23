//
//  RegisterViewController.swift
//  DoyurViper
//
//  Created by Oğuzhan Erdem on 16.09.2022.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var registerEmail: UITextField!
    
    @IBOutlet weak var registerPassword: UITextField!
    var registerPresneterObject : ViewToPresenterRegisterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()

        registerEmail.autocorrectionType = .no
        registerPassword.autocorrectionType = .no
        RegisterRouter.createModule(ref: self)

    }
    

    @IBAction func registerBtn(_ sender: Any) {
        if let te = registerEmail.text, let tp = registerPassword.text{
            registerPresneterObject?.registerUser(email: te, password: tp)
        }
        
        let alert = UIAlertController(title: "Register", message: "Başarılı giriş yapıldı.", preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: .default)
        {
            action in
            self.navigationController?.popToRootViewController(animated: true)
            
        }
        
        alert.addAction(okayAction)
        self.present(alert, animated: true)
       
    }
    }
    


