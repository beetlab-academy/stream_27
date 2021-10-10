//
//  UsersViewModel.swift
//  mvvm_combine_example
//
//  Created by nikita on 10.10.2021.
//

import Combine

struct ViewModelState: Equatable {
    let isOperating: Bool
    let users: [User]
    let error: Error?
    
    static func ==(lhs: ViewModelState, rhs: ViewModelState) -> Bool {
        lhs.isOperating == rhs.isOperating && lhs.users == rhs.users
    }
}

protocol UsersViewModel {
    var state: CurrentValueSubject<ViewModelState, Error> { get }
    var searchText: CurrentValueSubject<String, Error> { get }
    
    func fetch()
    func loadMore()
}

class UsersViewModelImpl: UsersViewModel {
    var service: UsersService! // injected
    var state: CurrentValueSubject<ViewModelState, Error> = .init(ViewModelState(isOperating: false, users: [], error: nil))
    var searchText: CurrentValueSubject<String, Error> = .init("")
    var serviceToken: AnyCancellable?
    var searchToken: AnyCancellable?
    
    init() {
        searchToken = searchText.sink(receiveCompletion: {_ in}, receiveValue: {
            print($0)
        })
    }
    
    func fetch() {
        state.send(ViewModelState(isOperating: true, users: state.value.users, error: state.value.error)) // redux like
        
        serviceToken = service
            .fetch()
            .map { ViewModelState(isOperating: false, users: $0, error: nil) }
            .sink(receiveCompletion: {
                if case let .failure(error) = $0 {
                    self.state.send(ViewModelState(isOperating: false, users: [], error: error))
                }
            },
            receiveValue: {
                self.state.send($0)
            })
    }
    
    func loadMore() {
        
    }
}
