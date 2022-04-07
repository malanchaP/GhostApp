//
//  MusicViewController.swift
//  CustomSideMenuiOSExample
//
//  Created by John Codeos on 2/9/21.
//

import UIKit
import SwiftLoader

class MusicViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet var view1: UIView!
    @IBOutlet var activvw: UIView!
    @IBOutlet var cmpltvw: UIView!
    @IBOutlet var activeBtn: UIButton!
    @IBOutlet var cmpltBtn: UIButton!
    var ticketListDM = [Ticket]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .systemGreen
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
//        view1.layer.cornerRadius = 20
//        view2.layer.cornerRadius = 20
        
        var config : SwiftLoader.Config = SwiftLoader.Config()
          config.size = 150
          config.spinnerColor = .green
          config.foregroundColor = .gray
          config.foregroundAlpha = 0.5

          SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
        fetchTicket()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return ticketListDM.count
        
       
       }
           
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ActiveticketTableViewCell
           let cellDm = ticketListDM[indexPath.row]
           if cellDm.TicketStatus == "Active"{
               let dt = convertDateFormatter(date: cellDm.TicketPurchasedOn!)
               cell.titleLabel.text = dt
               cell.timeLbl.text = "Time: " + convertDateFormatter3(date: cellDm.TicketPurchasedOn!)
               cell.yearLabel.text = convertDateFormatter2(date: cellDm.TicketPurchasedOn!).uppercased()
           }
           else{
               let dt = convertDateFormatter(date: cellDm.TicketClosedOn!)
               cell.titleLabel.text = dt
               cell.timeLbl.text = "Time: " + convertDateFormatter3(date: cellDm.TicketPurchasedOn!) + " - " + convertDateFormatter3(date: cellDm.TicketClosedOn!)
               cell.yearLabel.text = convertDateFormatter2(date: cellDm.TicketClosedOn!).uppercased()
           }
           //cellDm.TicketPurchasedOn
           if ((cellDm.LevelType?.contains("Level 2")) != nil){
               cell.chrgerimg.image = UIImage(named:"L2")
           }
           else{
               cell.chrgerimg.image = UIImage(named:"L1")
           }
           
           cell.ticketLbl.text = "Ticket: " + cellDm.TicketDisplayId!
           //cellDm.TicketPurchasedOn
           cell.location.text = cellDm.PropertyName
           cell.status.text = cellDm.TicketStatus
          //cellDm.TicketPurchasedOn
           var citynm = ""
           if cellDm.Street != nil{
               citynm = cellDm.Street ?? ""
           }
           else{
               citynm = ""
           }
           var stnm = ""
           if cellDm.StateName != nil{
               stnm = cellDm.StateName ?? ""
           }
           else{
               stnm = ""
           }
           cell.address.text = (cellDm.HouseNumber! as! String) + " " + citynm + " " + stnm + " " + (cellDm.ZipCode! as! String)
           cell.cellbtn.tag = indexPath.row
           cell.cellbtn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
           return cell

       }
    @IBAction func gotoHomebtnAction(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175.0
    }
    
    
    func fetchTicket(){
        let id = UserDefaults.standard.string(forKey: "CustomerId")!
        let UserApiToken = UserDefaults.standard.string(forKey: "UserApiToken")!
        
        ApIService().FetchTicketListAPI(UserUId: id, UserApiToken: UserApiToken, CustomerId: id){ (data, error) in
            SwiftLoader.hide()
             if error != nil{
              
                 print("Error \(String(describing: error?.localizedDescription))")
             }else{
                 do {
                     let parse = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                   
                     print(parse)
                   
                  if let status = parse["ResponseFlag"] as? Bool{
                      if status == true{
                                                    
                          if let data = parse["TicketList"] as? [[String: AnyObject]] {
                              if data.count > 0{
                                  for dat in data{ // insert into DM
                                                                                      
                                      let servicDMObj = Ticket.transformToList(dict: dat)
                                      if servicDMObj.TicketStatus == "Active"{
                                          self.ticketListDM.append(servicDMObj)
                                      }
                                         
                                         
                                      
                                  }
                                  DispatchQueue.main.async { [self] in // load table
                                      if self.ticketListDM.count > 0{
                                          self.tableView.isHidden = false
                                          self.tableView.reloadData()
                                      }
                                      else{
                                          self.tableView.isHidden = true
                                      }
                                     
                                  }

                              }
                                  else{ // when array count is 0

                                  DispatchQueue.main.async {
                                      print("Nothing===========")
                                      self.tableView.isHidden = true

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
    
    
    func fetchcompleteTicket(){
        let id = UserDefaults.standard.string(forKey: "CustomerId")!
        let UserApiToken = UserDefaults.standard.string(forKey: "UserApiToken")!
        
        ApIService().FetchTicketListAPI(UserUId: id, UserApiToken: UserApiToken, CustomerId: id){ (data, error) in
            SwiftLoader.hide()
             if error != nil{
              
                 print("Error \(String(describing: error?.localizedDescription))")
             }else{
                 do {
                     let parse = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                   
                     print(parse)
                   
                  if let status = parse["ResponseFlag"] as? Bool{
                      if status == true{
                                                    
                          if let data = parse["TicketList"] as? [[String: AnyObject]] {
                              if data.count > 0{
                                  for dat in data{ // insert into DM
                                                                                      
                                      let servicDMObj = Ticket.transformToList(dict: dat)
                                      if servicDMObj.TicketStatus == "Closed"{
                                          self.ticketListDM.append(servicDMObj)
                                      }
                                         
                                         
                                      
                                  }
                                  DispatchQueue.main.async { [self] in // load table
                                      if self.ticketListDM.count > 0{
                                          self.tableView.isHidden = false
                                          self.tableView.reloadData()
                                      }
                                      else{
                                          self.tableView.isHidden = true
                                      }
                                  }

                              }
                                  else{ // when array count is 0

                                  DispatchQueue.main.async {
                                      print("Nothing===========")
                                      self.tableView.isHidden = true

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
    
    
    
    @IBAction func activebtnAction(_ sender: UIButton) {
        activvw.isHidden = false
        activeBtn.setTitleColor(.darkGray, for: .normal)
        cmpltvw.isHidden = true
        cmpltBtn.setTitleColor(.lightGray, for: .normal)
        SwiftLoader.show(animated: true)
        ticketListDM.removeAll()
        fetchTicket()
        
    }
    
    @IBAction func completebtnAction(_ sender: UIButton) {
        activvw.isHidden = true
        activeBtn.setTitleColor(.lightGray, for: .normal)
        cmpltvw.isHidden = false
        cmpltBtn.setTitleColor(.darkGray, for: .normal)
        SwiftLoader.show(animated: true)
        ticketListDM.removeAll()
        fetchcompleteTicket()
        
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
        let cellDm = ticketListDM[indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TicketViewController") as! TicketViewController
        nextViewController.from = "history"
        nextViewController.ticketDM = cellDm
        nextViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    func convertDateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm"//this your string date format
//        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
//        dateFormatter.locale = Locale(identifier: "your_loc_id")
        let convertedDate = dateFormatter.date(from: date)

        guard dateFormatter.date(from: date) != nil else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "d \r\n EEEE"///this is what you want to convert format
        //dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let timeStamp = dateFormatter.string(from: convertedDate!)

        return timeStamp
    }
    func convertDateFormatter2(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm"//this your string date format
//        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
//        dateFormatter.locale = Locale(identifier: "your_loc_id")
        let convertedDate = dateFormatter.date(from: date)

        guard dateFormatter.date(from: date) != nil else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "MMM yyyy"///this is what you want to convert format
        //dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let timeStamp = dateFormatter.string(from: convertedDate!)

        return timeStamp
    }
    
    func convertDateFormatter3(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm"//this your string date format
//        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
//        dateFormatter.locale = Locale(identifier: "your_loc_id")
        let convertedDate = dateFormatter.date(from: date)

        guard dateFormatter.date(from: date) != nil else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "hh:mm a"///this is what you want to convert format
        //dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let timeStamp = dateFormatter.string(from: convertedDate!)

        return timeStamp
    }
}
