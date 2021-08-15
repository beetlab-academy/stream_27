//
//  ViewController.swift
//  Callbacks
//
//  Created by nikita on 15.08.2021.
//

import UIKit
import Combine

struct ServiceResult {
    let value: String
}

protocol Service {
    func runAsync(input: String, then: (String)-> Void)
    func run(input: String) -> AnyPublisher<ServiceResult, Error>
}

class ViewController: UIViewController {
    var service: Service!
    var service1: Service!
    var service2: Service!
    
    var data = [CustomCellState(title: "", subtitle: ""), CustomCellState(title: "", subtitle: "")]

    @IBOutlet weak var tableView: UITableView!
    var tokens: Set<AnyCancellable> = []

    @IBOutlet weak var dataLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "custom_cell_id")
        // Do any additional setup after loading the view.
    }

    @IBAction func actionButtonTapped() {
        let second = storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        second.delegate = self
        
        second.result = { [weak self] in
            self?.data.append($0)
            self?.tableView.reloadData()
        }
        
//        second
//            .run()
//            .flatMap { self.service.run(input: $0) }
//            .flatMap { self.service1.run(input: $0.value) }
//            .flatMap { self.service2.run(input: $0.value) }
//            .sink { _ in
//
//            } receiveValue: {
//                self.dataLabel.text = $0.value
//            }
//            .store(in: &tokens)
//
//
//
//        second
//            .run()
//            .sink { _ in
//
//        } receiveValue: {
//            self.dataLabel.text = $0
//        }
//        .store(in: &tokens)

        second
            .$text
            .receive(on: DispatchQueue.main)
            .sink {
                self.dataLabel.text = $0
                self.data.append(CustomCellState(title: $0, subtitle: ""))
                self.tableView.reloadData()

        }
        .store(in: &tokens)

        present(second, animated: true, completion: nil)
    }
    
}

extension ViewController: SecondViewControllerDelegate {
    func textChanged(_ text: String) {
        dataLabel.text = text
    }
}

final class Router {
    func showSecond(_ delegate: SecondViewControllerDelegate) {
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom_cell_id", for: indexPath) as! СustomCell
        cell.state = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
}

