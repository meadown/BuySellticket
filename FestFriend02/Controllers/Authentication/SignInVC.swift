//
//  SignInVC.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit
import FirebaseAuth
import FacebookCore
import FacebookLogin
import GoogleSignIn

class SignInVC: UIViewController , GIDSignInDelegate{
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPasswprd: UITextField!
    @IBOutlet weak var btnResetPassword: UIButton!
    @IBOutlet weak var btnLogIn: UIButton!
    @IBOutlet weak var fbLoginContainerView: UIView!
    @IBOutlet weak var googleLoginContainerView: UIView!
    
    @IBOutlet weak var fbLoginHeightConstant: NSLayoutConstraint!
    
    var isForRegister = true
    var dict : [String : AnyObject]!
    var gData = [String: AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        if isForRegister {
            performSegue(withIdentifier: "goToRegister", sender: self)
        }
//        self.txtEmail.text = "shasthonet02@gmail.com"
//        self.txtPasswprd.text = "12345678"
        
//        self.txtEmail.text = "shaf@breen.la"//user id - 52
//        self.txtPasswprd.text = "Coachella20"
        self.fbLoginHeightConstant.constant = 0
        
//
//        Coachella20
        setupViews()
    }
    
     //Mark: after returning other view setup again
    override func viewDidAppear(_ animated: Bool) {
            GIDSignIn.sharedInstance()?.delegate = self
            GIDSignIn.sharedInstance()?.presentingViewController = self
            if isForRegister {
                performSegue(withIdentifier: "goToRegister", sender: self)
            }
            self.fbLoginHeightConstant.constant = 0
            
            setupViews()
        }
    
    
    private func setupViews() {
        btnResetPassword.layer.cornerRadius = 3
        btnResetPassword.layer.borderWidth = 1
        btnResetPassword.layer.borderColor = UIColor.gray.cgColor
        
        btnLogIn.layer.cornerRadius = 3
        btnLogIn.layer.borderWidth = 1
        btnLogIn.layer.borderColor = UIColor.gray.cgColor
        
        
        
        
        let fbContainerTapGesture = UITapGestureRecognizer(target: self, action: #selector(fbLoginVIewAction(_:)))
        fbLoginContainerView.addGestureRecognizer(fbContainerTapGesture)
        fbLoginContainerView.layer.cornerRadius = 5
        
        let googleContainerTapGesture = UITapGestureRecognizer(target: self, action: #selector(googleLoginVIewAction(_:)))
        googleLoginContainerView.addGestureRecognizer(googleContainerTapGesture)
        googleLoginContainerView.layer.cornerRadius = 5
        googleLoginContainerView.layer.borderColor = UIColor.gray.cgColor
        googleLoginContainerView.layer.borderWidth = 1
    }
    
    
    // Mark: - Actions
    
    @IBAction func btnResetPasswordAction(_ sender: UIButton) {
        
    }
    
    @IBAction func btnLogInAction(_ sender: UIButton) {
        
        
        if txtEmail.text!.isEmpty == true && txtPasswprd.text!.isEmpty == true
        {
        showDialog(title: "Email and Password Required", message: "Please enter a valid email address and password.")
        }
        
        guard let email = txtEmail.text, !email.isEmpty else {
            showDialog(title: "Email and Password Required", message: "Please enter a valid email address")
            return
        }
        
        guard let password = txtPasswprd.text, !password.isEmpty else {
            showDialog(title: "Email and Password Required", message: "Please enter a valid password.")
            return
        }
        
        let params: [String: AnyObject] = ["email": email, "password": password] as! [String: AnyObject]
        showProgress(on: self.view)
        APICall.requestLogin(params: params) { (logInResponse) in
            self.dismissProgress(for: self.view)
            
            if let loginResponse = logInResponse {
                if let details = loginResponse.userDetails {
                    LocalPersistance.setUserDetails(userDetails: details)
                    self.view.endEditing(true)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    if loginResponse.msg! == "Login Failed!"
                    {
                    self.showDialog(title: "Incorrect Email or Password", message: "We could not verify your credentials. Please try again.")
                    }
                    else{
                         self.showDialog(title: "Incorrect Email or Password", message: "Please enter a valid email address and password.")
                         print("4th case : \(loginResponse.msg!)")
                    }
                }
            } else {
                self.showDialog(title: "Login", message: "Login failed.")
            }
        }
    }
    
    @IBAction func barBtnSignupAction(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRegister", sender: self)
    }
    
    @IBAction func barBtnBackAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func fbLoginVIewAction(_ sender: UITapGestureRecognizer) {
        
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"] , viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                self.getFBUserData()
            }
        }
        
    }
    //function is fetching the user data
    fileprivate func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as? [String : AnyObject]
                    print(result!)
                    print(self.dict)
                    self.showProgress(on: self.view)

                    guard let Username = self.dict["name"]! as? String else { return }
                    guard let UserId = self.dict["id"]! as? String else { return }
                    guard let Useremail = self.dict["email"]! as? String else { return }
                    let params = ["provider_user_id": UserId , "name": Username, "email": Useremail ,"provider": "Facebook"] as! [String: AnyObject]
                    
                    APICall.requestSocialLogin(params: params) { (registrationResponse) in
                        self.dismissProgress(for: self.view)
                        
                        if let response = registrationResponse {
                            if response.status! {
                                if let details = response.userDetails {
                                    LocalPersistance.setUserDetails(userDetails: details)
                                    self.view.endEditing(true)
                                    for controller in self.navigationController!.viewControllers as Array {
                                        if controller.isKind(of: ProfileVC.self) {
                                            self.navigationController!.popToViewController(controller, animated: true)
                                            break
                                        }
                                    }
                                    
                                } else {
                                    self.showDialog(title: "Login", message: response.msg!)
                                    print("1st case : \(response.msg!)")
                                }
                                
                            } else {
                                self.showDialog(title: "SignIn", message: response.msg!)
                                 print("2nd case : \(response.msg!)")
                            }
                        } else {
                            self.showDialog(title: "SignIn", message: "Login failed")
                        }
                    }
                    
                }
            })
        }
    }
    
    @objc func googleLoginVIewAction(_ sender: UITapGestureRecognizer) {
        GIDSignIn.sharedInstance()?.signIn()

    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
         
            self.showDialog(title: "Log In", message: error.localizedDescription)
        } else {
            // Perform any operations on signed in user here.
            showProgress(on: self.view)

            let userId = user.userID                  // For client-side use only!
            let fullName = user.profile.name
            let email = user.profile.email
            let image = user.profile.imageURL(withDimension: 40)
            // [START_EXCLUDE]
            
            let params = ["provider_user_id": user.userID , "name": user.profile.name, "email": user.profile.email ,"provider": "Google"] as! [String: AnyObject]
            
            
            
            //
            APICall.requestSocialLogin(params: params) { (registrationResponse) in
                self.dismissProgress(for: self.view)
                
                if let response = registrationResponse {
                    if response.status! {
                        if let details = response.userDetails {
                            LocalPersistance.setUserDetails(userDetails: details)
                            self.view.endEditing(true)
                            for controller in self.navigationController!.viewControllers as Array {
                                if controller.isKind(of: ProfileVC.self) {
                                    self.navigationController!.popToViewController(controller, animated: true)
                                    break
                                }
                            }
                        } else {
                            self.showDialog(title: "Log In", message: response.msg!)
                             print("3rd case : \(response.msg!)")
                        }
                        
                        
                    } else {
                        self.showDialog(title: "Log In", message: "Login failed")
                    }
                } else {
                    self.showDialog(title: "Log In", message: "Login failed")
                }
            }
            
            //            gData.updateValue(userId as AnyObject, forKey: "userId")
            //            gData.updateValue(fullName as AnyObject, forKey: "fullName")
            //            gData.updateValue(email as AnyObject, forKey: "email")
            //            gData.updateValue(image as AnyObject, forKey: "image")
            //
            //
            //
            //            showDialog(title: "Gmail Login", message: fullName ?? "")
            //            NotificationCenter.default.post(
            //                name: Notification.Name(rawValue: "ToggleAuthUINotification"),
            //                object: nil,
            //                userInfo: ["statusText": "Signed in user:\n\(fullName)"])
            //            // [END_EXCLUDE]
            //
        }
    }
    
}
