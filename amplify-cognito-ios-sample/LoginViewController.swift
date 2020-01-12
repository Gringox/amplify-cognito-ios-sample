//
//  LoginViewController.swift
//  Cognito6717147381
//
//  Created by Anjum, Zeeshan on 03/01/2020.
//  Copyright © 2020 Anjum, Zeeshan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signIn(_ sender: Any) {
        if let username = userNameTF.text, let password = passwordTF.text {
            signInUser(with: username, password: password)
        }
    }
}

extension LoginViewController {
    private func signInUser(with username: String, password: String) {
        Cognito.signIn(with: username, password: password)
    }
}
