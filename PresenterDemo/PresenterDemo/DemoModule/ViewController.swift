//
//  ViewController.swift
//  PresenterDemo
//
//  Created by nikita on 08.08.2021.
//

import UIKit

struct ViewState {
    let firstName: String?
    let secondName: String?
}

protocol DemoView: AnyObject {
    var firstName: String? { get }
    var secondName: String? { get }
    
    // vs
    
    var viewState: ViewState? { get }
    
    func display(string: String)
}

class ViewController: UIViewController {
    var presenter: DemoPresenter! // injected
    @IBOutlet weak var demoLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    
    @IBAction func registerButtonTapped() {
        presenter.registerButtonTapped()
    }
    
    @IBAction func routeButtonTapped() {
        presenter.routeToSmth()
    }
    
    @IBAction func demoButtonTapped() {
        presenter.demoButtonTapped()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewLoaded()
    }
}

extension ViewController: DemoView {
    var viewState: ViewState? {
        ViewState(firstName: firstNameTextField.text, secondName: secondNameTextField.text)
    }
    
    var firstName: String? {
        firstNameTextField.text
    }
    
    var secondName: String? {
        secondNameTextField.text
    }
    
    func display(string: String) {
        demoLabel.text = string
    }
}
