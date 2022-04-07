//
//  SignupViewController.swift
//  GhostApp
//
//  Created by Malancha Poddar on 06/01/22.
//

import UIKit
import SwiftLoader
class SignupViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        year.text = pickerData[row]
    }
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var address: UITextField!
    @IBOutlet var mobile: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var year: UITextField!
    @IBOutlet var brand: UITextField!
    @IBOutlet var model: UITextField!
    @IBOutlet var lp: UITextField!
    @IBOutlet var cardNo: UITextField!
    @IBOutlet var exprydt: UITextField!
    @IBOutlet var security: UITextField!
    @IBOutlet var billaddress: UITextField!
    @IBOutlet var nameoncard: UITextField!
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var blurVw: UIView!
    @IBOutlet weak var pickerVw: UIView!
    @IBOutlet weak var picker: UIPickerView!
    var pickerData: [String] = [String]()
    @IBOutlet var cntryvw: UIView!
    @IBOutlet var cntrylbl: UILabel!
    var countryiso = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if cntrylbl.text == "+91"{
            countryiso = "IND"
        }
        else{
            countryiso = "US"
        }
        //cntryvw.layer.borderWidth = 1
        //cntryvw.layer.borderColor = UIColor.lightGray.cgColor
        self.picker.delegate = self
                self.picker.dataSource = self
                
                // Input the data into the array
                pickerData = ["2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025"]
        view1.layer.cornerRadius = 20
        view2.layer.cornerRadius = 20
        view3.layer.cornerRadius = 20
        var config : SwiftLoader.Config = SwiftLoader.Config()
          config.size = 150
          config.spinnerColor = .green
          config.foregroundColor = .gray
          config.foregroundAlpha = 0.5

          SwiftLoader.setConfig(config)
        // Do any additional setup after loading the view.
    }
    @IBAction func savebtnAction(_ sender: UIButton) {
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
        
        else if firstName.text!.isEmpty
        {
          
            let dialogMessage = UIAlertController(title: "Error", message: "Please enter first name", preferredStyle: .alert)

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
        else if lastName.text!.isEmpty{
            let dialogMessage = UIAlertController(title: "Error", message: "Please enter last name", preferredStyle: .alert)

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
        else if address.text!.isEmpty{
            let dialogMessage = UIAlertController(title: "Error", message: "Please enter address", preferredStyle: .alert)

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
        else if email.text!.isEmpty{
            let dialogMessage = UIAlertController(title: "Error", message: "Please enter email", preferredStyle: .alert)

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
        else if mobile.text!.isEmpty{
            let dialogMessage = UIAlertController(title: "Error", message: "Please enter mobile", preferredStyle: .alert)

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
            registerApi()
        }
        
//        let dialogMessage = UIAlertController(title: "Success", message: "Registration completed successfully", preferredStyle: .alert)
//
//        // Create OK button with action handler
//        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
//            print("Ok button tapped")
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginSignupViewController") as! LoginSignupViewController
//            nextViewController.modalPresentationStyle = .fullScreen
//            self.present(nextViewController, animated:true, completion:nil)
//        })
//
//
//        //Add OK and Cancel button to an Alert object
//        dialogMessage.addAction(ok)
//
//
//        // Present alert message to user
//        self.present(dialogMessage, animated: true, completion: nil)
    }

    @IBAction func backbtnAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }

    
    func registerApi(){
        ApIService().registrationAPI(firstname: firstName.text!, lastname: lastName.text!, address: address.text!, username: username.text!, password: password.text!, BrandName: brand.text!, ModelName: model.text!, LicencePlate: lp.text!, Year: year.text!, BillingAddress: billaddress.text!, CardNo: cardNo.text!, NameOnCard: nameoncard.text!, ExpDate: exprydt.text!, Security: security.text!,email: email.text!,mobile: mobile.text!, Country: countryiso){ (data, error) in
            SwiftLoader.hide()
                       if error != nil{
                           print("Error \(String(describing: error?.localizedDescription))")
                       }else{
                           do {
                               let parse = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                               print(parse)
                               
                               if let resp = parse["RegistrationResponseData"] as? [String:Any]{
                               if let status = resp["ResponseFlag"] as? Bool{
                                   let ResponseMessage = resp["ResponseMessage"] as? String
                                 if status == true{
                                     
//                                     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                                     let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginSignupViewController") as! LoginSignupViewController
//                                     nextViewController.modalPresentationStyle = .fullScreen
//                                     self.present(nextViewController, animated:true, completion:nil)
                                     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                     let nextViewController = storyBoard.instantiateViewController(withIdentifier: "VerificationViewController") as! VerificationViewController
                                     nextViewController.modalPresentationStyle = .fullScreen
                                     nextViewController.from = "signup"
                                     nextViewController.phntxt = self.mobile.text!
                                     //nextViewController.otptxt = Parameter1!
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
    
    @IBAction func datePickerFromValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let time = dateFormatter.string(from: sender.date)
       setstartTime = time
        
    }
    var setstartTime = ""
    @IBAction func dateBtnAction(_ sender: UIButton)
    {
        pickerVw.isHidden = false
        blurVw.isHidden = false
        
    }
    @IBAction func okBtnAction(_ sender: UIButton)
       {
           pickerVw.isHidden = true
           blurVw.isHidden = true
          
        //exprydt.text = setstartTime
          
           
       }
       @IBAction func cancelBtnAction(_ sender: UIButton)
       {
           pickerVw.isHidden = true
           blurVw.isHidden = true
           
       }
    
    @IBAction func cntrybtnAction(_ sender: UIButton) {
        cntryvw.isHidden = false
        
    }
    
    
    @IBAction func usbtnAction(_ sender: UIButton) {
        cntrylbl.text = "+1"
        countryiso = "US"
        cntryvw.isHidden = true
    }
    
    @IBAction func indiabtnAction(_ sender: UIButton) {
        cntrylbl.text = "+91"
        countryiso = "IND"
        cntryvw.isHidden = true
        
    }
}
