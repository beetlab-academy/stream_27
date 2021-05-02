//
//  BankAssembly.swift
//  Bank_start
//
//  Created by nikita on 02.05.2021.
//

import Foundation

public class BankAssembly {
    let storagesAssembly = StoragesAssembly()
    
    public var bank: Bank {
        return BankImpl(storage: storagesAssembly.userDefaults)
    }
    
    public var inMemoryBank: Bank {
        return BankImpl(storage: storagesAssembly.inMemory)
    }
    
    func bank(with storage: Storage) -> Bank {
        return BankImpl(storage: storage)
    }
}
