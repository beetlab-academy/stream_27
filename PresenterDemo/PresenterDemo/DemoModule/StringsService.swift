//
//  StringsService.swift
//  PresenterDemo
//
//  Created by nikita on 08.08.2021.
//

import Foundation

protocol StringsService {
    func generateString() -> String
}

class StringsServiceImpl: StringsService {
    func generateString() -> String {
        UUID().uuidString + " \(Date()) " + " hello!"
    }
}
