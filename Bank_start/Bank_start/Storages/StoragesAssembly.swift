//
//  StoragesAssembly.swift
//  Bank_start
//
//  Created by nikita on 02.05.2021.
//

import Foundation

class StoragesAssembly {
    var inMemory: Storage {
        if (true/*sonme condition* - test enviroment, locale changed e.t.c*/) {
            return TestStorage()
        } else {
            return InMemoryStorage()
        }
    }
    
    var userDefaults: Storage {
        if (true/*sonme condition* - test enviroment, locale changed e.t.c*/) {
            return TestStorage()
        } else {
            return UserDef()
        }
    }
    
    var filesystemStorage: Storage {
        if (true/*sonme condition* - test enviroment, locale changed e.t.c*/) {
            return TestStorage()
        } else {
            return FileManag()
        }
    }
}

/*test enviroment*/

class TestStorage: Storage {
    var dictionary: [String: Data] = [:]

    func set(data: Data, key: String) {
        dictionary[key] = data
    }
    
    func getData(key: String) -> Data? {
        return dictionary[key]
    }
}
