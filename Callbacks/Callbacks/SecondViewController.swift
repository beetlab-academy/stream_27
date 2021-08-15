//
//  SecondViewController.swift
//  Callbacks
//
//  Created by nikita on 15.08.2021.
//

import UIKit
import Combine

protocol SecondViewControllerDelegate: AnyObject {
    func textChanged(_ text: String)
}

class SecondViewController: UIViewController {
    weak var delegate: SecondViewControllerDelegate?
    var result: ((String) -> Void)?
    var promise: ((Result<String, Error>) -> Void)?
    @Published public var text = ""
    @IBOutlet weak var textField: UITextField!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func applyChangesButtonTapped() {
        guard let text = textField.text else { return }
        
        self.text = text
        result?(text)
        promise?(.success(text))
        delegate?.textChanged(text)
    }
    
    func run() -> Future<String, Error> {
        Future<String, Error> { promise in
            self.promise = promise
        }
    }
    
    func runWithPublisher() -> AnyPublisher<String, Error> {
        Future<String, Error> { promise in
            self.promise = promise
        }
        .eraseToAnyPublisher()
    }
}
