//
//  ViewController.swift
//  Combine-L4
//
//  Created by Dmitry Belov on 09.12.2022.
//

import UIKit
import Combine
import SwiftUI

class ViewController: UIViewController {
   
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var inputTextField: UITextField!
    
    var subscriptions: Set<AnyCancellable> = []
    private var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inputNumber = inputTextField
            .publisher(for: \.text)
            .compactMap{ $0.flatMap(Int.init) }
            .eraseToAnyPublisher()
        
        viewModel = ViewModel(apiClient: APIClient(), inputIdentifiersPublisher: inputNumber)
        
        viewModel?.character
 //           .map{ $0.description }
 //           .catch{ _ in Empty<String, Never>() }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { print($0) },
                  receiveValue: { [weak self] character in
                self?.imageView.load(from: character.image)
                self?.textLabel.text = character.description
            })
            .store(in: &subscriptions)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(resign))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func resign() {
        view.endEditing(true)
        resignFirstResponder()
    }
}

