//
//  ResetPasswordViewController.swift
//  GhostApp
//
//  Created by Malancha Poddar on 28/03/22.
//

import UIKit
import SwiftLoader

class ResetPasswordViewController: UIViewController {
    @IBOutlet var nwpasswrd: UITextField!
    @IBOutlet var confrmpasswrd: UITextField!
    @IBOutlet var titllbl: UILabel!
    @IBOutlet var sbmt: UIButton!
    var UserApiToken = ""
    var useruid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var config : SwiftLoader.Config = SwiftLoader.Config()
          config.size = 150
          config.spinnerColor = .green
          config.foregroundColor = .gray
          config.foregroundAlpha = 0.5

          SwiftLoader.setConfig(config)
        nwpasswrd.layer.borderWidth = 1
        nwpasswrd.layer.borderColor = UIColor(red: 116.0/255.0, green: 225.0/255.0, blue: 117.0/255.0, alpha: 1.0).cgColor
        nwpasswrd.layer.cornerRadius = 5.0
        confrmpasswrd.layer.borderWidth = 1
        confrmpasswrd.layer.borderColor = UIColor(red: 116.0/255.0, green: 225.0/255.0, blue: 117.0/255.0, alpha: 1.0).cgColor
        confrmpasswrd.layer.cornerRadius = 5.0
        sbmt.layer.cornerRadius = 5.0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitbtnAction(_ sender: UIButton) {
        if nwpasswrd.text!.isEmpty
        {
          
            let dialogMessage = UIAlertController(title: "Error", message: "Please enter  Newpassword", preferredStyle: .alert)

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
        else if confrmpasswrd.text!.isEmpty
        {
          
            let dialogMessage = UIAlertController(title: "Error", message: "Please enter  confrmpasswrd", preferredStyle: .alert)

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
        else if confrmpasswrd.text != nwpasswrd.text!
        {
          
            let dialogMessage = UIAlertController(title: "Error", message: "Password not matched", preferredStyle: .alert)

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
        //api call
        else{
            resetPasswordApi()
        }
        
    }
    @IBAction func backbtnAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
   
    
    func resetPasswordApi(){
        
        ApIService().ResetPasswordAPI(UserUId: useruid, UserApiToken: UserApiToken, NewPassword: nwpasswrd.text!){ (data, error) in
            SwiftLoader.hide()
                       if error != nil{
                           print("Error \(String(describing: error?.localizedDescription))")
                       }else{
                           do {
                               let parse = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                               print(parse)
                           
                               if let flag = parse["ResponseFlag"] as? Bool{
                                   let ResponseMessage = parse["ResponseMessage"] as? String
                                   
                                   if flag == true{
                                       let dialogMessage = UIAlertController(title: "Success", message: ResponseMessage, preferredStyle: .alert)

                                       // Create OK button with action handler
                                       let ok = UIAlertAction(title: "ok", style: .default, handler: { (action) -> Void in
                                           print("Ok button tapped")
                                           let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                           let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginSignupViewController") as! LoginSignupViewController
                                           nextViewController.modalPresentationStyle = .fullScreen
                                           self.present(nextViewController, animated:true, completion:nil)
                                          
                                       })

                                    

                                       //Add OK and Cancel button to an Alert object
                                       dialogMessage.addAction(ok)
                                       //dialogMessage.addAction(cancel)

                                       // Present alert message to user
                                       self.present(dialogMessage, animated: true, completion: nil)
                                   }
                               }
                               
                              
                           }catch{
                               print(error)
                           }
                       }
                   }
       }

    
}
