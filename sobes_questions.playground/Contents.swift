import UIKit

var greeting = "Hello, playground"

// явление полиморфизма
protocol A {
    func a()
}

protocol B {
    func b()
}

class C {
    func baseFunc() {}
}

class Polymorphic: C, A, B {
    override func baseFunc() {
        super.baseFunc()
    }
    
    func a() {
        
    }
    
    func b() {
        
    }
    
    func otherMethod() {
        
    }
}

let obj = Polymorphic()

struct Y: A {
    func a() {
        
    }
}

let x1: Polymorphic = obj
let x2: A = Y() //obj
let x3: B = obj
let x4: C = obj

x2.a()
x3.b()

class A21<T> {
    let val: T
    init (val: T) {
        self.val = val
    }
}

extension A21 where T: CustomStringConvertible {
    func printDescription() {
        print(val)
    }
}

class AnyA21 {
    let value: Any
    
    init<T>(value: T) {
        self.value = value
    }
}

class User {}


let a: A21<Int> = A21(val: 2)
let b: A21<String> = A21(val: "aef")
let c: A21<User> = A21(val: User())

a.printDescription()
b.printDescription()

let array: [AnyA21] = [AnyA21(value: a), AnyA21(value: b) , AnyA21(value:c)]

// создать словарь и массив , словарь и массив должны быть одинаковы по количеству пар и элементов необходимо изменить все значения в словаре на элементы в массиве
//var outdict = ["key1": 11, "key2": 12, "key3": 13, "key4": 14]

var dict = ["key1": 1, "key2": 2, "key3": 3, "key4": 4]
var array1 = [11, 12, 13, 14]


var outDict = [String: Int]()
let keys = Array(dict.keys)

for (index, element) in array1.enumerated() {
    let key = keys[index]
    outDict[key] = element
}

print(outDict)

// приебосы к массиву

var array12 = [11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14,11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14, 11, 12, 13, 14] // ...  134345436564456456

let q = array12
let p = array12
let e = array12
let sf4 = array12
let q1 = array12
let p2 = array12
let e3 = array12
let sf44 = array12
let q5 = array12
let p6 = array12
let e7 = array12
let sf48 = array12
let q9 = array12
let p4 = array12
let e5 = array12
let sf46 = array12
let sf4689 = array12
let sf466 = array12
let sf4636 = array12
let sf456 = array12
var sf463 = array12

sf463.append(12) // copy on-write
