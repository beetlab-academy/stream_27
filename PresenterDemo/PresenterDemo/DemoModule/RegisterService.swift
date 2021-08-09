//
//  RegisterService.swift
//  PresenterDemo
//
//  Created by nikita on 08.08.2021.
//

import Foundation

struct User {
    let id: String
    let name: String
    let secondName: String
}

protocol RegisterService {
    func register(firstName: String, lastName: String) -> User
}

class RegisterServiceImpl: RegisterService {
    func register(firstName: String, lastName: String) -> User {
        User(id: UUID().uuidString, name: firstName, secondName: lastName)
    }
}
