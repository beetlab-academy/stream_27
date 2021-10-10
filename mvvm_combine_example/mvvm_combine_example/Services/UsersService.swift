//
//  UsersService.swift
//  mvvm_combine_example
//
//  Created by nikita on 10.10.2021.
//

import Combine

struct User: Equatable {
    let name: String
    let age: Int
}

protocol UsersService {
    func fetch() -> AnyPublisher<[User], Error>
}

class UsersServiceImpl: UsersService {
    func fetch() -> AnyPublisher<[User], Error> {
        Future { promise in
            var users = [User]()
            
            for i in 0..<100 {
                users.append(User(name: "\(i)", age: i))
            }
            
            promise(.success(users))
            
            
        }.eraseToAnyPublisher()
    }
}
