//
//  ScannerViewController.swift
//  GhostApp
//
//  Created by Malancha Poddar on 27/12/21.
//

import UIKit
import AVFoundation
import SwiftLoader
class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var from = ""
    var chargingId = ""
    var scanned = false
    var propertyid = ""
    var ticketId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        var config : SwiftLoader.Config = SwiftLoader.Config()
          config.size = 150
          config.spinnerColor = .green
          config.foregroundColor = .gray
          config.foregroundAlpha = 0.5

          SwiftLoader.setConfig(config)
       
        let CustomerId = UserDefaults.standard.string(forKey: "CustomerId")!
        chargingId = "Order1234Prop5678\(CustomerId)"
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }

    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        if from == "detail"{
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
//            nextViewController.chargingId = chargingId
//            nextViewController.modalPresentationStyle = .fullScreen
//            self.navigationController?.pushViewController(nextViewController, animated: true)
            SwiftLoader.show(animated: true)
           purchaseTicket()
        }
        else{
            SwiftLoader.show(animated: true)
           closeTicket()
        }
      
        
        
        
       
        //dismiss(animated: true)
    }

    func found(code: String) {
        scanned = true
        print(code)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    func purchaseTicket(){
        let CustomerId = UserDefaults.standard.string(forKey: "CustomerId")!
        let UserApiToken = UserDefaults.standard.string(forKey: "UserApiToken")
        ApIService().PurchaseTicketAPI(UserUId: CustomerId, UserApiToken: UserApiToken!, CustomerId: CustomerId, PropertyId: propertyid){ (data, error) in
            SwiftLoader.hide()
                       if error != nil{
                           print("Error \(String(describing: error?.localizedDescription))")
                       }else{
                           do {
                               let parse = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                               print(parse)
                             
                               if let resp = parse["PurchaseTicketResponseData"] as? [String:Any]{
                                   let ResponseFlag = resp["ResponseFlag"] as? Bool//{
                                   let ResponseMessage = resp["ResponseMessage"] as? String
                                   if ResponseFlag == true{
                                       
                                       let TicketId = resp["TicketId"] as? String
                                       let TicketDisplayId = resp["TicketDisplayId"] as? String
                                       let dialogMessage = UIAlertController(title: "Success", message: ResponseMessage, preferredStyle: .alert)

                                       // Create OK button with action handler
                                       let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                                           print("Ok button tapped")
                                           let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                           let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TicketViewController") as! TicketViewController
                                           nextViewController.ticketId = TicketId!
                                           nextViewController.ticketdisplayid = TicketDisplayId!
                                           nextViewController.propertyid = self.propertyid
                                           nextViewController.modalPresentationStyle = .fullScreen
                                           self.navigationController?.pushViewController(nextViewController, animated: true)
                                       })

                                    

                                       //Add OK and Cancel button to an Alert object
                                       dialogMessage.addAction(ok)
                                       //dialogMessage.addAction(cancel)

                                       // Present alert message to user
                                       self.present(dialogMessage, animated: true, completion: nil)
                                       
                                   }
                                   else{
                                       let dialogMessage = UIAlertController(title: "Error", message: ResponseMessage, preferredStyle: .alert)

                                       // Create OK button with action handler
                                       let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                                           print("Ok button tapped")
                                           
                                       })

                                    

                                       //Add OK and Cancel button to an Alert object
                                       dialogMessage.addAction(ok)

                                       // Present alert message to user
                                       self.present(dialogMessage, animated: true, completion: nil)
                                   }
                                   
                               }
                              
                           }catch{
                               print(error)
                           }
                       }
                   }
    }
    
    
    
    func closeTicket(){
        let CustomerId = UserDefaults.standard.string(forKey: "CustomerId")!
        let UserApiToken = UserDefaults.standard.string(forKey: "UserApiToken")
        ApIService().CloseTicketAPI(UserUId: CustomerId, UserApiToken: UserApiToken!, CustomerId: CustomerId, PropertyId: propertyid, TicketId: ticketId){ (data, error) in
            SwiftLoader.hide()
                       if error != nil{
                           print("Error \(String(describing: error?.localizedDescription))")
                       }else{
                           do {
                               let parse = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                               print(parse)
                             
                               if let resp = parse["TicketResponseData"] as? [String:Any]{
                                   let ResponseFlag = resp["ResponseFlag"] as? Bool//{
                                   let ResponseMessage = resp["ResponseMessage"] as? String
                                   if ResponseFlag == true{
                                       let ResponseMessage = resp["ResponseMessage"] as? String
                                       let TicketId = resp["TicketId"] as? String
                                       let TicketDisplayId = resp["TicketDisplayId"] as? String
                                       let dialogMessage = UIAlertController(title: "Success", message: ResponseMessage, preferredStyle: .alert)

                                       // Create OK button with action handler
                                       let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                                           print("Ok button tapped")
                                           let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                           let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ThanksViewController") as! ThanksViewController
                                           nextViewController.modalPresentationStyle = .fullScreen
                                           self.present(nextViewController, animated: true, completion: nil)
                                       })

                                    

                                       //Add OK and Cancel button to an Alert object
                                       dialogMessage.addAction(ok)
                                       //dialogMessage.addAction(cancel)

                                       // Present alert message to user
                                       self.present(dialogMessage, animated: true, completion: nil)
                                       
                                   //}
                               }
                               else{
                                   let dialogMessage = UIAlertController(title: "Error", message: ResponseMessage, preferredStyle: .alert)

                                   // Create OK button with action handler
                                   let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                                       print("Ok button tapped")
                                       
                                   })

                                

                                   //Add OK and Cancel button to an Alert object
                                   dialogMessage.addAction(ok)

                                   // Present alert message to user
                                   self.present(dialogMessage, animated: true, completion: nil)
                               }
                               }
                              
                           }catch{
                               print(error)
                           }
                       }
                   }
    }
}
