import UIKit

// строгая типизация

var str = "Hello, playground"
str = "1"

let x: Int = 0

//let a = "12"
//var b = 1
//b = a

// Int, Float, Double, String, Character, Decimal, Bool, UInt, Int32, Int64, UInt32
// 10000001010 -> 1*2^0 + 1*2^1 + 0*2^2 + 1*2^3 + ...

// операторы (бинарные)

// операнд1 [оператор] опреранд2 -> результат :  +,-,/,*,%, =(присвоение), >, <, <=, >=, !=, ==, ===
// операторы должны быть реализованы для типов (реализация берется у левого операнда)

let x1 = 1
let y = 2
let resultx1y = x1 + y

let str1 = "sdvfv"
let str2 = "sdvserg"
let str12 = str1 + str2 // "sdvfvsdvserg"

// опреаторы (унарные)

// +=, *=, /=
let x2 = 3
var y2 = 4

y2 += x2

y2 = y2 + x2
// = л.ч. y2 | п.ч. (y2+x2) | л.ч. y2 п.ч x2
"[(3 + 4) - 6] * 8"


// приведение к типам

let x3 = 4
let y3 = 5.455

let z = Double(x3) / y3
let z1 = x3 / Int(y3)
let zrounded = round(y3)

let z4 = "3.45"
let d = Double(z4) // OPTIONAL

// прочитать про OPTIONAL (Int?, String?)
//
//func g() -> Int { return 0 }
//
//let z = g()
//
//if z != nil {
//
//}

// ФУНКЦИИ

func name(arg1: Int, arg2: String, arg3: Double) -> Int {
    let r = arg1 + Int(arg3)
    
    return r
}

func voidFunc(arg1: Int) -> Void {
    print("аргумент \(arg1)")
}

func empty() {
    print("no op")
}

empty()
let result = name(arg1: 1 + name(arg1: 1, arg2: "", arg3: 4),
                  arg2: "",
                  arg3: y3)
var m = 0

m += name(arg1: 1, arg2: "", arg3: 3)

// SCOPE (область видимости переменных)

/*
 
 GLOBAL
 
 func f(args) {
    GLOBAL
 
    args
    local
 
    IF() {
       GLOBAL
 
        args
        local
        
        local2
    }
 
 
    GLOBAL

    args
    local

 }
 
 GLOBAL
 
 f(23)
 
 {
    {
        {
        }
    }
 }
 */

print("fwregregerg")
exit(-1)
sleep(23)

//class Y {
//    var state: ""
//
//    func drop() {
//        state = ""
//    }
//}
//
//class X {
//    let prop: Y
//
//    func drop() {
//        prop.drop()
//    }
//}
