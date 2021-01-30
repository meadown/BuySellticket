//
//  SignUpVC.swift
//  FestFriend02
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit
import FirebaseAuth
import FacebookCore
import FacebookLogin
import GoogleSignIn

class SignUpVC: UIViewController , GIDSignInDelegate {
 
    
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnAgreeTerms: CheckboxButton!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var fbLoginContainerView: UIView!
    @IBOutlet weak var googleLoginContainerView: UIView!
    @IBOutlet weak var signupLabel: UILabel!
    
    @IBOutlet weak var fblogjnHeightConstant: NSLayoutConstraint!
    var dict : [String : AnyObject]!
    var gData = [String: AnyObject]()


  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        //        shasthonet02@gmail.com
      //  12345678
        setupViews()
        setupLabelTerms()
        self.fblogjnHeightConstant.constant = 0
    }
    //Mark: after returning other view setup again
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        setupViews()
        setupLabelTerms()
        self.fblogjnHeightConstant.constant = 0
    }
    
    fileprivate func setupLabelTerms() {
        signupLabel.text = "By signing up, you agree to the Terms of Service and Privacy Policy."
        let text = (signupLabel.text)!
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "Terms of Service")
        underlineAttriString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range1)
        let range2 = (text as NSString).range(of: "Privacy Policy")
        underlineAttriString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: range2)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range2)
        signupLabel.attributedText = underlineAttriString
        signupLabel.isUserInteractionEnabled = true
        signupLabel.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
    }
    
    
    
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        let text = (signupLabel.text)!
        let termsRange = (text as NSString).range(of: "Terms of Service")
        let privacyRange = (text as NSString).range(of: "Privacy Policy")
        
        if gesture.didTapAttributedTextInLabel(label: signupLabel, inRange: termsRange) {
            if let url = URL(string: "https://www.festfriends.app/terms"),
                UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        } else if gesture.didTapAttributedTextInLabel(label: signupLabel, inRange: privacyRange) {
            if let url = URL(string: "https://www.festfriends.app/privacy"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        } else {
            print("Tapped none")
        }
    }
    
    private func setupViews() {
        
        btnSignup.layer.cornerRadius = 3
        btnSignup.layer.borderWidth = 1
        btnSignup.layer.borderColor = UIColor.gray.cgColor
        
        let fbContainerTapGesture = UITapGestureRecognizer(target: self, action: #selector(fbLoginVIewAction(_:)))
        fbLoginContainerView.addGestureRecognizer(fbContainerTapGesture)
        fbLoginContainerView.layer.cornerRadius = 5
        
        let googleContainerTapGesture = UITapGestureRecognizer(target: self, action: #selector(googleLoginVIewAction(_:)))
        googleLoginContainerView.addGestureRecognizer(googleContainerTapGesture)
        googleLoginContainerView.layer.cornerRadius = 5
        googleLoginContainerView.layer.borderColor = UIColor.gray.cgColor
        googleLoginContainerView.layer.borderWidth = 1
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btnSignupAction(_ sender: UIButton) {
        signupRequest()
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
                                }
                                
                            } else {
                                self.showDialog(title: "Sign Up", message: response.msg! )
                            }
                        } else {
                            self.showDialog(title: "Sign Up", message: "Registration failed")
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
            
            self.showDialog(title: "Sign Up", message: error.localizedDescription)

        } else {
            showProgress(on: self.view)

            // Perform any operations on signed in user here.
            
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
                            self.showDialog(title: "Sign Up", message: response.msg!)
                        }
                         
                      
                    } else {
                        self.showDialog(title: "Sign Up", message: response.msg!)
                    }
                } else {
                    self.showDialog(title: "Sign Up", message: "Registration failed")
                }
            }
            
//
        }
    }
    private func signupRequest() {
        
        guard let name = txtFirstName.text, !name.isEmpty else {
            showDialog(title: "Sign Up", message: "Please provide your name")
            return
        }
        
        guard let email = txtEmail.text, !email.isEmpty, isValidEmail(email: email) else {
            showDialog(title: "Sign Up", message: "Please provide a valid email address.")
            return
        }
        
        guard let password = txtPassword.text, !password.isEmpty else {
            showDialog(title: "Sign Up", message: "Please provide password.")
            return
        }
        
        guard let rePassword = txtConfirmPassword.text, !rePassword.isEmpty else {
            showDialog(title: "Sign Up", message: "Please confirm your password")
            return
        }
        
        if password.count < 6 {
            showDialog(title: "Sign Up", message: "The password must be at least 6 characters.")
            return
        }
        
        if password.elementsEqual(rePassword) {
            if btnAgreeTerms.isChecked {
                showProgress(on: self.view)
                let params = ["email": email, "name": name, "password": password] as! [String: AnyObject]
                APICall.requestSignup(params: params) { (registrationResponse) in
                    
                    self.dismissProgress(for: self.view)
                    
                    if let response = registrationResponse {
                        if response.status! {
                            self.showDialog(title: "Registration Successful", message: "A verification link has been sent to your email. Please click on the link to complete the registration process. Thank you!")
                        } else {
                            self.showDialog(title: "Sign Up", message: "Registration failed")
                        }
                    } else {
                        self.showDialog(title: "Email Already in Use", message: "The email address you have entered is already associated with an account. Please try again.")
                    }
                }
            } else {
                showDialog(title: "Sign Up", message: "Please agree to the Terms of Service and Privacy Policy.")
            }
        } else {
            showDialog(title: "Sign Up", message: "The passwords must match.")
        }
    }

}
extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
        //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
