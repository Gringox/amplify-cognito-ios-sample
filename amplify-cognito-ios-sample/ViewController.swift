//
//  ViewController.swift
//  amplify-cognito-ios-sample
//
//  Created by Valdivieso Gutierrez, Pedro Luis on 1/9/20.
//  Copyright © 2020 Amazon Web Services. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func hostedUiPressed(_ sender: Any) {
    }
    
    @IBAction func builtInUiPressed(_ sender: Any) {
        Cognito.showBuiltInUi(navigationController: self.navigationController!)
    }
    
    @IBAction func globalSignOutPressed(_ sender: Any) {
        Cognito.signOut()
    }
    
    @IBAction func usernamePressed(_ sender: Any) {
        Cognito.getUsername()
    }
    
    @IBAction func tokensPressed(_ sender: Any) {
        Cognito.getTokens()
    }
}
