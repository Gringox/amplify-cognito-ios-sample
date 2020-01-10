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
        AWSMobileClient.default().initialize { (userState, error) in
            if let userState = userState {
                print("UserState: \(userState.rawValue)")
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
            } else if let error = error {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    class func showBuiltInUi(navigationController: UINavigationController) {
        AWSMobileClient.default().initialize { (userState, error) in
            if let userState = userState {
                AWSMobileClient.default().showSignIn(navigationController: navigationController, { (signInState, error) in
                    if let signInState = signInState {
                        print("Sign in flow completed: \(signInState)")
                    } else if let error = error {
                        print("error logging in: \(error.localizedDescription)")
                    }
                })
            } else if let error = error {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    class func signOut() {
        AWSMobileClient.default().initialize { (userState, error) in
            if let userState = userState {
                AWSMobileClient.default().signOut(options: SignOutOptions(signOutGlobally: true)) { (error) in
                    print("Error: \(error.debugDescription)")
                }
            } else if let error = error {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    class func getUsername() {
        AWSMobileClient.default().initialize { (userState, error) in
            if let userState = userState {
                print(AWSMobileClient.default().username)
            } else if let error = error {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    class func getTokens() {
        AWSMobileClient.default().initialize { (userState, error) in
            if let userState = userState {
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
            } else if let error = error {
                print("error: \(error.localizedDescription)")
            }
        }
    }
}
