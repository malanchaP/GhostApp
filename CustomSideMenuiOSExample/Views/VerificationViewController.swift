//
//  VerificationViewController.swift
//  GhostApp
//
//  Created by Malancha Poddar on 28/03/22.
//

import UIKit
import SwiftLoader

class VerificationViewController: UIViewController {
    @IBOutlet var otptxtfld: UITextField!
    @IBOutlet var phnlbl: UILabel!
    @IBOutlet var timelbl: UILabel!
    @IBOutlet var sbmt: UIButton!
    @IBOutlet var resendbtn: UIButton!
    var phntxt = ""
    var from = ""
    var otptxt = ""
    var count = 60  // 60sec if you want
    var resendTimer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        resendTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        var config : SwiftLoader.Config = SwiftLoader.Config()
          config.size = 150
          config.spinnerColor = .green
          config.foregroundColor = .gray
          config.foregroundAlpha = 0.5

          SwiftLoader.setConfig(config)
        otptxtfld.layer.borderWidth = 1
        otptxtfld.layer.borderColor = UIColor(red: 116.0/255.0, green: 225.0/255.0, blue: 117.0/255.0, alpha: 1.0).cgColor
        otptxtfld.layer.cornerRadius = 5.0
        sbmt.layer.cornerRadius = 5.0
        phnlbl.text = phntxt
        //otptxtfld.text = otptxt
        // Do any additional setup after loading the view.
    }
    @objc func update() {
        if(count > 0) {
            count = count - 1
            print(count)
            timelbl.text = "OTP expires in \(count) secs"
            resendbtn.titleLabel?.textColor = .lightGray
            resendbtn.isUserInteractionEnabled = false
        }
        else {
            resendTimer.invalidate()
            resendbtn.titleLabel?.textColor = .green
            resendbtn.isUserInteractionEnabled = true
            print("call your api")
            // if you want to reset the time make count = 60 and resendTime.fire()
        }
    }

    @IBAction func submitbtnAction(_ sender: UIButton) {
        //apicall
       verifyotpApi()
        
    }
    
    func verifyotpApi(){
        ApIService().VerifyOTPAPI(mobile: phntxt, OTP: otptxtfld.text!){ (data, error) in
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
                                    
                                    
                                     
                                     let UserApiToken = resp["UserApiToken"] as? String
                                  
                                  
                                     let CustomerId = resp["UserUId"] as? String
                                     if self.from == "signup"{
                                          let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                          let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginSignupViewController") as! LoginSignupViewController
                                          nextViewController.modalPresentationStyle = .fullScreen
                                          self.present(nextViewController, animated:true, completion:nil)
                                         return
                                     }
                                    
                                     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                     let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
                                     nextViewController.useruid = CustomerId!
                                     nextViewController.UserApiToken = UserApiToken!
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

    
    
    @IBAction func resendbtnAction(_ sender: UIButton) {
       
        resendotpApi()
    }
    
    
    func resendotpApi(){
        ApIService().SendOTPAPI(mobile: phntxt, actiontype: "Resend"){ (data, error) in
            SwiftLoader.hide()
                       if error != nil{
                           print("Error \(String(describing: error?.localizedDescription))")
                       }else{
                           do {
                               let parse = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                               print(parse)
                           
                               if let resp = parse["OTPResponse"] as? [String:Any]{
                                   
                               if let status = resp["ResponseFlag"] as? Bool{
                                   let ResponseMessage = resp["ResponseMessage"] as? String
                                 if status == true{
                                     let Parameter1 = resp["Parameter1"] as? String
                                    
                                                                            let dialogMessage = UIAlertController(title: "Success", message: ResponseMessage, preferredStyle: .alert)
                                     
                                                                            // Create OK button with action handler
                                                                            let ok = UIAlertAction(title: "ok", style: .default, handler: { (action) -> Void in
                                                                                print("Ok button tapped")
                                                                               // self.otptxtfld.text = Parameter1
                                                                            })
                                     
                                     
                                     
                                                                            //Add OK and Cancel button to an Alert object
                                                                            dialogMessage.addAction(ok)
                                                                            //dialogMessage.addAction(cancel)
                                     
                                                                            // Present alert message to user
                                                                            self.present(dialogMessage, animated: true, completion: nil)
                                 }
                                   else{
                                      
//                                       let dialogMessage = UIAlertController(title: "Error", message: ResponseMessage, preferredStyle: .alert)
//
//                                       // Create OK button with action handler
//                                       let ok = UIAlertAction(title: "ok", style: .default, handler: { (action) -> Void in
//                                           print("Ok button tapped")
//
//                                       })
//
//
//
//                                       //Add OK and Cancel button to an Alert object
//                                       dialogMessage.addAction(ok)
//                                       //dialogMessage.addAction(cancel)
//
//                                       // Present alert message to user
//                                       self.present(dialogMessage, animated: true, completion: nil)
                                   
                                  
                                 
                                   
                               }
                               
                              
                               }
                               }
                               
                              
                           }catch{
                               print(error)
                           }
                       }
                   }
       }

    
    @IBAction func backbtnAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
