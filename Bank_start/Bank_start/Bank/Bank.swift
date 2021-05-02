//
//  Bank.swift
//  Bank_start
//
//  Created by nikita on 02.05.2021.
//

import Foundation

protocol Bank {
    func createClient(name: String,
                      secondName: String,
                      lastName: String,
                      email: String,
                      phone: Phone,
                      address: Address) -> User
    func createDepositProduct(user: User) -> Product
    func createCreditProduct(user: User) -> Product
}

class BankImpl {
    let storage: Storage // зависимость
    
    init(storage: Storage) { // инъекция зависимости
        self.storage = storage
    }
}

extension BankImpl: Bank {
    func createClient(name: String, secondName: String, lastName: String, email: String, phone: Phone, address: Address) -> User {
        let user = User(id: UUID().uuidString,
                        name: name,
                        secondName: secondName,
                        lastName: lastName,
                        email: email,
                        phone: phone,
                        address: address)
        
        return user
    }
    
    func createDepositProduct(user: User) -> Product {
        let product = Product(id: UUID().uuidString,
                              name: "Разделяй и зарабатывай!",
                              type: .deposit(Deposit(percent: 12, summ: 0, type: .month)))
        
        return product
    }
    
    func createCreditProduct(user: User) -> Product {
        let product = Product(id: UUID().uuidString,
                              name: "Бери щас плати всю жизнь!",
                              type: .credit(Credit(summ: 15_000, months: 12, percentYear: 720)))
        
        return product
    }
}

extension BankImpl {
    /*если надоело гонять JSONEncoder/JSONDecoder - можете прочитать про Generic и Generic constraint. Либо сделать абстракцию -= UserStorage,
     
     {getUsers() -> [Users], setUsers(_users: [Users])}, в него надо инжектнуть Storage*/
    func store(client: User) {
        /* клиентов храним в массиве:
         
         
         - читаем Data из словаря по ключу "clients"
         - JSONDecoder() -> [User] (тип [User].self)
         - аппендим в массив User, проверив предвраительно, что юзера с таким айдишником в массиве нет
         - и если юзера нет - то аппендим в массив,
         - JSONEncoder() -> Data -> storage.set(data:key)
         */
    }
    
    func store(product: Product, user: User) {
        /*
          - ключ формируется: "products_of_user_\(user.id)"
         - достаем массив продуктов -> JSONDecoder() -> [Product] (тип [Product].self)
         - проверям, что в массиве нету продукта с указанным идентификатором
         - аппендим в массив
         - JSONEncoder() -> Data -> storage.set(data:key)
         */
    }
}

protocol UserStorage {
    func users() -> [User]
    func add(user: User)
}

class UserStorageImpl: UserStorage {
    let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func users() -> [User] {
        guard let usersData = storage.getData(key: "clients") else {
            return []
        }
        
        do {
            let users = try JSONDecoder().decode([User].self, from: usersData)
            return users
        } catch {
            print("JSONDecoder error \(error)")
            return []
        }
    }
    
    func add(user: User) {
        guard let usersData = storage.getData(key: "clients") else {
            return
        }
        
        do {
            var users = try JSONDecoder().decode([User].self, from: usersData)
            // убедиться, что юзера нету в этом массиве по идентификатору user.id
            users.append(user)
            
            let usersData = try JSONEncoder().encode(users)
            storage.set(data: usersData, key: "clients")
            
        } catch {
            print("JSONDecoder error \(error)")
        }
    }
}

/*
 
 Реализовать переводы из банка в банк по номеру телефона
 
 */

protocol MoneyReciever {
    func recieve(summ: Float, phone: Phone) -> Bool
}

protocol MoneySender {
    func send(summ: Float, phone: Phone) -> Bool
}

// в банк инжектим MoneySender
// сам банк реализует MoneyReciever

class FastPaymentsService: MoneySender {
    var recievers = [MoneyReciever]()
    
    func send(summ: Float, phone: Phone) -> Bool {
        var isSent = false
        
        recievers.forEach {
            if $0.recieve(summ: summ, phone: phone) {
                isSent = true
                return
            }
        }
        
        return isSent
    }
    
    func register(reciever: MoneyReciever) {
        recievers.append(reciever)
    }
}


/*
let bank1 = BankAssembly().bank
let bank2 = BankAssembly().bank

bank1.send(summ: 123, phone: Phone(countryCode: 7, numberPhone: 3234324234))

*/
