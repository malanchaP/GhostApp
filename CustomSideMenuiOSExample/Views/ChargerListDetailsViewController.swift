//
//  ChargerListDetailsViewController.swift
//  GhostApp
//
//  Created by APPDEV on 26/12/21.
//

import UIKit
import SwiftLoader
class ChargerListDetailsViewController: UIViewController {
    var propertyid = ""
    var propertyListDM = Property()
    @IBOutlet var localimageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleLabel2: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var level: UILabel!
    @IBOutlet var outletType: UILabel!
    @IBOutlet var wallcharger: UILabel!
    @IBOutlet var parkingLimit: UILabel!
    @IBOutlet var hostNote: UILabel!
    @IBOutlet var scanBtn: UIButton!
    @IBOutlet var cellbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var config : SwiftLoader.Config = SwiftLoader.Config()
          config.size = 150
          config.spinnerColor = .green
          config.foregroundColor = .gray
          config.foregroundAlpha = 0.5

          SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
        
        getpropertyDetails()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func scanbtnAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ScannerViewController") as! ScannerViewController
        nextViewController.from = "detail"
        nextViewController.propertyid = propertyid
        nextViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextViewController, animated: true)
      
       
    }
    
    func getpropertyDetails(){
        let id = UserDefaults.standard.string(forKey: "CustomerId")
        let UserApiToken = UserDefaults.standard.string(forKey: "UserApiToken")
        
        ApIService().FetchPropertyInfoAPI(UserUId: id!, UserApiToken: UserApiToken!, PropertyId: propertyid){ (data, error) in
            SwiftLoader.hide()
             if error != nil{
              
                 print("Error \(String(describing: error?.localizedDescription))")
             }else{
                 do {
                     let parse = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                   
                     print(parse)
                    
                  if let status = parse["ResponseFlag"] as? Bool{
                      if status == true{
                          if let data = parse["PropertyInformation"] as? [String: AnyObject] {
                         
                              self.propertyListDM = Property.transformToList(dict: data)
                              //cell.propertyimgVw.sd_setImage(with: URL(string: cellDM.property_image!), placeholderImage: UIImage(named: "pexels-zachary-debottis-1838640"))
                              //https://online.softthink.co.in/ghost/Content/UploadedFile/Property/02f45f51-c785-4541-a7ed-170bee66c209.jpg
                              
                              self.localimageView.sd_setImage(with: URL(string: APIConstant.imgUrl.url.absoluteString +  self.propertyListDM.PropertyImg!), placeholderImage: UIImage(named: ""))
                              self.titleLabel.text = self.propertyListDM.PropertyName
                              self.titleLabel2.text = (self.propertyListDM.HouseNumber! as! String) + " " + self.propertyListDM.Street! + " " +  self.propertyListDM.State! + " " + (self.propertyListDM.ZipCode! as! String)
                              self.location.text = self.propertyListDM.LocationTypeName
                              self.level.text = self.propertyListDM.LevelTypeName
                              self.outletType.text = self.propertyListDM.OutletTypeName
                              self.wallcharger.text = self.propertyListDM.WallChargerTypeName
                              self.parkingLimit.text = self.propertyListDM.ParkingLimitationTypeName
                              self.hostNote.text = self.propertyListDM.HostNote?.replacingOccurrences(of: "\r\n", with: " ")
                              //self.hostNote.text?.replacingOccurrences(of: "\r\n", with: "")
                              
                          }
                                                 }
                                               else{
                                                 let alert = UIAlertController(title: "", message: parse["ResponseMessage"] as? String, preferredStyle: .alert)

                                                 alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                                                 self.present(alert, animated: true)
                                             }
                                             }
                 }catch{
                     print(error)
                 }
             }
         }
    
    }
    
}

