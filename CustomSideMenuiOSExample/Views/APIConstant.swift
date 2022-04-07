//
//  APIConstant.swift
//  RightBack
//
//  Created by APPDEV on 19/08/20.
//  Copyright © 2020 APPDEV. All rights reserved.
//


import Foundation

enum APIConstant {
    case apiUrl
    case imgUrl

    ////--------------------Production-------------------------
    var url: URL {
        switch self {
        case .apiUrl:
            //return URL(string: "https://www.bgranalytics.com/mobile_homes/rest-api-post/index.php/")!
            return URL(string: "https://online.softthink.co.in/ghost/API/")!
            
        case .imgUrl:
            return URL(string: "https://online.softthink.co.in/ghost/")!
        }
    }
    static func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    static var appName = Bundle.main.infoDictionary!["CFBundleName"] as! String
}



struct generate {
    static func getLoactionImageUrl(lat: String, lng: String) -> String{
        let combineLatLngString = "\(lat),\(lng)"
        return "https://maps.googleapis.com/maps/api/staticmap?center=\(combineLatLngString)&zoom=15&size=700x500&maptype=roadmap&markers=color:red%7C\(combineLatLngString)&key=AIzaSyCfy4A8zPY6kFoHkBAe1IXn7t5FPoK9EUY"
    }
}
