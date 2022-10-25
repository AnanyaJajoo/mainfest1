//
//  ViewController.swift
//  userInput
//
//  Created by Ananya Jajoo on 8/27/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var welcome: UILabel!
    @IBOutlet var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        btn.layer.cornerRadius  = 5
        // Do any additional setup after loading the view.
    }

    @IBAction func enterTapped(_ sender: Any) {
        //textAreaField.text = "User Name: \(userNameField.text!)\nPassword: \(passwordField.text!)\nPhone Number: \(passwordField.text!)"
        
        let vc: SecondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController ?? SecondViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)

    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension UIImage {
    static func gradientImageWithBounds(bounds: CGRect, colors: [CGColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors

        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
