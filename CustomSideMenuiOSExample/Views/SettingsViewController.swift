//
//  SettingsViewController.swift
//  CustomSideMenuiOSExample
//
//  Created by John Codeos on 2/9/21.
//

import UIKit
import GoogleMaps
import SDWebImage

class SettingsViewController: UIViewController, CLLocationManagerDelegate,GMSMapViewDelegate {
    @IBOutlet weak var googleMap: GMSMapView!
    let locationManager = CLLocationManager()
    
    var marker = GMSMarker()
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    var propertyListDM = [Property]()
//    var markerImage = UIImage()
//    var markerView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleMap.delegate = self
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
          self.navigationController!.navigationBar.shadowImage = UIImage()
          self.navigationController!.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor.black//UIColor(red: 116.0/255.0, green: 225.0/255.0, blue: 117.0/255.0, alpha: 1.0)
        sideMenuBtn.target = self.revealViewController()
        sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.requestAlwaysAuthorization()
                locationManager.distanceFilter = 50
                locationManager.startUpdatingLocation()
        locationManager.delegate = self

        if CLLocationManager.locationServicesEnabled(){
            locationManager.requestLocation()
        }
        else{
            locationManager.requestWhenInUseAuthorization()
        }
       
//        googleMap.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)! , longitude: (locationManager.location?.coordinate.longitude)!), zoom: 17,
//                                            bearing: 0,
//                                             viewingAngle:0)
//       
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        //marker.position = CLLocationCoordinate2D(latitude: 40.8040, longitude: -73.9566)
        marker.title = "current"
        marker.snippet = ""

        marker.map = googleMap
       // googleMap.isMyLocationEnabled = true
        //googleMap.setMinZoom(14, maxZoom: 20)
        googleMap.settings.compassButton = true
        googleMap.isMyLocationEnabled = true
        googleMap.settings.myLocationButton = true
        googleMap.settings.scrollGestures = true
        googleMap.settings.zoomGestures = true
        googleMap.settings.rotateGestures = true
        googleMap.settings.tiltGestures = true
        googleMap.isIndoorEnabled = false
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus{
        case.authorizedAlways:
            return
        case.authorizedWhenInUse:
            return
        case.denied:
            return
        case.restricted:
            locationManager.requestWhenInUseAuthorization()
        case.notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
//        if (String(locationManager.location?.coordinate.longitude).contains("22.0"))  {
//
//        }
        
//        let London = GMSMarker()
//        London.position = CLLocationCoordinate2DMake(40.789290, -73.948740)
//        London.title = "loc1"
//        London.snippet = "....."
//        London.map = googleMap
//        let markerImage = UIImage(named: "L1")!
//        let markerView = UIImageView(image: markerImage)
//        London.iconView = markerView
//        let London1 = GMSMarker()
//        London1.position = CLLocationCoordinate2DMake(31.761490, -95.629330)
//        London1.title = "loc2"
//        London1.snippet = "....."
//        let markerImage2 = UIImage(named: "L1")!
//        let markerView2 = UIImageView(image: markerImage2)
//        London1.iconView = markerView2
//        London1.map = googleMap
//        let London3 = GMSMarker()
//        London3.position = CLLocationCoordinate2DMake(40.728980, -73.949070)
//        London3.title = "loc2"
//        London3.snippet = "....."
//        let markerImage3 = UIImage(named: "L2")!
//        let markerView3 = UIImageView(image: markerImage3)
//        London3.iconView = markerView3
//        London3.map = googleMap
//        let London4 = GMSMarker()
//        London4.position = CLLocationCoordinate2DMake(40.803060, -74.091300)
//        London4.title = "loc2"
//        London4.snippet = "....."
//        let markerImage4 = UIImage(named: "L2")!
//        let markerView4 = UIImageView(image: markerImage4)
//        London4.iconView = markerView4
//        London4.map = googleMap
//        let London5 = GMSMarker()
//        London5.position = CLLocationCoordinate2DMake(42.301340, -74.227680)
//        let markerImage5 = UIImage(named: "L1")!
//        let markerView5 = UIImageView(image: markerImage5)
//        London5.iconView = markerView5
//        London5.map = googleMap
//        let London6 = GMSMarker()
//        London6.position = CLLocationCoordinate2DMake(40.803470, -73.957290)
//        let markerImage6 = UIImage(named: "L1")!
//        let markerView6 = UIImageView(image: markerImage6)
//        London6.iconView = markerView6
//        London6.map = googleMap
//        let London7 = GMSMarker()
//        London7.position = CLLocationCoordinate2DMake(40.8020, -73.9574)
//        let markerImage7 = UIImage(named: "L1")!
//        let markerView7 = UIImageView(image: markerImage7)
//        London7.iconView = markerView7
//        London7.map = googleMap
//        let London8 = GMSMarker()
//        London8.position = CLLocationCoordinate2DMake(41.9196, -87.6801)
//        let markerImage8 = UIImage(named: "L1")!
//        let markerView8 = UIImageView(image: markerImage8)
//        London8.iconView = markerView8
//        London8.map = googleMap
//        let London9 = GMSMarker()
//        London9.position = CLLocationCoordinate2DMake(40.8040, -73.9566)
//        let markerImage9 = UIImage(named: "L1")!
//        let markerView9 = UIImageView(image: markerImage9)
//        London9.iconView = markerView9
//        London9.map = googleMap
//        let London10 = GMSMarker()
//        London10.position = CLLocationCoordinate2DMake(40.6775, -74.0116)
//        let markerImage10 = UIImage(named: "L1")!
//        let markerView10 = UIImageView(image: markerImage10)
//        London10.iconView = markerView10
//        London10.map = googleMap
       fetchproperty()

    }
    @objc
    func buttonAction() {
        print("Button pressed")
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("You tapped : \(marker.position.latitude),\(marker.position.longitude)")
        let position = marker.position.self
                
            let markerData = marker.userData
       // let hhh = propertyListDM[marker.]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ChargerListViewController") as! ChargerListViewController
        nextViewController.modalPresentationStyle = .fullScreen
        nextViewController.lat = marker.position.latitude
        nextViewController.lng = marker.position.longitude
        self.navigationController?.pushViewController(nextViewController, animated: true)
        return true // or false as needed.
    }
    
    func fetchproperty(){
        let id = UserDefaults.standard.string(forKey: "CustomerId")
        let UserApiToken = UserDefaults.standard.string(forKey: "UserApiToken")
        
        ApIService().fetchPropertyListAPI(UserUId: id!, UserApiToken: UserApiToken!){ (data, error) in
   
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
                                      let London10 = GMSMarker()
                                     
                                      London10.position = CLLocationCoordinate2DMake(Double(servicDMObj.Latitude!)!, Double(servicDMObj.Longitude!)!)
                                              let markerImage10 = UIImage(named: "L1")!
                                              let markerView10 = UIImageView(image: markerImage10)
                                      markerView10.sd_setImage(with: URL(string: APIConstant.imgUrl.url.absoluteString +  servicDMObj.MarkerImg!), placeholderImage: UIImage(named:"L1"))
                                            London10.iconView = markerView10
                                      London10.title = servicDMObj.PropertyName
                                      London10.map = self.googleMap
                                      self.propertyListDM.append(servicDMObj)
                                                                          
                                  }
                                  DispatchQueue.main.async { [self] in // load table
                                   
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
}
