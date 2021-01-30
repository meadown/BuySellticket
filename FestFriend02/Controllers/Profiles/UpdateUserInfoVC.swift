//
//  UpdateUserInfoVC.swift
//  FestFriend02
//
//  Created by Md Kamrul Hasan on 7/3/19.
//  Copyright © 2019 MySoftheaven BD. All rights reserved.
//

import UIKit

class UpdateUserInfoVC: UIViewController,UINavigationControllerDelegate , UIImagePickerControllerDelegate,  StateListDelegate{
 
    
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var lblShortName: UITextField!
    @IBOutlet weak var lblAge: UITextField!
    @IBOutlet weak var lblCountry: UITextField!
    @IBOutlet weak var lblState: UILabel!
    
    @IBOutlet weak var sateContainer: UIView!
    
//    @IBOutlet weak var userImage: UIImageView!
//    @IBOutlet weak var lblShortName: UILabel!
//    @IBOutlet weak var lblEmail: UILabel!
//    @IBOutlet weak var lblAge: UILabel!
//    @IBOutlet weak var lblCountry: UILabel!
//    @IBOutlet weak var lblState: UILabel!
    var stateList: [State]?
    var selectedState: String?
    var stateId : String?
    var imageData : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(stateContainerAction(_:)))
        sateContainer.addGestureRecognizer(tap)
        getAllStates()
       
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @objc func stateContainerAction(_ sender: UITapGestureRecognizer) {
        if let stateList = stateList, stateList.count > 0 {
            performSegue(withIdentifier: "toStateList", sender: self)
        } else {
            showDialog(title: "States", message: "No state found")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier!.elementsEqual("toStateList") {
            let destVc = segue.destination as! StateListVC
            destVc.stateList = stateList!
            destVc.delegate = self
        }
    }
    
    func stateChossed(index: Int) {
        let state = stateList![index]
        lblState.text = state.name!
        selectedState = state.name!
        stateId =  String(state.id!)
        
        
        
     }
    private func getAllStates() {
        APICall.getAllStates { (response) in
            if let response = response {
                if let stateList = response.allStateList, stateList.count > 0 {
                    self.stateList = stateList
                   
                }
                 self.getDetails()
            }
        }
    }
    private func updateUserRequest() {
        
        var param = [String: AnyObject]()
        param["user_id"] = LocalPersistance.getUserId() as? AnyObject
        
        guard let name = lblShortName.text, !name.isEmpty else {
            showDialog(title: "Add Name", message: "Please write your name")
            lblShortName.becomeFirstResponder()
            return
        }
        param["name"] = name as? AnyObject

        guard let age = lblAge.text, !age.isEmpty else {
            showDialog(title: "Add Age", message: "Age is required.")
            lblAge.becomeFirstResponder()
            return
        }
        param["age"] = age as? AnyObject

        guard let country = lblCountry.text, !country.isEmpty else {
            showDialog(title: "Add Country", message: "Country is required")
            lblCountry.becomeFirstResponder()
            return
        }
        param["city"] = country as? AnyObject
        param["country"] = 3 as AnyObject

        print(self.stateId)
        guard let state = self.stateId  else {
            showDialog(title: "Add State", message: "Please chose a state")
            return
        }
        param["state"] = state as AnyObject
        param["photo"] = imageData as AnyObject


        showProgress(on: view)

       

        
        APICall.updateUserAddress(param: param) { (response) in
             self.dismissProgress(for: self.view)
                if let response = response {
                    if response.status! {
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        self.showDialog(title: "Add Address", message: "Something went wrong.")
                    }
                }
            
        }


}
    @IBAction func SaveActionButton(_ sender: Any) {
        self.updateUserRequest()
    }
    @IBAction func chooseButtonAction(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
       //   imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker,animated:true , completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        userImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        let imageCommpresion = userImage.image?.resized(withPercentage: 0.1)
        let imageData:NSData = UIImagePNGRepresentation(imageCommpresion!)! as NSData
        let dataImage = imageData.base64EncodedString(options: .lineLength64Characters)
        
        self.imageData = "data:image/jpeg;base64,\(dataImage)"
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    private func getDetails() {
        showProgress(on: view)
        
        APICall.getUserDetails { (response) in
            self.dismissProgress(for: self.view)
            
            if let response = response, let details = response.userDetails {
                self.lblShortName.text = details.name != nil ? details.name! : ""
//                self.lblEmail.text = details.email != nil ? details.email! : ""
                self.lblAge.text = details.age != nil ? details.age! : ""
                self.lblCountry.text = details.country != nil ? details.country! : ""
                self.lblState.text = details.state != nil ? details.state! : ""
                
                for state in self.stateList!{
                    
                    if state.name == details.state{
                        self.stateId =  String(state.id!)
                        break
                    }
                }
                
                if let imgStr = details.image {
                    let url = URL(string: imgStr)
                    self.userImage.sd_setImage(with: url)
                }
            }
        }
    }
}
extension UIImage {
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
