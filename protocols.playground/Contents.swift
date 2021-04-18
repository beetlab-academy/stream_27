import UIKit

var str = "Hello, playground"

struct A {
    let prop1: Int
    let prop2: Int
    
    init(prop1: Int, prop2: Int) {
        self.prop1 = prop1
        self.prop2 = prop2
        self.prop3 = prop2 + prop1
    }
    
    func f() {
        prop3
        step1()
        step2()
        step3()
    }
    
    private func step1() {}
    private func step2() {}
    private func step3() {}

    private let prop3: Int
}

let a = A(prop1: 21, prop2: 2)


protocol B {
    func f()
    var prop: Int { get set }
    var prop1: Int { get }
}

var array: [B] = []

class G {
    var b: B?
}

func process(b: B) {
    b.f()
    b.prop1
    
    let x = b.prop
    var copy = b
    copy.prop = 3
}

protocol Pet {
    func voice()
}

func playVoice(of pet: Pet) {
    pet.voice()
}

class Dog: Pet {
    func voice() {
        print("гав-гав")
    }
}

class Cat: Pet {
    func voice() {
        print("мяу")
    }
}

class Mouse: Pet {
    func voice() {
        print("неизвестно")
    }
}

class Fish: Pet {
    func voice() {
        print("...")
    }
}

playVoice(of: Dog())
playVoice(of: Cat())
playVoice(of: Mouse())
playVoice(of: Fish())

enum Voice {
    case gavGav
    case miay
}

func playVoice2(arg: ()-> Void) {
    arg()
}

playVoice2 {
    let a = 1
    let b = 2
    let x1 = a + b
}

playVoice2 {
    let cat = Cat()
    cat.voice()
}

// пример протоколов ios SDK - Сериализация

struct User: Codable {
    let id: String
    let name: String
    let avatar: URL
}

let user = User(id: "sefwg", name: "sdsefwf", avatar: URL(string: "http://google.com")!)
print("old user: \(user)")

let str1 = "wefwer"

let idData = user.id.data(using: .utf8)!
let nameData = user.name.data(using: .utf8)!
let urlData = user.avatar.absoluteString.data(using: .utf8)!

let idString = String(data: idData, encoding: .utf8)!
let nameString = String(data: nameData, encoding: .utf8)!
let urlString = String(data: urlData, encoding: .utf8)!

let user1 = User(id: idString, name: nameString, avatar: URL(string: urlString)!)
print("new user: \(user1)")

/* прочитать про try catch!!! */

let userData = try! JSONEncoder().encode(user)
let jsonString = String(data: userData, encoding: .utf8)!

/* прочитать про User.self - metatype */

let user3 = try! JSONDecoder().decode(User.self, from: userData)

print("json user: \(jsonString)")
print("new user 3: \(user3)")
/*
 
 user -> [something] -> store on disk
 get from disk -> [something] -> User
 */

protocol Storage {
    func set(data: Data, key: String)
    func getData(key: String) -> Data?
}

/* USER DEFAULTS Storage (UserDefaults.standard),
   FILE STORAGE Storage (FileManager) используйте ключ в качестве имени файла
   Keychain Storage (KeychainAccess)
 */

// Dictionary - InMemoryStorage

class InMemoryStorage: Storage {
    var dictionary: [String: Data] = [:]

    func set(data: Data, key: String) {
        dictionary[key] = data
    }
    
    func getData(key: String) -> Data? {
        return dictionary[key]
    }
}

class StoragesAssembly {
    var inMemory: Storage {
        return InMemoryStorage()
    }
    
    var userDefaults: Storage? {
        nil
    }
    
    var filesystemStorage: Storage? {
        nil
    }
}


let assembly = StoragesAssembly()
let storage = assembly.inMemory

let userToStore = User(id: "wefwefewf", name: "wefwewef", avatar: URL(string: "sefwrgf")!)
let userData1 = try! JSONEncoder().encode(userToStore)

storage.set(data: userData, key: "test_user_key")

if let userData2 = storage.getData(key: "test_user_key") {
    let userFromStorage = try! JSONDecoder().decode(User.self, from: userData2)
    print("userFromStorage - \(userFromStorage)")
}

struct Transaction {
    let value: Float
    let from: String
    let to: String
}

protocol TransactionsService {
    func send(transaction: Transaction)
}

class TransactionsServiceImpl: TransactionsService {
    var storage: Storage! // injected
    
    func send(transaction: Transaction) {
        
    }
}

class ServicesAssembly {
    let storagesAssembly = StoragesAssembly()
    
    var transactionsService: TransactionsService {
        let service = TransactionsServiceImpl()
        service.storage = storagesAssembly.inMemory
        
        return service
    }
}

let service = ServicesAssembly().transactionsService

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
