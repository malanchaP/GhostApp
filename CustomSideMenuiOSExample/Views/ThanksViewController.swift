//
//  ThanksViewController.swift
//  GhostApp
//
//  Created by Malancha Poddar on 28/12/21.
//

import UIKit

class ThanksViewController: UIViewController {
    @IBOutlet var ghostimg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ghostimg.tintColor = .green
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backbtnAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)
      
       
    }

}
