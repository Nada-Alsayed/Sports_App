//
//  ViewController.swift
//  SportyX
//
//  Created by MAC on 20/05/2023.
//

import UIKit
//import Lottie

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("HI")
        DispatchQueue.main.asyncAfter(deadline: .now()+2){
            let Home = self.storyboard?.instantiateViewController(withIdentifier: "1") as! UITabBarController
            Home.modalPresentationStyle = .fullScreen
         //   self.performSegue(withIdentifier: "Home", sender: nil)
            self.present(Home, animated: true, completion: nil)
        }
      
    }


}

