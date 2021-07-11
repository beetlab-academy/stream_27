import UIKit

public protocol Bank {}

class BankImpl: Bank {}

public class BankAssembly {
    public var bank: Bank {
        BankImpl()
    }
}

public protocol FastPaymentsService {}

// -- как было---- //

func main() {
    let bank = BankAssembly().bank
    ///
    
}

//--- как станет ----//

/*
 - сохранить модуль банка без изменений (dev pod)
 Framework: Bank
 
 import Bank
 
 - public / open
 
 */
