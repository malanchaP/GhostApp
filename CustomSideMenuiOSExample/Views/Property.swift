//
//  Property.swift
//  MobileHomesMarket
//
//  Created by APPDEV on 08/01/21.
//  Copyright © 2021 ProjectArt. All rights reserved.
//

import UIKit

class Property{
    var UserUId: String?
    var RefCompanyId: Int?
    var UserApiToken: String?
    var PropertyId: String?
    var ActionType: String?
    var PropertyDisplayId: String?
    var ProviderId: String?
    var OwnerName: String?
    var PropertyName: String?
    var Country: String?
    var State: String?
    var City: String?
    var Province: String?
    var Street: String?
    var HouseNumber: AnyObject?
    var ZipCode: AnyObject?
    var Address1: String?
    var Mobile: String?
    var EmailId: String?
    var Longitude: String?
    var Latitude: String?
    var LocationType: String?
    var LevelType: String?
    var OutletType: String?
    var WallChargerType: String?
    var ParkingLimitationType: String?
    var HostNote: String?
    var REMARKS: String?
    var PropertyImg: String?
    var Status: String?
    var CreationDate: String?
    var CountryName: String?
    var StateName: String?
    var CityName: String?
    var ProvinceName: String?
    var LocationTypeName: String?
    var LevelTypeName: String?
    var OutletTypeName: String?
    var WallChargerTypeName: String?
    var ParkingLimitationTypeName: String?
    var RegistrationBasicData: String?
    var MarkerImg:String?
    var distance:Double?
    }


    extension Property {
    static func transformToList(dict: [String: Any]) -> Property{
        
        let blockDM = Property()
        
        blockDM.PropertyId = dict["PropertyId"] as? String
        blockDM.Latitude = dict["Latitude"] as? String
        blockDM.Longitude = dict["Longitude"] as? String
        blockDM.PropertyImg = dict["PropertyImg"] as? String
        blockDM.MarkerImg = dict["MarkerImg"] as? String
        blockDM.PropertyName = dict["PropertyName"] as? String
        blockDM.HouseNumber = dict["HouseNumber"] as AnyObject?
        blockDM.ZipCode = dict["ZipCode"] as? AnyObject
        blockDM.ParkingLimitationTypeName = dict["ParkingLimitationTypeName"] as? String
        blockDM.LevelTypeName = dict["LevelTypeName"] as? String
        blockDM.OutletTypeName = dict["OutletTypeName"] as? String
        blockDM.StateName = dict["StateName"] as? String
        blockDM.WallChargerTypeName = dict["WallChargerTypeName"] as? String
        blockDM.LocationTypeName = dict["LocationTypeName"] as? String
        blockDM.HostNote = dict["HostNote"] as? String
        blockDM.Address1 = dict["Address1"] as? String
        blockDM.CityName = dict["CityName"] as? String
        blockDM.Street = dict["Street"] as? String
        blockDM.State = dict["State"] as? String
        return blockDM
    }
    }

