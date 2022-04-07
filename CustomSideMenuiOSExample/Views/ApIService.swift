//
//  ApIService.swift
//  RightBack
//
//  Created by APPDEV on 19/08/20.
//  Copyright © 2020 APPDEV. All rights reserved.
//

import UIKit

class ApIService:URLSessionDataTask,URLSessionDelegate,URLSessionDataDelegate {

var taskObj:URLSessionDataTask!
var request : NSMutableURLRequest!
var totalConnectionPhoneArray:[Any] = []
var totalConnectionEmailArray:[Any] = []
var finalJsonArrayofContacts : NSMutableArray = NSMutableArray()


/// MARK: Call Get Api...
func callGetApi(withUrl urlString: String, withHeaders dictHeaders: [AnyHashable: Any]?, withCompletionHandlor completionHandlor: @escaping (_ data: Data?, _ error: Error?) -> Void){
    
    guard let url = URL(string: urlString) else {
        print("error..")
        return
    }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    // urlRequest.timeoutInterval = 60.0
    
    if dictHeaders != nil { // add headers..
        urlRequest.allHTTPHeaderFields = dictHeaders as? [String : String]
    }
    
    // make the request..
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        DispatchQueue.main.async(execute: {() -> Void in
            completionHandlor(data,error)
        })
    }
    task.resume()
    
}

///MARK: Call Post Api...
func callPostApi(withUrl urlString: String, withParam paramDict: NSDictionary, withHeaders headerDict:[AnyHashable: Any]?, withCompletionHandlor completionHandlor:@escaping (_ data: Data?, _ error: Error?) -> Void) {
    
    
    
    guard let url = URL(string: urlString) else { // for Url
        print("Error")
        return
    }
    
    guard let httpBody = try? JSONSerialization.data(withJSONObject: paramDict, options: .prettyPrinted) else { // for param..
        return
    }
    
    var urlRequest = URLRequest(url:url)
    urlRequest.httpMethod = "POST"
    // urlRequest.timeoutInterval = 120.0
    urlRequest.httpBody = httpBody
    
    if headerDict != nil { // add headers..
        urlRequest.allHTTPHeaderFields = headerDict as? [String : String]
    }
    
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        DispatchQueue.main.async(execute: {
            completionHandlor(data,error)
        })
    }
    
    task.resume()
    
}


///MARK: -------- Change Password API -------
typealias completionHandlerAlies = (_ data: Data?, _ error: Error?) -> Void

    

    func registrationAPI(firstname:String,lastname: String,address:String,username: String,password:String,BrandName:String,ModelName:String, LicencePlate: String, Year:String,BillingAddress:String,CardNo:String,NameOnCard:String,ExpDate:String,Security:String, email:String, mobile:String, Country:String, completionHandler : @escaping completionHandlerAlies){
        
        let param : [String: Any] = ["RegistrationData":["UserUId": "",
                                     "RefCompanyId": 0,
                                     "CustomerId": "",
                                     "CustomerInfo": [
                                         "UserUId": "",
                                         "RefCompanyId": 0,
                                         "CustomerId": "",
                                         "FirstName": firstname,
                                         "LastName": lastname,
                                         "Address1": address,
                                         "EmailId": email,
                                         "Mobile": mobile,
                                         "UserName": username,
                                         "Password": password,
                                         "Country": Country
                                     ],
                                     "CustomerCarInfo": [
                                         "UserUId": "",
                                         "RefCompanyId": 0,
                                         "CustomerId": "",
                                         "InfoId": "",
                                         "UserApiToken": "",
                                         "ActionType": "",
                                         "BrandName": BrandName,
                                         "ModelName": ModelName,
                                         "LicencePlate": LicencePlate,
                                         "Year": Year,
                                         "OtherInfo": ""
                                     ],
                                     "CustomerBillingInfo": [
                                         "UserUId": "",
                                         "RefCompanyId": 0,
                                         "CustomerId": "",
                                         "InfoId": "",
                                         "UserApiToken": "",
                                         "ActionType": "",
                                         "CardNo": CardNo,
                                         "NameOnCard": NameOnCard,
                                         "ExpDate": ExpDate,
                                         "Security": Security,
                                         "BillingAddress": BillingAddress
                                     ]
                                 
        ]]
        print(param,APIConstant.apiUrl)
       
        callPostApi(withUrl:  "\(APIConstant.apiUrl.url.absoluteString)Customer/Registration", withParam: param as NSDictionary, withHeaders: ["content-type": "application/json"]) { (data, error) in
            if error != nil{
                completionHandler(nil, error)
            }else{
                completionHandler(data, error)
            }
        }
    }
    
   
    func loginAPI(LoginId: String,pass:String, completionHandler : @escaping completionHandlerAlies){
        
        let param : [String: Any] = ["LoginData" : ["LoginId": LoginId,
                                         "Password": pass,
                                         "UserType": "Customer",
                                         "UserIpAddress": "",
                                         "UserDevice": ""
                                        
           ]]
      
           print(param,APIConstant.apiUrl)
           callPostApi(withUrl:  "\(APIConstant.apiUrl.url.absoluteString)Customer/Login", withParam: param as NSDictionary, withHeaders: ["content-type": "application/json"]) { (data, error) in
               if error != nil{
                   completionHandler(nil, error)
               }else{
                   completionHandler(data, error)
               }
           }
       }
    
    func updateCustomerAPI(UserUId:String,CustomerId: String,address:String,username: String,password:String,firstname:String,lastname:String,email:String, mobile:String,Country:String, completionHandler : @escaping completionHandlerAlies){
        
        let param : [String: Any] = ["CustomerInfoData":["UserUId": UserUId,
                                     "RefCompanyId": 0,
                                     "CustomerId": CustomerId,
                                         "FirstName": firstname,
                                         "LastName": lastname,
                                         "Address1": address,
                                         "EmailId": email,
                                         "Mobile": mobile,
                                         "UserName": username,
                                         "Password": password,
                                        "Country": Country
                                     ]
                                 
        ]
        print(param,APIConstant.apiUrl)
       
        callPostApi(withUrl:  "\(APIConstant.apiUrl.url.absoluteString)Customer/UpdateCustomerInfo", withParam: param as NSDictionary, withHeaders: ["content-type": "application/json"]) { (data, error) in
            if error != nil{
                completionHandler(nil, error)
            }else{
                completionHandler(data, error)
            }
        }
    }
    
    func updateCarAPI(UserUId:String,CustomerId: String,BrandName:String,ModelName: String,LicencePlate:String,year:String,InfoId : String ,ActionType:String,completionHandler : @escaping completionHandlerAlies){
       
        let param : [String: Any] = ["CustomerCarInfoData":["UserUId": UserUId,
                                     "RefCompanyId": 0,
                                     "CustomerId": CustomerId,
                                                "InfoId":InfoId,
                                                "UserApiToken":"","ActionType":ActionType,"BrandName":BrandName,"ModelName":ModelName,"LicencePlate":LicencePlate,"Year":year,
                                                    "OtherInfo":""
                                     ]
                                 
        ]
        print(param,APIConstant.apiUrl)
       
        callPostApi(withUrl:  "\(APIConstant.apiUrl.url.absoluteString)Customer/AddUpdateCustomerCarInfo", withParam: param as NSDictionary, withHeaders: ["content-type": "application/json"]) { (data, error) in
            if error != nil{
                completionHandler(nil, error)
            }else{
                completionHandler(data, error)
            }
        }
    }
    
    
    func updateBillingAPI(UserUId:String,CustomerId: String,CardNo:String,NameOnCard: String,ExpDate:String,Security:String,BillingAddress:String, InfoId : String, ActionType:String, completionHandler : @escaping completionHandlerAlies){
        let param : [String: Any] = ["CustomerBillingInfoData":["UserUId": UserUId,
                                     "RefCompanyId": 0,
                                     "CustomerId": CustomerId,
                                                "InfoId":InfoId,
                                                "UserApiToken":"","ActionType":ActionType,"CardNo":CardNo,"NameOnCard":NameOnCard,"ExpDate":ExpDate,"Security":Security,
                                                    "BillingAddress":BillingAddress
                                     ]
                                 
        ]
        print(param,APIConstant.apiUrl)
       
        callPostApi(withUrl:  "\(APIConstant.apiUrl.url.absoluteString)Customer/AddUpdateCustomerBillingInfo", withParam: param as NSDictionary, withHeaders: ["content-type": "application/json"]) { (data, error) in
            if error != nil{
                completionHandler(nil, error)
            }else{
                completionHandler(data, error)
            }
        }
    }
    
    func fetchPropertyListAPI(UserUId:String,UserApiToken: String,completionHandler : @escaping completionHandlerAlies){
        let param : [String: Any] = ["PropertyFilter":[ "UserUId": UserUId,
                                                                 "UserApiToken": UserApiToken,
                                                                 "ZipCode": "",
                                                                 "FromDate": "",
                                                                 "ToDate": ""
                                     ]
                                 
        ]
        print(param,APIConstant.apiUrl)
       
        callPostApi(withUrl:  "\(APIConstant.apiUrl.url.absoluteString)Property/FetchPropertyList", withParam: param as NSDictionary, withHeaders: ["content-type": "application/json"]) { (data, error) in
            if error != nil{
                completionHandler(nil, error)
            }else{
                completionHandler(data, error)
            }
        }
    }
    
    func FetchPropertyInfoAPI(UserUId:String,UserApiToken: String,PropertyId:String, completionHandler : @escaping completionHandlerAlies){
        let param : [String: Any] = [
            "PropertyId": PropertyId,
            "UserApiToken": UserApiToken,
            "UserUId": UserUId
        ]
       
        callPostApi(withUrl:  "\(APIConstant.apiUrl.url.absoluteString)Property/FetchPropertyInfo", withParam: param as NSDictionary, withHeaders: ["content-type": "application/json"]) { (data, error) in
            if error != nil{
                completionHandler(nil, error)
            }else{
                completionHandler(data, error)
            }
        }
    }
    
    
    func SendOTPAPI(mobile:String,actiontype: String,completionHandler : @escaping completionHandlerAlies){
        let param : [String: Any] = [
            "MobileNo":mobile,"Action":actiontype
        ]
       
        callPostApi(withUrl:  "\(APIConstant.apiUrl.url.absoluteString)Customer/SendOTP", withParam: param as NSDictionary, withHeaders: ["content-type": "application/json"]) { (data, error) in
            if error != nil{
                completionHandler(nil, error)
            }else{
                completionHandler(data, error)
            }
        }
    }
    
    func VerifyOTPAPI(mobile:String,OTP: String,completionHandler : @escaping completionHandlerAlies){
        let param : [String: Any] = [
            "MobileNo":mobile,"OTP":OTP
        ]
       
        callPostApi(withUrl:  "\(APIConstant.apiUrl.url.absoluteString)Customer/VerifyOTP", withParam: param as NSDictionary, withHeaders: ["content-type": "application/json"]) { (data, error) in
            if error != nil{
                completionHandler(nil, error)
            }else{
                completionHandler(data, error)
            }
        }
    }
    
    func ResetPasswordAPI(UserUId:String,UserApiToken: String,NewPassword:String, completionHandler : @escaping completionHandlerAlies){
        let param : [String: Any] = [
            "UserUId":UserUId,"UserApiToken":UserApiToken,"NewPassword":NewPassword
        ]
       
        callPostApi(withUrl:  "\(APIConstant.apiUrl.url.absoluteString)Customer/ResetPassword", withParam: param as NSDictionary, withHeaders: ["content-type": "application/json"]) { (data, error) in
            if error != nil{
                completionHandler(nil, error)
            }else{
                completionHandler(data, error)
            }
        }
    }
    
    func PurchaseTicketAPI(UserUId:String,UserApiToken: String,CustomerId:String,PropertyId:String, completionHandler : @escaping completionHandlerAlies){
        let param : [String: Any] = [
                "UserUId":UserUId,
                "UserApiToken":UserApiToken,
                "CustomerId": CustomerId,
                "PropertyId": PropertyId,
                "PurchaseStatus": "1"
        ]
       
        callPostApi(withUrl:  "\(APIConstant.apiUrl.url.absoluteString)Customer/PurchaseTicket", withParam: param as NSDictionary, withHeaders: ["content-type": "application/json"]) { (data, error) in
            if error != nil{
                completionHandler(nil, error)
            }else{
                completionHandler(data, error)
            }
        }
    }
    
    
    func CloseTicketAPI(UserUId:String,UserApiToken: String,CustomerId:String,PropertyId:String,TicketId:String, completionHandler : @escaping completionHandlerAlies){
        let param : [String: Any] = [
                "UserUId":UserUId,
                "UserApiToken":UserApiToken,
                "CustomerId": CustomerId,
                "PropertyId": PropertyId,
                "TicketId":TicketId
        ]
       
        callPostApi(withUrl:  "\(APIConstant.apiUrl.url.absoluteString)Customer/CloseTicket", withParam: param as NSDictionary, withHeaders: ["content-type": "application/json"]) { (data, error) in
            if error != nil{
                completionHandler(nil, error)
            }else{
                completionHandler(data, error)
            }
        }
    }
    
    
    func FetchTicketListAPI(UserUId:String,UserApiToken: String,CustomerId:String, completionHandler : @escaping completionHandlerAlies){
        let param : [String: Any] = [
                "UserUId":UserUId,
                "UserApiToken":UserApiToken,
                "CustomerId": CustomerId
        ]
       
        callPostApi(withUrl:  "\(APIConstant.apiUrl.url.absoluteString)Customer/FetchTicketList", withParam: param as NSDictionary, withHeaders: ["content-type": "application/json"]) { (data, error) in
            if error != nil{
                completionHandler(nil, error)
            }else{
                completionHandler(data, error)
            }
        }
    }
    
}
