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
    private var resturants: [String] = []
    @IBOutlet weak var ResturantTableView: UITableView!
    @IBOutlet weak var webView: WKWebView!
    private var disposeBag = DisposeBag()
    private lazy var viewModel = {
        return VoiceRecognitionViewModel.init()
    }()
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var searchUberEatsApi: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        setSubscribers()
    }
    private func setSubscribers() {
        viewModel.textChangeSubject.subscribe({[weak self]
            event in
            if let elemnt = event.element , let text = elemnt {
                self?.setText(text: text)
            }
        }).disposed(by: disposeBag)
        viewModel.resturantListSubject.subscribe({[weak self]
            event in
            if let elemnt = event.element , let resturantsNames = elemnt {
                self?.handleResturants(restrantsNames: resturantsNames)
            }
        }).disposed(by: disposeBag)
    }
    private func setText(text: String) {
        textLabel.text = text
        if searchUberEatsApi.isOn {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                self.loadUberEats(text: text)
            })
        }
    }
   private func loadUberEats(text: String) {
    let baseString = "https://www.ubereats.com/en-US/search"
    var comps = URLComponents(string: baseString)!
    let keyQuery = URLQueryItem(name: "q", value: text)
    comps.queryItems = [keyQuery]
    guard let url = comps.url else {
        print("Error in url arabic")
        return
    }
          let myRequest = URLRequest(url: url)
          webView.load(myRequest)
      }
    
    @IBAction func startRecordButtonTapped(_ sender: UIButton) {
        if sender.isSelected {
            textLabel.text = ""
            viewModel.stopSpeachRecognition()
        } else {
            viewModel.startSpeechRecognition()
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
                                    if let content = html as? String {
                                        self.viewModel.getResturantFrom(html: content)
                                    }
        }) }
    
    private func handleResturants(restrantsNames: [String]) {
        resturants = restrantsNames
        ResturantTableView.reloadData()
    }
}
extension SpeechRecognizerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resturants.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResturantCell")!
        cell.textLabel?.text = resturants[indexPath.row]
        return cell
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
