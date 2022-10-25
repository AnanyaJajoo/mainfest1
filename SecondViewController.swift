//
//  secondViewController.swift
//  userInput
//
//  Created by Ananya Jajoo on 9/4/22.
//

import Foundation
import UIKit

class SecondViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    var myControllers = [UIViewController]()
    
    @IBOutlet var finishBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishBtn.isHidden = true
        
        let questions: [String] = [
            "What is your name?", "What is one good thing that happened to you today?", "What is one bad thing that happened to you today?", "How are you feeling?", "What’s your stress level", "What did you spend most of your time doing today?"
        ]
        
        for i in 0..<questions.count {
            let vc = TextViewController(with: questions[i], index: i)
            myControllers.append(vc)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
            self.presentPageVC()
        })
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

    func presentPageVC() {
        guard let first = myControllers.first else {
            return
        }
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.dataSource = self
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        vc.setViewControllers([first], direction: .forward, animated: true, completion: nil)
        present(vc, animated: true)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = myControllers.firstIndex(of: viewController), index < (myControllers.count-1) else {
            finishBtn.isHidden = false
            return nil
        }
        let after = index+1
        return myControllers[after]
    }
    @IBAction func finish(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
