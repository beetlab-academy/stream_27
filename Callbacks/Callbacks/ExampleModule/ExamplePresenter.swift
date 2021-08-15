//
//  ExamplePresenter.swift
//  Callbacks
//
//  Created by nikita on 15.08.2021.
//

import UIKit
import Combine

struct User {
    let name: String
    let secondName: String
}

protocol Bank {
    func users() -> [User]
}

protocol ExamplePresenter {
    func viewLoaded()
    func eventHappened()
    func eventHappened1()
}

// MVP

class ExamplePresenterImpl: ExamplePresenter {
    var bank: Bank!
    weak var view: ExampleTableView?
    var router: Router1!
    var tokens: Set<AnyCancellable> = []
    
    var isCancelled = false

    func viewLoaded() {
        let users = bank.users()
        view?.currentState = ExampleState(items: users.map { TableViewItem(value: $0.name + " " + $0.secondName) })
    }
    
    func eventHappened() {
        router.routeToSmth { [weak self] in
            guard let prevState = self?.view?.currentState, !(self?.isCancelled ?? true) else { return }
            
            var items = prevState.items
            items.append(TableViewItem(value: $0))
            
            self?.view?.currentState = ExampleState(items: items)
        }
        
        router
            .routeToSmth1()
            .sink(receiveCompletion: {_ in}) { [weak self]  in
            guard let prevState = self?.view?.currentState else { return }
            
            var items = prevState.items
            items.append(TableViewItem(value: $0))
            
            self?.view?.currentState = ExampleState(items: items)

        }
        .store(in: &tokens)
    }
    
    func eventHappened1() {
        isCancelled = true
        tokens.forEach { $0.cancel() }
    }
}

class Router1 {
    func routeToSmth(result: @escaping (String) -> Void) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let second = storyboard.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        // present
    }
    
    func routeToSmth1() -> AnyPublisher<String, Error> {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let second = storyboard.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        
        return Future {_ in}.eraseToAnyPublisher()
        // present
    }
}
