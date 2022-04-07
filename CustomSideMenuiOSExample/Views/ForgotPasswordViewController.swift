//
//  ForgotPasswordViewController.swift
//  GhostApp
//
//  Created by Malancha Poddar on 28/03/22.
//

import UIKit
import SwiftLoader

class ForgotPasswordViewController: UIViewController {
    @IBOutlet var mobiletxtfld: UITextField!
    @IBOutlet var titllbl: UILabel!
    @IBOutlet var otpbtn: UIButton!
    var titl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        var config : SwiftLoader.Config = SwiftLoader.Config()
          config.size = 150
          config.spinnerColor = .green
          config.foregroundColor = .gray
          config.foregroundAlpha = 0.5

          SwiftLoader.setConfig(config)
        mobiletxtfld.layer.borderWidth = 1
        mobiletxtfld.layer.borderColor = UIColor(red: 116.0/255.0, green: 225.0/255.0, blue: 117.0/255.0, alpha: 1.0).cgColor
        mobiletxtfld.layer.cornerRadius = 5.0
        otpbtn.layer.cornerRadius = 5.0
        titllbl.text = titl
        // Do any additional setup after loading the view.
    }
    
    @IBAction func otpbtnAction(_ sender: UIButton) {
        if mobiletxtfld.text!.isEmpty
        {
          
            let dialogMessage = UIAlertController(title: "Error", message: "Please enter mobile number", preferredStyle: .alert)

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
            //API call
            sendotpApi()
        }
        
    }
    
    
    
    func sendotpApi(){
        ApIService().SendOTPAPI(mobile: mobiletxtfld.text!, actiontype: "Send"){ (data, error) in
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
                                    
                                     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                     let nextViewController = storyBoard.instantiateViewController(withIdentifier: "VerificationViewController") as! VerificationViewController
                                     nextViewController.modalPresentationStyle = .fullScreen
                                     nextViewController.phntxt = self.mobiletxtfld.text!
                                     nextViewController.otptxt = Parameter1!
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

    
  
    @IBAction func backbtnAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
