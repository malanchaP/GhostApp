//
//  ViewController.swift
//  CustomSideMenuiOSExample
//
//  Created by John Codeos on 2/§/21.
//

import UIKit
import Toast_Swift
class HomeViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
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
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var address: UITextField!
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
    @IBOutlet weak var blurVw: UIView!
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var picker: UIPickerView!
    var pickerData: [String] = [String]()
    @IBOutlet weak var pickerVw: UIView!
    @IBOutlet weak var edit1: UIButton!
    @IBOutlet weak var edit2: UIButton!
    @IBOutlet weak var yrbtn: UIButton!
    @IBOutlet var mobile: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var cntryvw: UIView!
    @IBOutlet var cntrylbl: UILabel!
    
    var infoid = ""
    var infoid2 = ""
    var actiontype = ""
    var actiontype2 = ""
    var countryiso = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Menu Button Tint Color
        //navigationController?.navigationBar.tintColor = .white
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
          self.navigationController!.navigationBar.shadowImage = UIImage()
          self.navigationController!.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white//UIColor(red: 116.0/255.0, green: 225.0/255.0, blue: 117.0/255.0, alpha: 1.0)
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        view1.layer.cornerRadius = 20
        view2.layer.cornerRadius = 20
        view3.layer.cornerRadius = 20
        if cntrylbl.text == "+91"{
            countryiso = "IND"
        }
        else{
            countryiso = "US"
        }
        updateUI()
        self.picker.delegate = self
                self.picker.dataSource = self
                
                // Input the data into the array
                pickerData = ["2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025"]
       
    }
    @IBAction func datePickerFromValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let time = dateFormatter.string(from: sender.date)
       setstartTime = time
        
    }
    var setstartTime = ""
    @IBAction func dateBtnAction(_ sender: UIButton)
    {
        let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY"
                //let strDate = dateFormatter.string(from: NSDate() as Date)
                //datepicker.date = dateFormatter.date(from: strDate)!
        pickerVw.isHidden = false
        blurVw.isHidden = false
        
    }
    @IBAction func okBtnAction(_ sender: UIButton)
       {
           pickerVw.isHidden = true
           blurVw.isHidden = true
          
        //year.text = setstartTime
          
           
       }
       @IBAction func cancelBtnAction(_ sender: UIButton)
       {
           pickerVw.isHidden = true
           blurVw.isHidden = true
           
       }
    
    @IBAction func gotoHomebtnAction(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func updateUI(){
        let FirstName = UserDefaults.standard.string(forKey: "FirstName")
        let LastName = UserDefaults.standard.string(forKey: "LastName")
        let Address1 = UserDefaults.standard.string(forKey: "address")
        let UserName = UserDefaults.standard.string(forKey: "UserName")
        let EmailId = UserDefaults.standard.string(forKey: "EmailId")
        let Mobile = UserDefaults.standard.string(forKey: "Mobile")
        firstName.text = FirstName
        lastName.text = LastName
        address.text = Address1
        username.text = UserName
        mobile.text = Mobile
        email.text = EmailId
        let BrandName = UserDefaults.standard.string(forKey: "BrandName")
        let ModelName = UserDefaults.standard.string(forKey: "ModelName")
        let Year = UserDefaults.standard.string(forKey: "Year")
        let LicencePlate = UserDefaults.standard.string(forKey: "LicencePlate")
        brand.text = BrandName
        model.text = ModelName
        year.text = Year
        lp.text = LicencePlate
//        let BillingAddress = UserDefaults.standard.string(forKey: "BillingAddress")
//        let CardNo = UserDefaults.standard.string(forKey: "CardNo")
//        let ExpDate = UserDefaults.standard.string(forKey: "ExpDate")
//        let NameOnCard = UserDefaults.standard.string(forKey: "NameOnCard")
//        let Security = UserDefaults.standard.string(forKey: "Security")
//        security.text = Security
//        billaddress.text = BillingAddress
//        cardNo.text = CardNo
//        exprydt.text = ExpDate
//        nameoncard.text = NameOnCard
        let InfoId = UserDefaults.standard.string(forKey: "InfoId")!
        //let InfoId2 = UserDefaults.standard.string(forKey: "InfoId2")!
        if InfoId != ""{
            infoid = InfoId
            actiontype = "Update"
        }
        else{
            infoid = ""
            actiontype = "Add"
        }
//        if InfoId2 != ""{
//            infoid2 = InfoId2
//            actiontype2 = "Update"
//        }
//        else{
//            infoid2 = ""
//            actiontype2 = "Add"
//        }
        
    }
    var isEdit = false
    @IBAction func save1btnAction(_ sender: UIButton) {
        
        isEdit = !isEdit
               if isEdit{
                    
                   edit1.isSelected = true
                   firstName.isUserInteractionEnabled = true
                   lastName.isUserInteractionEnabled = true
                   address.isUserInteractionEnabled = true
                   username.isUserInteractionEnabled = true
                   password.isUserInteractionEnabled = true
                   email.isUserInteractionEnabled = true
                   firstName.becomeFirstResponder()
                   
                  
               }
               else{
                   
                  
                   
                   edit1.isSelected = false
                   firstName.isUserInteractionEnabled = false
                   lastName.isUserInteractionEnabled = false
                   address.isUserInteractionEnabled = false
                   username.isUserInteractionEnabled = false
                   password.isUserInteractionEnabled = false
                   email.isUserInteractionEnabled = false
                   guard let work = firstName?.text,
                          let role = lastName?.text,
                          let start = address?.text,
                         let usernm = username?.text,
                         let email = email?.text
                         
                          
                         
                    
                    else {
                      return
                    }
                    
                    if work.isEmpty || work.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                        view.makeToast("First Name is required")
                      
                        
                    }
                    else if role.isEmpty || role.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                        view.makeToast("Last Name is required")
                        
                    }
                    else if start.isEmpty || start.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                        view.makeToast("Address is required")
                        
                    }
                   else if usernm.isEmpty || usernm.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                       view.makeToast("userName is required")
                       
                   }
                   else if email.isEmpty || email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                       view.makeToast("Email is required")
                       
                   }
                    else{
                        updateCustomer()
                   }
               }
      
        
    }
    
    var isEdit2 = false
    @IBAction func save2btnAction(_ sender: UIButton) {
        isEdit2 = !isEdit2
               if isEdit2{
                    
                   edit2.isSelected = true
                   yrbtn.isUserInteractionEnabled = true
                   brand.isUserInteractionEnabled = true
                   model.isUserInteractionEnabled = true
                   lp.isUserInteractionEnabled = true
                  
                   //year.becomeFirstResponder()
                   
                  
               }
               else{
                   
                  
                   
                   edit2.isSelected = false
                   yrbtn.isUserInteractionEnabled = false
                   brand.isUserInteractionEnabled = false
                   model.isUserInteractionEnabled = false
                   lp.isUserInteractionEnabled = false
                   
                   
                    updateCarinfo()
                   
               }
      
       
    }
    @IBAction func save3btnAction(_ sender: UIButton) {
       // updateBillinginfo()
        
    }
    
    func updateCustomer(){
        let CustomerId = UserDefaults.standard.string(forKey: "CustomerId")!
        ApIService().updateCustomerAPI(UserUId: CustomerId, CustomerId: CustomerId, address: address.text!, username: username.text!, password: password.text!, firstname: firstName.text!, lastname: lastName.text!,email: email.text!,mobile: mobile.text!, Country: countryiso){ (data, error) in
             
                       if error != nil{
                           print("Error \(String(describing: error?.localizedDescription))")
                       }else{
                           do {
                               let parse = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                               print(parse)
                             
                               let dialogMessage = UIAlertController(title: "Success", message: "Customer Profile updated.", preferredStyle: .alert)

                               // Create OK button with action handler
                               let ok = UIAlertAction(title: "ok", style: .default, handler: { (action) -> Void in
                                   print("Ok button tapped")
                                  
                               })

                            

                               //Add OK and Cancel button to an Alert object
                               dialogMessage.addAction(ok)
                               //dialogMessage.addAction(cancel)

                               // Present alert message to user
                               self.present(dialogMessage, animated: true, completion: nil)
                              
                           }catch{
                               print(error)
                           }
                       }
                   }
       }
    
    
    
    func updateCarinfo(){
        let CustomerId = UserDefaults.standard.string(forKey: "CustomerId")!
        ApIService().updateCarAPI(UserUId: CustomerId, CustomerId: CustomerId, BrandName: brand.text!, ModelName: model.text!, LicencePlate: lp.text!, year: year.text!, InfoId: infoid, ActionType: actiontype){ (data, error) in
             
                       if error != nil{
                           print("Error \(String(describing: error?.localizedDescription))")
                       }else{
                           do {
                               let parse = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                               print(parse)
                             
                               let dialogMessage = UIAlertController(title: "Success", message: "Customer Car Info updated.", preferredStyle: .alert)

                               // Create OK button with action handler
                               let ok = UIAlertAction(title: "ok", style: .default, handler: { (action) -> Void in
                                   print("Ok button tapped")
                                  
                               })

                            

                               //Add OK and Cancel button to an Alert object
                               dialogMessage.addAction(ok)
                               //dialogMessage.addAction(cancel)

                               // Present alert message to user
                               self.present(dialogMessage, animated: true, completion: nil)
                              
                           }catch{
                               print(error)
                           }
                       }
                   }
       }
    
    func updateBillinginfo(){
        let CustomerId = UserDefaults.standard.string(forKey: "CustomerId")!
        ApIService().updateBillingAPI(UserUId: CustomerId, CustomerId: CustomerId, CardNo: cardNo.text!, NameOnCard: nameoncard.text!, ExpDate: exprydt.text!, Security: security.text!, BillingAddress: billaddress.text!, InfoId: infoid2, ActionType: actiontype2){ (data, error) in
             
                       if error != nil{
                           print("Error \(String(describing: error?.localizedDescription))")
                       }else{
                           do {
                               let parse = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                               print(parse)
                             
                               let dialogMessage = UIAlertController(title: "Success", message: "Customer Billing Info updated.", preferredStyle: .alert)

                               // Create OK button with action handler
                               let ok = UIAlertAction(title: "ok", style: .default, handler: { (action) -> Void in
                                   print("Ok button tapped")
                                  
                               })

                            

                               //Add OK and Cancel button to an Alert object
                               dialogMessage.addAction(ok)
                               //dialogMessage.addAction(cancel)

                               // Present alert message to user
                               self.present(dialogMessage, animated: true, completion: nil)
                              
                           }catch{
                               print(error)
                           }
                       }
                   }
       }
    @IBAction func changepasswordbtnAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        nextViewController.titl = "Change Password"
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)
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
