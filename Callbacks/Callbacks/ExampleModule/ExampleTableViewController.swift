//
//  ExampleTableViewController.swift
//  Callbacks
//
//  Created by nikita on 15.08.2021.
//

import UIKit

struct TableViewItem {
    let value: String
}

struct ExampleState {
    let items: [TableViewItem]
}

protocol ExampleTableView: AnyObject {
    var currentState: ExampleState? { get set }
}

class ExampleTableViewController: UITableViewController, ExampleTableView {
    var currentState: ExampleState? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var presenter: ExamplePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        presenter.viewLoaded()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = currentState?.items[indexPath.row].value
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentState?.items.count ?? 0
    }
}
