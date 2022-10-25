//
//  TextViewController.swift
//  userInput
//
//  Created by Ananya Jajoo on 9/4/22.
//

import Foundation
import UIKit
import NaturalLanguage

class UserInputData: NSObject {
    static let sharedInstance = UserInputData()
    private override init() {}
    var inputText = ""
}

class TextViewController: UIViewController, UITextFieldDelegate{
    var myText: String
    //@IBOutlet weak var myTextField: UITextField!
    
    
    private let myPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        pageControl.frame = CGRect(x: 0, y: (screenHeight - 50), width: screenWidth, height: 75)
        pageControl.numberOfPages = 6
        pageControl.backgroundColor = .systemBlue
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    private let myfinsihBtn: UIButton = {
        let finishBtn = UIButton()
        finishBtn.setTitle("Finish", for: .normal)
        finishBtn.backgroundColor = .systemBlue
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        finishBtn.frame = CGRect(x: screenWidth/3.5, y: (screenHeight/1.5), width: screenWidth/2.5, height: 50)
        finishBtn.layer.cornerRadius = 5
        finishBtn.isHidden = true
        return finishBtn
    }()
    
    
    public let myTextView: UITextView = {
        let textView  = UITextView()
        textView.isEditable = false
        textView.textColor = UIColor(named: "#BB70FF")
        textView.font = UIFont.boldSystemFont(ofSize: 32.0)
        textView.textContainerInset = UIEdgeInsets(top: 50, left: 10, bottom: 10, right: 0);
        return textView
    }()
    
    @IBOutlet var myInputView: UITextField! = {
        let textInput  = UITextField()
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let frameWidth: CGFloat  = 300.0
        let frameHeight: CGFloat  = 20.0
        textInput.center = textInput.center

        textInput.frame = CGRect(x: (screenWidth - frameWidth) / 2, y: (screenHeight - frameHeight) / 2,
                                 width: frameWidth, height: frameHeight)

        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x:0.0, y:25 - 1, width:300, height:1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        textInput.borderStyle = UITextField.BorderStyle.none
        textInput.layer.addSublayer(bottomLine)

        //textInput.placeholder = "Enter text"
        textInput.backgroundColor = UIColor.white
        textInput.textColor = UIColor.black
        return textInput
    }()
    

    
    init(with text: String, index: Int) {
        self.myText = text
        myPageControl.currentPage = index
        myTextView.text = self.myText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(self.myTextView)
        view.addSubview(self.myInputView)
        view.addSubview(self.myPageControl)
        if(myPageControl.currentPage == 3) {
            myTextView.keyboardType = .numberPad
        }
        if(myPageControl.currentPage == 5) {
            myfinsihBtn.isHidden = false
            view.addSubview(self.myfinsihBtn)
            myfinsihBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        }
        
        myPageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        myInputView.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        

    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if(myPageControl.currentPage == 0) {
            UserDefaults.standard.set(myInputView.text, forKey: "name")
        }
        else if(myPageControl.currentPage == 1) {
            UserDefaults.standard.set(myInputView.text, forKey: "question1")
        }
        else if(myPageControl.currentPage == 2) {
            UserDefaults.standard.set(myInputView.text, forKey: "question2")
        }
        else if(myPageControl.currentPage == 3) {
            UserDefaults.standard.set(myInputView.text, forKey: "question3")
        }
        else if(myPageControl.currentPage == 4) {
            UserDefaults.standard.set(myInputView.text, forKey: "question4")
        }
        else if(myPageControl.currentPage == 5) {
            UserDefaults.standard.set(myInputView.text, forKey: "question5")
        }
        
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        let name = UserDefaults.standard.string(forKey: "name")
        var text: String
        var ques1 = UserDefaults.standard.string(forKey: "question1")
        var ques2 = UserDefaults.standard.string(forKey: "question2")
        var ques3 = UserDefaults.standard.string(forKey: "question3")
        var ques4 = UserDefaults.standard.string(forKey: "question4")
        var ques5 = UserDefaults.standard.string(forKey: "question5")
//        let sentimentScore: NLTagScheme
//        let tagger = NLTagger(tagSchemes: [.sentimenentScore])
//        tagger.string = ques1
//        let (sentiment, _) = tagger.tag(at: ques1?.startsIndex, unit:.paragraph, scheme: .sentimentScore)
//        let score = Double(sentiment?.rawValue ?? "0") ?? 0
//        print(score)


        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let answers: [String] = []
        
        let current = myPageControl.currentPage
        print(index)
        myTextView.setContentOffset(CGPoint(x: CGFloat(current)*view.frame.size.width, y: 0), animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myTextView.frame = view.bounds
    }
}
