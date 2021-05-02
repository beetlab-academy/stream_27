//
//  main.swift
//  Bank_start
//
//  Created by nikita on 25.04.2021.
//

import Foundation

/*
Address {country, city, ...}
User { id, name, secondName, lastName, email, phone, address }
 
Credit {percent, value}
Deposit {percent, value}
enum Type { deposit(Deposit), credit(Credit) }
Product { id, title, type  }
 
Bank {
 name
 func createClient(name, secondName, lastName, email, phone, address) -> User
 func createDepositProduct(user: User) -> Product
 func createCreditProduct(user: User) -> Product
 func products(user: User) -> [Product]
}
 
как хранить продукты юзера внутри банка? (можем ли хранить инфу о продуктах в Storage?)
[String: [Product]] - ключ айди юзера, значение - массив продуктов
*/
import Foundation

// fileprivate struct class var let enum

struct Address: Codable {
    let country: String
    let city: String
    let street: String
    let house: String
    let flat: Int
    let floor: Int
}

struct Phone: Codable {
    let countryCode: Int
    let numberPhone: Int
}

/*{ "countryCode": 7, "numberPhone": 9163421221 }*/

enum Country {
    case russia
    case usa
    case eu
}

enum Gender: String, Codable {
    case male
    case female
    case other
}


struct User1: Codable {
    let gender: Gender
    let name: String
}

/* { "name": "Иван", "gender": "female" } */

let x: Country = .eu
let y: Gender = Gender(rawValue: "male")!


struct User: Codable {
    let id: String
    let name: String
    let secondName: String
    let lastName: String
    let email: String
    let phone: Phone
    let address: Address
}


let assembly = StoragesAssembly()
let storage = assembly.userDefaults

let address1 = Address(country: "Russia",
                       city: "Moscow",
                       street: "Institutskaya",
                       house: "kkkk",
                       flat: 300,
                       floor: 4)

let phone1 = Phone(countryCode: 495,
                   numberPhone: 0999999)

let user1 = User(id: "gggg",
                 name: "Ivan",
                 secondName: "I",
                 lastName: "Ivanov",
                 email: "ivanov@mail.ru",
                 phone: phone1,
                 address: address1)
do {
    let data = try JSONEncoder().encode(user1)

    storage.set(data: data, key: "test_key")

    if let data = storage.getData(key: "test_key") {
        let str = String(data: data, encoding: .utf8)
        print(str)
    }
} catch {
    print(error)
}


struct A: Codable {
    let a1: Int
    let a2: Int
}

struct B: Codable {
    let b1: Int
    let b2: Int
}

enum C: Codable {
    case a(A)
    case b(B)
    
    enum CodingKeys: String, CodingKey {
        case a
        case b
    }
    
    enum CError: Error {
        case parsingError
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let key = container.allKeys.first else {
            throw CError.parsingError
        }

        switch key {
        case .a:
            let a = try container.decode(A.self, forKey: .a)
            self = .a(a)
        case .b:
            let b = try container.decode(B.self, forKey: .b)
            self = .b(b)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case let .a(aObject):
            try container.encode(aObject, forKey: .a)
        case let .b(bObject):
            try container.encode(bObject, forKey: .b)
        }
    }
}

struct D: Codable {
    let id: String
    let title: String
    let type: C
}

/*
 {
    "id": "{id}",
    "title": "{title}",
    "type": {
        "a": { "a1": {a1}, "a2": {a2} },
        "b": { "b1": {b1}, "b2": {b2} }
    }
 }
*/

let d = D(id: "ewfwergewrggrw", title: "name", type: .a(A(a1: 1, a2: 2)))

let dData = try JSONEncoder().encode(d)
let string = String(data: dData, encoding: .utf8)

print(string)

let d2 = D(id: "ewfwergewrggrw", title: "name", type: .b(B(b1: 1, b2: 2)))

let dData2 = try JSONEncoder().encode(d2)
let string2 = String(data: dData2, encoding: .utf8)

print(string2)


// на практике

struct Credit: Codable {
    let summ: Float
    let months: Int
    let percentYear: Float
}

enum CashOutType: String, Codable {
    case month
    case year
}

struct Deposit: Codable {
    let percent: Float
    let summ: Float
    let type: CashOutType
}

enum ProductType: Codable {
    case credit(Credit)
    case deposit(Deposit)
    
    // 1 шаг - определить ключи, которые будут в жсоне
    enum CodingKeys: String, CodingKey {
        case credit
        case deposit
    }
    
    enum ProductTypeDecodingError: Error {
        case wrongNumberOfKeys
    }
    
    // 2 шаг - описываем конструктор https://developer.apple.com/documentation/swift/decoder/2892621-container
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard container.allKeys.count == 1,
              let key = container.allKeys.first else {
            throw ProductTypeDecodingError.wrongNumberOfKeys
        }
        
        switch key {
        case .credit:
            let credit = try container.decode(Credit.self, forKey: .credit)
            self = .credit(credit)
        case .deposit:
            let deposit = try container.decode(Deposit.self, forKey: .deposit)
            self = .deposit(deposit)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case let .credit(credit):
            try container.encode(credit, forKey: .credit)
        case let .deposit(deposit):
            try container.encode(deposit, forKey: .deposit)
        }
    }
}

struct Product: Codable {
    let id: String
    let name: String
    let type: ProductType
}

/*
 {
    "id": "{id}",
    "name": "{name}",
    "type": {
        "credit": {
            "summ": {summ},
            "months": {months},
            "percentYear": {percentYear}
        }
 
        // OR
 
        "deposit": {
            "percent": {percent},
            "summ": {summ},
            "type": "month" or "year"
        }
    }
 }
 */

/*
 {
    "id": "{id}",
    "name": "{name}",
    "type": {
            "product_type": "credit",
            "summ": {summ},
            "months": {months},
            "percentYear": {percentYear}
        }
 
        /*or*/
    "type": {
            "percent": {percent},
            "summ": {summ},
            "type": "month" or "year",
            "product_type": "deposit"
    }
 }
 */

let product = Product(id: UUID().uuidString,
                      name: "Микрокредит",
                      type: .credit(Credit(summ: 15_000, months: 12, percentYear: 700)))

let product2 = Product(id: UUID().uuidString,
                      name: "Вклад",
                      type: .deposit(Deposit(percent: 4.5, summ: 15_000, type: .year)))


let productData = try JSONEncoder().encode(product)
let str = String(data: productData, encoding: .utf8)
print("prod string: \(str)")


let productData2 = try JSONEncoder().encode(product2)
let str2 = String(data: productData2, encoding: .utf8)
print("prod2 string: \(str2)")

/*
 1. У всех структур User, Address, Phone, Product ... написать реализацию encode/init протокола Codable (https://habr.com/ru/post/414221/, https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types)
 2. Перевести проект в macOS app - command line tool
 3. Навести порядок - разложить все сущности в отдельные файлы с именем User.swit, Product.swift....
 4. Начать делать банк -
    /*создать юзера из входных данных метода, вернуть юзера, подумать, как хранить массив юзеров в сторадже (достаете массив юзеров из стораджа, дописываете туда нового юзера, массив обратно в сторадж кладете)*/
    func createClient(name, secondName, lastName, email, phone, address) -> User
    /*подумать, как хранить продукты юзера в сторадже*/
    func createDepositProduct(user: User) -> Product
    func createCreditProduct(user: User) -> Product
 */
//import Bank

let assembly1 = BankAssembly()
let bank = assembly1.bank

let client = bank.createClient(name: "Сергей", secondName: "Дмитриевич", lastName: "Полуэктов", email: "sdr@mail.ru", phone: Phone(countryCode: 7, numberPhone: 9034532112), address: Address(country: "Россия", city: "Москва", street: "Героев Подшипников", house: "1к4", flat: 1, floor: 1))
let creditProduct = bank.createCreditProduct(user: client)


//
//let storage1 = StoragesAssembly().filesystemStorage
//let bank2 = assembly1.bank(with: storage1)
