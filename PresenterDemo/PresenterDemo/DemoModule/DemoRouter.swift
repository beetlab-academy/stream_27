//
//  DemoRouter.swift
//  PresenterDemo
//
//  Created by nikita on 08.08.2021.
//

import Foundation

struct Input {
    let firstName: String
    let lastName: String
}

protocol DemoRouter {
    func showDetails(input: Input)
}

class DemoRouterImpl: DemoRouter {
    func showDetails(input: Input) {
        print("routing with input: \(input)")
    }
}
