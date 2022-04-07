//
//  LoginSignupViewController.swift
//  GhostApp
//
//  Created by APPDEV on 25/12/21.
//

import UIKit
import SwiftLoader

class LoginSignupViewController: UIViewController {
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var loginbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var config : SwiftLoader.Config = SwiftLoader.Config()
          config.size = 150
          config.spinnerColor = .green
          config.foregroundColor = .gray
          config.foregroundAlpha = 0.5

          SwiftLoader.setConfig(config)
        username.layer.borderWidth = 1
        username.layer.borderColor = UIColor(red: 116.0/255.0, green: 225.0/255.0, blue: 117.0/255.0, alpha: 1.0).cgColor
        username.layer.cornerRadius = 5.0
        password.layer.borderWidth = 1
        password.layer.borderColor = UIColor(red: 116.0/255.0, green: 225.0/255.0, blue: 117.0/255.0, alpha: 1.0).cgColor
        password.layer.cornerRadius = 5.0
        loginbtn.layer.cornerRadius = 5.0
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signbtnAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)
      
    }
    
    
    @IBAction func loginbtnAction(_ sender: UIButton) {
        if username.text!.isEmpty
        {
          
            let dialogMessage = UIAlertController(title: "Error", message: "Please enter valid username", preferredStyle: .alert)

            // Create OK button with action handler
            let ok = UIAlertAction(title: "ok", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
               
            })

         

            //Add OK and Cancel button to an Alert object
            dialogMessage.addAction(ok)
            //dialogMessage.addAction(cancel)

            // Present alert message to user
            self.present(dialogMessage, animated: true, completion: nil)
        }
        else if password.text!.isEmpty{
            let dialogMessage = UIAlertController(title: "Error", message: "Please enter password", preferredStyle: .alert)

            // Create OK button with action handler
            let ok = UIAlertAction(title: "ok", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
               
            })

         

            //Add OK and Cancel button to an Alert object
            dialogMessage.addAction(ok)
            //dialogMessage.addAction(cancel)

            // Present alert message to user
            self.present(dialogMessage, animated: true, completion: nil)
        }
        else{
            SwiftLoader.show(animated: true)
            loginApi()
        }
      
        
    }
    
    @IBAction func forgotbtnAction(_ sender: UIButton) {
//        let userName = username.text
//
//        // Check if required fields are not empty
//        if (userName?.isEmpty)!
//        {
//            // Display alert message here
//            let dialogMessage = UIAlertController(title: "Error", message: "Please enter email id", preferredStyle: .alert)
//
//            // Create OK button with action handler
//            let ok = UIAlertAction(title: "ok", style: .default, handler: { (action) -> Void in
//                print("Ok button tapped")
//
//            })
//
//
//
//            //Add OK and Cancel button to an Alert object
//            dialogMessage.addAction(ok)
//            //dialogMessage.addAction(cancel)
//
//            // Present alert message to user
//            self.present(dialogMessage, animated: true, completion: nil)
//
//
//            return
//        }
//
//        let dialogMessage = UIAlertController(title: "Success", message: "We have emailed your password reset link", preferredStyle: .alert)
//
//        // Create OK button with action handler
//        let ok = UIAlertAction(title: "ok", style: .default, handler: { (action) -> Void in
//            print("Ok button tapped")
//
//        })
//
//
//        //Add OK and Cancel button to an Alert object
//        dialogMessage.addAction(ok)
//
//        // Present alert message to user
//        //self.present(dialogMessage, animated: true, completion: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        nextViewController.titl = "Forgot Password?"
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)
       
    }
    
    func loginApi(){
        ApIService().loginAPI(LoginId: username.text!, pass: password.text!){ (data, error) in
            SwiftLoader.hide()
                       if error != nil{
                           print("Error \(String(describing: error?.localizedDescription))")
                       }else{
                           do {
                               let parse = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                               print(parse)
                           
                               if let resp = parse["LoginResponse"] as? [String:Any]{
                               if let status = resp["Flag"] as? Bool{
                                   let ResponseMessage = resp["ResponseMessage"] as? String
                                 if status == true{
                                     let UserName = resp["UserId"] as? String
                                     let CustomerInformation = parse["CustomerInformation"] as! [String:Any]
                                     
                                     let UserApiToken = resp["UserApiToken"] as? String
                                     let address = CustomerInformation["Address1"] as? String
                                     let FirstName = CustomerInformation["FirstName"] as? String
                                     let LastName = CustomerInformation["LastName"] as? String
                                     let EmailId = CustomerInformation["EmailId"] as? String
                                     let Mobile = CustomerInformation["Mobile"] as? String
                                  
                                     let CustomerId = resp["UserUId"] as? String
                                     
                                     let CustomerCarInfod = CustomerInformation["CustomerCarInfo"] as! NSArray
                                     let CustomerCarInfo = CustomerCarInfod[0] as? [String:Any]
                                     let BrandName = CustomerCarInfo?["BrandName"] as? String
                                     let ModelName = CustomerCarInfo?["ModelName"] as? String
                                     let Year = CustomerCarInfo?["Year"] as? String
                                     let LicencePlate = CustomerCarInfo?["LicencePlate"] as? String
                                     let InfoId = CustomerCarInfo?["InfoId"] as? String
//                                     if let CustomerBillingInfod = CustomerInformation["CustomerBillingInfo"] as! NSArray{
//                                     let CustomerBillingInfo = CustomerBillingInfod[0] as? [String:Any]
//                                     //let CustomerBillingInfo = CustomerInformation["CustomerBillingInfo"] as! [String:Any]
//                                     let BillingAddress = CustomerBillingInfo?["BillingAddress"] as? String
//                                     let CardNo = CustomerBillingInfo?["CardNo"] as? String
//                                     let ExpDate = CustomerBillingInfo?["ExpDate"] as? String
//                                     let NameOnCard = CustomerBillingInfo?["NameOnCard"] as? String
//                                     let Security = CustomerBillingInfo?["Security"] as? String
//                                     let InfoId2 = CustomerBillingInfo?["InfoId"] as? String
//                                         UserDefaults.standard.set(BillingAddress, forKey: "BillingAddress")
//                                         UserDefaults.standard.set(CardNo, forKey: "CardNo")
//                                         UserDefaults.standard.set(ExpDate, forKey: "ExpDate")
//                                         UserDefaults.standard.set(NameOnCard, forKey: "NameOnCard")
//                                         UserDefaults.standard.set(Security, forKey: "Security")
//                                     }
                                     //UserDefaults.standard.set(InfoId2, forKey: "InfoId2")
                                     UserDefaults.standard.set(UserApiToken, forKey: "UserApiToken")
                                     
                                     UserDefaults.standard.set(InfoId, forKey: "InfoId")
                                     
                                     UserDefaults.standard.set(BrandName, forKey: "BrandName")
                                     UserDefaults.standard.set(ModelName, forKey: "ModelName")
                                     UserDefaults.standard.set(Year, forKey: "Year")
                                     UserDefaults.standard.set(LicencePlate, forKey: "LicencePlate")
                                     UserDefaults.standard.set(CustomerId, forKey: "CustomerId")
                                     UserDefaults.standard.set(EmailId, forKey: "EmailId")
                                     UserDefaults.standard.set(Mobile, forKey: "Mobile")
                                     UserDefaults.standard.set(FirstName, forKey: "FirstName")
                                     UserDefaults.standard.set(LastName, forKey: "LastName")
                                     UserDefaults.standard.set(address, forKey: "address")
                                     UserDefaults.standard.set(UserName, forKey: "UserName")
                                     UserDefaults.standard.synchronize()
                                     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                     let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                                     nextViewController.modalPresentationStyle = .fullScreen
                                     self.present(nextViewController, animated:true, completion:nil)
                                 }
                                   else{
                                      
                                       let dialogMessage = UIAlertController(title: "Error", message: ResponseMessage, preferredStyle: .alert)

                                       // Create OK button with action handler
                                       let ok = UIAlertAction(title: "ok", style: .default, handler: { (action) -> Void in
                                           print("Ok button tapped")
                                          
                                       })

                                    

                                       //Add OK and Cancel button to an Alert object
                                       dialogMessage.addAction(ok)
                                       //dialogMessage.addAction(cancel)

                                       // Present alert message to user
                                       self.present(dialogMessage, animated: true, completion: nil)
                                   
                                  
                                 
                                   
                               }
                               
                              
                               }
                               }
                               
                              
                           }catch{
                               print(error)
                           }
                       }
                   }
       }

    
}
