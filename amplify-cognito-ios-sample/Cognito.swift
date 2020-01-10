//
//  SignIn.swift
//  amplify-cognito-ios-sample
//
//  Created by Valdivieso Gutierrez, Pedro Luis on 1/7/20.
//  Copyright © 2020 Amazon Web Services. All rights reserved.
//

import Foundation
import UIKit
import AWSMobileClient

class Cognito {
    class func signIn() {
        Cognito.initialize { (error) in
            if error == nil {
                AWSMobileClient.default().signIn(username: "username", password: "password") { (signInResult, error) in
                    if let error = error  {
                        print("\(error.localizedDescription)")
                    } else if let signInResult = signInResult {
                        switch (signInResult.signInState) {
                        case .signedIn:
                            print("User is signed in.")
                        case .smsMFA:
                            print("SMS message sent to \(signInResult.codeDetails!.destination!)")
                        default:
                            print("Sign In needs info which is not yet supported.")
                        }
                    }
                }
            }
        }
    }
    
    class func showBuiltInUi(navigationController: UINavigationController) {
        Cognito.initialize { (error) in
            if error != nil {
                AWSMobileClient.default().showSignIn(navigationController: navigationController, { (signInState, error) in
                    if let signInState = signInState {
                        print("Sign in flow completed: \(signInState)")
                    } else if let error = error {
                        print("error logging in: \(error.localizedDescription)")
                    }
                })
            }
        }
    }
    
    class func signOut() {
        Cognito.initialize { (error) in
            if error != nil {
                AWSMobileClient.default().signOut(options: SignOutOptions(signOutGlobally: true)) { (error) in
                    print("Error: \(error.debugDescription)")
                }
            }
        }
    }
    
    class func getUsername() {
        Cognito.initialize { (error) in
            if error != nil {
                print(AWSMobileClient.default().username as Any)
            }
        }
    }
    
    class func getTokens() {
        Cognito.initialize { (error) in
            if error != nil {
                AWSMobileClient.default().getTokens { (tokens, error) in
                    if let error = error {
                        print("Error getting tokens \(error.localizedDescription)")
                    } else if let tokens = tokens {
                        if let idToken = tokens.idToken {
                            print(idToken.tokenString!)
                        }
                        
                        if let accessToken = tokens.accessToken {
                            print(accessToken.tokenString!)
                        }
                        
                        if let refreshToken = tokens.idToken {
                            print(refreshToken.tokenString!)
                        }
                    }
                }
            }
        }
    }
}


//MARK: Helpers
extension Cognito {
    class func initialize(_ completionHandler: @escaping (Error?) -> Void) {
        AWSMobileClient.default().initialize { (userState, error) in
            if let userState = userState {
                print("UserState: \(userState.rawValue)")
                completionHandler(nil)
            } else {
                completionHandler(error)
            }
        }
    }
}
