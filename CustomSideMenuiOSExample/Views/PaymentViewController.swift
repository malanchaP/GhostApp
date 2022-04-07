//
//  PaymentViewController.swift
//  GhostApp
//
//  Created by Malancha Poddar on 28/12/21.
//

import UIKit
import Braintree
class PaymentViewController: UIViewController , BTViewControllerPresentingDelegate {
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    
    var braintreeClient: BTAPIClient?

    @IBOutlet var view1: UIView!
    @IBOutlet var paybtn: UIButton!
    var chargingId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        braintreeClient = BTAPIClient(authorization: "sandbox_w39nz3jn_6csmyb3kh4btfnqv")!
        view1.layer.borderWidth = 1.0
        view1.layer.borderColor = UIColor(red: 116.0/255.0, green: 225.0/255.0, blue: 117.0/255.0, alpha: 1.0).cgColor
        view1.layer.cornerRadius = 10.0
        paybtn.layer.cornerRadius = 10.0
        // Do any additional setup after loading the view.
    }
    @IBAction func paybtnAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TicketViewController") as! TicketViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nextViewController, animated: true)
        //startVault()
       
    }
    func paypalCheckout(){
        
        let payPalDriver = BTPayPalDriver(apiClient: self.braintreeClient!)

        // Specify the transaction amount here. "2.32" is used in this example.
        let request = BTPayPalCheckoutRequest(amount: "1.00")
        // Optional; see BTPayPalRequest.h for more options
        request.currencyCode = "USD"
        payPalDriver.tokenizePayPalAccount(with: request) { (tokenizedPayPalAccount, error) in
            if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                print("Got a nonce: \(tokenizedPayPalAccount.nonce)")

                // Access additional information
                let email = tokenizedPayPalAccount.email
                let firstName = tokenizedPayPalAccount.firstName
                let lastName = tokenizedPayPalAccount.lastName
                let phone = tokenizedPayPalAccount.phone

                // See BTPostalAddress.h for details
                let billingAddress = tokenizedPayPalAccount.billingAddress
                let shippingAddress = tokenizedPayPalAccount.shippingAddress
            } else if let error = error {
                // Handle error here...
            } else {
                // Buyer canceled payment approval
            }
        }
    }
    
    
    func startVault() {
            // Example: Initialize BTAPIClient, if you haven't already
            let payPalDriver = BTPayPalDriver(apiClient: braintreeClient!)
           

            let request = BTPayPalVaultRequest()
            request.billingAgreementDescription = "Your agreement description" //Displayed in customer's PayPal account
            payPalDriver.requestBillingAgreement(request) { (tokenizedPayPalAccount, error) -> Void in
                if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                    print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
                    // Send payment method nonce to your server to create a transaction
                } else if let error = error {
                    // Handle error here...
                } else {
                    // Buyer canceled payment approval
                }
            }
        }

}
