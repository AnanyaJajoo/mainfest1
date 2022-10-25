//
//  MainScreenViewController.swift
//  userInput
//
//  Created by Ananya Jajoo on 10/7/22.
//

import Foundation
import UIKit

class MainScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            let vc: ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController ?? ViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        })
        
    }
}
