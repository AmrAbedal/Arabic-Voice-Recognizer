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
import CoreLocation

class SpeechRecognizerViewController: UIViewController {
    private var resturants: [Resturant] = []
    @IBOutlet weak var ResturantTableView: UITableView!
    private var disposeBag = DisposeBag()
    private lazy var viewModel = {
        return VoiceRecognitionViewModel.init()
    }()
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var searchUberEatsApi: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setSubscribers()
    }
    private func setupTableView() {
        ResturantTableView.rowHeight = UITableView.automaticDimension
        ResturantTableView.estimatedRowHeight = 300
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
            self.viewModel.fetchResturantsWith(searchText: text)
        }
    }
    @IBAction func longPressAction(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            print("start")
            recordButton.isSelected = true
            recordButton.backgroundColor = #colorLiteral(red: 0.631372549, green: 0.1254901961, blue: 0.1294117647, alpha: 1)
            viewModel.startSpeechRecognition()
        }  else if sender.state == .ended || sender.state == .cancelled {
            print("FINISHED UP LONG PRESS")
            viewModel.stopSpeachRecognition()
            recordButton.backgroundColor = #colorLiteral(red: 0.8544178299, green: 0.5002352072, blue: 0.006223022287, alpha: 1)
            recordButton.isSelected = false
        }
    }
}

extension SpeechRecognizerViewController  {
    private func handleResturants(restrantsNames: [Resturant]) {
        resturants = restrantsNames
        ResturantTableView.reloadData()
    }
}
extension SpeechRecognizerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resturants.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResturantCell") as! ResturanTableViewCell
        cell.configure(resturant: resturants[indexPath.row] )
        return cell
    }
}

