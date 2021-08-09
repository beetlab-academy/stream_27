//
//  DemoPresenter.swift
//  PresenterDemo
//
//  Created by nikita on 08.08.2021.
//

import Foundation

protocol DemoPresenter {
    func viewLoaded()
    func demoButtonTapped()
    func routeToSmth()
    func registerButtonTapped()
}

class DemoPresenterImpl {
    weak var view: DemoView? // injected
    var stringsService: StringsService! // injected
    var router: DemoRouter! // injected
    var registerService: RegisterService! // injected
    
    var string = ""
}

extension DemoPresenterImpl: DemoPresenter {
    func registerButtonTapped() {
        guard let firstName = view?.firstName, let secondName = view?.viewState?.secondName else { return }

        let user = registerService.register(firstName: firstName, lastName: secondName)
        
        router.showDetails(input: Input(firstName: user.name, lastName: user.secondName))
    }
    
    func routeToSmth() {
        guard let firstName = view?.firstName, let secondName = view?.viewState?.secondName else { return }
        
        router.showDetails(input: Input(firstName: firstName, lastName: secondName))
    }
    
    func viewLoaded() {
        string = stringsService.generateString()
    }
    
    func demoButtonTapped() {
        view?.display(string: string)
    }
}
