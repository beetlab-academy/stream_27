//
//  ViewController.swift
//  segues_presentartion
//
//  Created by nikita on 18.07.2021.
//

import UIKit

class ViewController: UIViewController {
    var service: Service1! // injected
    var blueAssembly: BlueModuleAssembly! // injected

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func swipedBack(_ segue: UIStoryboardSegue) {
        print("swiped back")
    }

    @IBAction func segueTapped() {
        performSegue(withIdentifier: "toYellow", sender: nil)
    }
    
    
    @IBAction func programmaticTapped() {
//        let vc: BlueViewController = ViewControllersFactory().viewController(identifier: "BlueViewController")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(identifier: "BlueViewController") as! BlueViewController
        let vc = blueAssembly.viewController
        present(vc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toYellow" {
            guard let yellow = segue.destination as? YellowViewController else { return }
            
            yellow.data = 12
        }
    }
}

