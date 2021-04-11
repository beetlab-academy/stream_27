import UIKit

var str = "Hello, playground"

struct X {
    let y: String
}

// STRUCT, ENUM - VALUE TYPES

struct Employee {
    var name: String
    // let boss: Employee - запрещено!
    let x: X
}

// |name|--|x|--||name|--|x|--||name|--|x|--||name|--|x|--|||name|--|x|--||name|--|x|--||||name|--|x|--||name|--|x|--||||name|--|x|--||name|--|x|--||||name|--|x|--||name|--|x|--||||||

// vs

// CLASS - REFENCE TYPE


// SWIFT METHOD DISPATCH - загуглите

class Employee1 {
    var name: String
    let boss: Employee1?
    let x: X
    
    init(name: String, boss: Employee1?, x: X) {
        self.name = name
        self.boss = boss
        self.x = x
    }
    
    convenience init(boss: Employee1?) {
        self.init(name: "", boss: boss, x: X(y: ""))
    }
}

func modify1(employee: Employee) {
    // employee.name = "new name" - запрещено!
}

func modify2( employee: inout Employee) {
    employee.name = "new name"
}

var obj = Employee(name: "Иван", x: X(y: ""))

modify2(employee: &obj)

obj.name

func modify3(employee: Employee1) {
    employee.name = "sefwefwef"
}

let boss = Employee1(boss: nil)
let obj2 = Employee1(boss: boss)

modify3(employee: obj2)

obj2.name
/*
 - interface, protocol, dependency
 - dependency injection
 - assembly
 
 done
 */

class A {
    static let x = 0
}

A.x // обращение к статической переменной

enum Currency {
    case rub
    case usd
    case euro
}

struct Deposit {
    let value: Float
    let code: Currency
    
    // static func and methods
    
    static func +(lhs: Deposit, rhs: Deposit) -> Deposit {
        return Deposit(value: lhs.value + rhs.value, code: lhs.code)
    }
}

let depo1 = Deposit(value: 100, code: .rub)
let depo2 = Deposit(value: 100_000, code: .rub)

let result = depo1 + depo2






