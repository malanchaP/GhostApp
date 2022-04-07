//
//  ChargerListViewController.swift
//  GhostApp
//
//  Created by APPDEV on 26/12/21.
//

import UIKit
import SwiftLoader
import GoogleMaps
class ChargerListViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    var propertyListDM = [Property]()
    var propertyid = ""
    var lat = 0.0
    var lng = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        print(lat,lng)
        var config : SwiftLoader.Config = SwiftLoader.Config()
          config.size = 150
          config.spinnerColor = .green
          config.foregroundColor = .gray
          config.foregroundAlpha = 0.5

          SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
        fetchproperty()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propertyListDM.count
       }
           
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                    for: indexPath) as? ChargerListTableViewCell
//           if indexPath.row == 1{
//               cell?.maskvw.isHidden = false
//           }
           let property = propertyListDM[indexPath.row]
           var citynm = ""
           if property.Street != nil{
               citynm = property.Street ?? ""
           }
           else{
               citynm = ""
           }
           var stnm = ""
           if property.State != nil{
               stnm = property.State ?? ""
           }
           else{
               stnm = ""
           }
           cell?.localimageView.sd_setImage(with: URL(string: APIConstant.imgUrl.url.absoluteString + property.PropertyImg!), placeholderImage: UIImage(named: ""))
           cell?.location.text = property.LocationTypeName!
           cell?.level.text = property.LevelTypeName!
           cell?.outletType.text = property.OutletTypeName!
           cell?.parkingLimit.text = property.ParkingLimitationTypeName!
           cell?.titleLabel.text = (property.HouseNumber! as! String) + " " + citynm + " " + stnm + " " + (property.ZipCode! as! String)
           cell?.titleLbl.text = property.PropertyName
        cell?.cellbtn.tag = indexPath.row
        cell?.cellbtn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
           cell?.directionbtn.tag = indexPath.row
           cell?.directionbtn.addTarget(self, action: #selector(getdirectionbtnbuttonTapped), for: .touchUpInside)
           if Double(property.Latitude!) != self.lat {
               cell?.maskvw.isHidden = false
           }
           else{
               cell?.maskvw.isHidden = true
           }

        return cell!
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 475.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        var superview = sender.superview
           while let view = superview, !(view is UITableViewCell) {
               superview = view.superview
           }
           guard let cell = superview as? UITableViewCell else {
               print("button is not contained in a table view cell")
               return
           }
           guard let indexPath = tableView.indexPath(for: cell) else {
               print("failed to get index path for cell containing button")
               return
           }
           // We've got the index path for the cell that contains the button, now do something with it.
           print("button is in row \(indexPath.row)")
        let property = propertyListDM[indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ChargerListDetailsViewController") as! ChargerListDetailsViewController
        nextViewController.propertyid = property.PropertyId!
        nextViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func getdirectionbtnbuttonTapped(_ sender: UIButton) {
        var superview = sender.superview
           while let view = superview, !(view is UITableViewCell) {
               superview = view.superview
           }
           guard let cell = superview as? UITableViewCell else {
               print("button is not contained in a table view cell")
               return
           }
           guard let indexPath = tableView.indexPath(for: cell) else {
               print("failed to get index path for cell containing button")
               return
           }
           // We've got the index path for the cell that contains the button, now do something with it.
           print("button is in row \(indexPath.row)")
        let property = propertyListDM[indexPath.row].Latitude
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ChargerListDetailsViewController") as! ChargerListDetailsViewController
//        nextViewController.propertyid = property.PropertyId!
//        nextViewController.modalPresentationStyle = .fullScreen
//        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
    }
    
    
    func fetchproperty(){
        let id = UserDefaults.standard.string(forKey: "CustomerId")
        let UserApiToken = UserDefaults.standard.string(forKey: "UserApiToken")
        
        ApIService().fetchPropertyListAPI(UserUId: id!, UserApiToken: UserApiToken!){ (data, error) in
            SwiftLoader.hide()
             if error != nil{
              
                 print("Error \(String(describing: error?.localizedDescription))")
             }else{
                 do {
                     let parse = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                   
                     print(parse)
                   
                  if let status = parse["ResponseFlag"] as? Bool{
                      if status == true{
                                                    
                          if let data = parse["PropertyList"] as? [[String: AnyObject]] {
                              if data.count > 0{
                                  for dat in data{ // insert into DM
                                                                                      
                                      let servicDMObj = Property.transformToList(dict: dat)
                                      let startLocation = CLLocation(latitude: self.lat, longitude: self.lng)
                                      let endLocation = CLLocation(latitude: Double(servicDMObj.Latitude!)!, longitude: Double(servicDMObj.Longitude!)!)
                                       let distance: CLLocationDistance = startLocation.distance(from: endLocation)
                                      servicDMObj.distance = Double(distance)/1000
                                      if self.lat == Double(servicDMObj.Latitude!)! || distance/1000 <= 5 {
                                          self.propertyListDM.append(servicDMObj)
                                         
                                         
                                      }
                                  }
                                  DispatchQueue.main.async { [self] in // load table
                                      let sortedprop = propertyListDM.sorted(by: {$0.distance! < $1.distance!})
                                      propertyListDM = sortedprop
                                      self.tableView.reloadData()
                                  }

                              }
                                  else{ // when array count is 0

                                  DispatchQueue.main.async {
                                      print("Nothing===========")
                                  

                                                              }
                                                          }
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

    
    
//    var arrayName = ["Malancha", "mallika", "mickle", "Arnab"]
//
//       
//            let previousPaveValue = "Arnab"
//            let indexOfSearchedPlace = arrayName.firstIndex(of: previousPaveValue)
//            arrayName.remove(at: indexOfSearchedPlace!)
//            arrayName.insert(previousPaveValue, at: 0)
            
        
}
