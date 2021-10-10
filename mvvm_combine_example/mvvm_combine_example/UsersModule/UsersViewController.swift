//
//  UsersViewController.swift
//  mvvm_combine_example
//
//  Created by nikita on 10.10.2021.
//

import UIKit
import Combine

class UsersViewController: UIViewController {
    let viewModel: UsersViewModel
    var tokens: Set<AnyCancellable> = []
    lazy var textField: UITextField = {
        let view = UITextField()
        
        return view
    }()
    lazy var tableView: UITableView = {
        let view = UITableView()
        
        return view
    }()
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // биндинг  вью модели (даннные из вью модели во вью)
        viewModel
            .state
            .receive(on: DispatchQueue.main)
            .map(\.users)
            .removeDuplicates()
            .sink(receiveCompletion: {_ in}, receiveValue: {[weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &tokens)
        
        viewModel
            .state
            .receive(on: DispatchQueue.main)
            .map(\.error)
            .compactMap { $0 }
            .sink(receiveCompletion: {_ in}, receiveValue: {[weak self] in
                let alert = UIAlertController(title: nil, message: $0.localizedDescription, preferredStyle: .actionSheet)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(action)
                self?.present(alert, animated: true, completion: nil)
            })
            .store(in: &tokens)
        
        viewModel
            .state
            .receive(on: DispatchQueue.main)
            .map(\.isOperating)
            .removeDuplicates()
            .sink(receiveCompletion: {_ in}, receiveValue: {[weak self] in
                self?.toggle(isLoading: $0)
            })
            .store(in: &tokens)


        // биндинг в обратную сторону вью -> вью модель
        textField
            .publisher(for: \.text)
            .sink(receiveValue: { [weak self] in
                self?.viewModel.searchText.send($0 ?? "")
            })
            .store(in: &tokens)
        
        viewModel.fetch()
    }
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.state.value.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == viewModel.state.value.users.count {
            viewModel.loadMore()
        }
        
        return UITableViewCell()
    }
}

extension UsersViewController {
    func toggle(isLoading: Bool) {}
}

