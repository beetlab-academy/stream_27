//
//  ViewController.swift
//  BankUISample
//
//  Created by nikita on 11.07.2021.
//

import UIKit

class ViewController: UIViewController {
    let bank = BankAssembly().bank
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }

    @IBAction func reguisterButtonTapped() {
        view.endEditing(true)
        
        let name = nameTextField.text ?? ""
        bank.createClient(name: name, secondName: <#T##String#>, lastName: <#T##String#>, email: <#T##String#>, phone: <#T##<<error type>>#>, address: <#T##<<error type>>#>)
    }
    
}

