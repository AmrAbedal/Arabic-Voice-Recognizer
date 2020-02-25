//
//  SpeechRecognizerViewController.swift
//  Arabic Voice Recognition
//
//  Created by Amr AbdelWahab on 2/24/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import SwiftSoup


class SpeechRecognizerViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    private var disposeBag = DisposeBag()
    private lazy var viewModel = {
        return VoiceRecognitionViewModel.init()
    }()
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var searchUberEatsApi: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUberEats()
        // Do any additional setup after loading the view.
        setSubscribers()
    }
    func loadUberEats() {
        webView.navigationDelegate = self
        let myURL = URL(string:"https://www.ubereats.com/en-US/search?q=%D8%A7%D9%84%D9%83%D8%B4%D8%B1%D9%8A")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    private func setSubscribers() {
        viewModel.textChangeSubject.subscribe({[weak self]
            event in
            if let elemnt = event.element , let text = elemnt {
                self?.setText(text: text)
            }
        }).disposed(by: disposeBag)
    }
    private func setText(text: String) {
        textLabel.text = text
    }
    
    @IBAction func startRecordButtonTapped(_ sender: UIButton) {
        if sender.isSelected {
            viewModel.stopSpeachRecognition()
        } else {
            if searchUberEatsApi.isOn {
                viewModel.search()
            } else {
                viewModel.startSpeechRecognition()
            }
        }
        sender.isSelected = !sender.isSelected
    }
}
extension SpeechRecognizerViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        getHtml()
    }
    func getHtml() {
        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
                                   completionHandler: { (html: Any?, error: Error?) in
                                    print(html)
                                    if let content = html as? String {
                                        self.getResturantFrom(html: content)
                                        
                                    }
        }) }
    
    func getResturantFrom(html: String) {
        do {
            let html: String = html;
            let doc: Document = try SwiftSoup.parse(html)
            let link: Element = try doc.select("main").first()!
         
        } catch Exception.Error(let type, let message) {
            print(message)
        } catch {
            print("error")
        }
        
    }
}


extension UIButton {
    @IBInspectable var cornerRaduis: CGFloat  {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
}
