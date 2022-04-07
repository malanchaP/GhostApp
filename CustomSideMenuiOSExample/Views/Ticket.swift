//
//  Ticket.swift
//  GhostApp
//
//  Created by Malancha Poddar on 06/04/22.
//

import UIKit

class Ticket{
    
    var UserUId: String?
    var RefCompanyId: Int?
    var UserApiToken: String?
    var TicketId: String?
    var TicketDisplayId: String?
    var CustomerId: String?
    var PropertyId: String?
    var PurchaseStatus: String?
    var LocationType: String?
    var CountryName: String?
    var StateName: String?
    var CityName: String?
    var PropertyName: String?
    var Street: String?
    var HouseNumber: String?
    var ZipCode: String?
    var Address1: String?
    var LevelType: String?
    var OutletType: String?
    var WallChargerType: String?
    var ParkingLimitationType: String?
    var TicketStatus: String?
    var TicketPurchasedOn: String?
    var TicketClosedOn: String?
    var CustomerName: String?
   
  
    }


    extension Ticket {
    static func transformToList(dict: [String: Any]) -> Ticket{
        
        let blockDM = Ticket()
        
        blockDM.PropertyId = dict["PropertyId"] as? String
        blockDM.TicketId = dict["TicketId"] as? String
        blockDM.TicketDisplayId = dict["TicketDisplayId"] as? String
        blockDM.CustomerId = dict["CustomerId"] as? String
        blockDM.PurchaseStatus = dict["PurchaseStatus"] as? String
        blockDM.LocationType = dict["LocationType"] as? String
        blockDM.LevelType = dict["LevelType"] as? String
        blockDM.OutletType = dict["OutletType"] as? String
        blockDM.WallChargerType = dict["WallChargerType"] as? String
        blockDM.ParkingLimitationType = dict["ParkingLimitationType"] as? String
        blockDM.TicketStatus = dict["TicketStatus"] as? String
        blockDM.TicketPurchasedOn = dict["TicketPurchasedOn"] as? String
        blockDM.TicketClosedOn = dict["TicketClosedOn"] as? String
        blockDM.CustomerName = dict["CustomerName"] as? String
        blockDM.PropertyName = dict["PropertyName"] as? String
        blockDM.CountryName = dict["CountryName"] as? String
        blockDM.StateName = dict["StateName"] as? String
        blockDM.CityName = dict["CityName"] as? String
        blockDM.Street = dict["Street"] as? String
        blockDM.HouseNumber = dict["HouseNumber"] as? String
        blockDM.ZipCode = dict["ZipCode"] as? String
       
        return blockDM
    }
    }

