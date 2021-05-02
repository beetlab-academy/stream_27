//
//  Storage.swift
//  Bank_start
//
//  Created by nikita on 02.05.2021.
//

import Foundation

protocol Storage {
    func set(data: Data, key: String)
    func getData(key: String) -> Data?
}

class UserDef: Storage { //
    var user = UserDefaults.standard
    
    func set(data: Data, key: String) {
        user.set(data, forKey: key)
    }
    func getData(key: String) -> Data? {
        return user.data(forKey: key)
    }
}

//File manager
class FileManag: Storage {
    var val = FileManager.default
    
    func set(data: Data, key: String) {
        val.createFile(atPath: key, contents: data)
    }
    func getData(key: String) -> Data? {
        return val.contents(atPath: key)
        
    }
}

// Dictionary - InMemoryStorage
class InMemoryStorage: Storage {
    var dictionary: [String: Data] = [:]

    func set(data: Data, key: String) {
        guard dictionary[key] == nil else {
            print("trying to overwrite extisting value - it's an error")
            return
        }
        
        dictionary[key] = data
    }
    
    func getData(key: String) -> Data? {
        return dictionary[key]
    }
}
