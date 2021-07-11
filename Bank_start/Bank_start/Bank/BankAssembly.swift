//
//  BankAssembly.swift
//  Bank_start
//
//  Created by nikita on 02.05.2021.
//

import Foundation

class BankAssembly {
    let storagesAssembly = StoragesAssembly()
    
    var bank: Bank {
        return BankImpl(storage: storagesAssembly.userDefaults)
    }
    
    var inMemoryBank: Bank {
        return BankImpl(storage: storagesAssembly.inMemory)
    }
    
    func bank(with storage: Storage) -> Bank {
        return BankImpl(storage: storage)
    }
}
