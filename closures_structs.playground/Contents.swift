import UIKit

var str = "Hello, playground"

/*Замыкания*/

var x = 0
var y = 1

let closure = {
    x += 2
    print("hello!")
}

// сигнатура (Int,Double) -> Void
func someFunction(a: Int, b: Double)  {
}

let addClosure = {(arg: Int) -> Void in
    x += arg
}

let resultClosure = {(arg: Int) -> Int in
    return x + arg
}


closure()
x
addClosure(12)
x

let r = resultClosure(12)

// Усложнение - capture list

//let addClosure = {(arg: Int) -> Void in
//    x += arg
//}

// vs

let addClosure1 = {[x, y] (arg: Int) -> Void in
   // x += arg - нельзя, x - константа
}

// Приложения - функция, меняет элементы массива. преобразование задается замыканием

func changeArray(array: [Int], closure: (Int) -> Int) -> [Int] {
    var out = [Int]()
    
    for element in array {
        let changedElement = closure(element)
        out.append(changedElement)
    }
    
    return out
}

// vs

//func changeArray1(array: [Int]) -> [Int] {
//    var out = [Int]()
//
//    for element in array {
//        let changedElement = element * 2
//        out.append(changedElement)
//    }
//
//    return out
//}


let arrayToChange = [1,2,3,4,5,6]

let multipleClosure = { (arrayElement: Int) -> Int in
    return arrayElement * 2
}

let minusOneClosure = { (arrayElement: Int) -> Int in
    return arrayElement - 1
}


let newArray = changeArray(array: arrayToChange, closure: multipleClosure)
let newArray1 = changeArray(array: arrayToChange, closure: minusOneClosure)

// синтаксический сахар замыканий

let newArray2 = changeArray(array: arrayToChange, closure: { element in
    return Int(pow(Double(element), 2))
})

let newArray3 = changeArray(array: arrayToChange) { element in
    return element - 2
} // trailing closure

let newArray4 = changeArray(array: arrayToChange) {
    return $0 - 4
}

let newArray5 = changeArray(array: arrayToChange) { $0 - 10 }

func filter(array: [Int], closure: (Int) -> Bool) -> [Int] {
    var outArray = [Int]()
    
    for element in array {
        if closure(element) {
            outArray.append(element)
        }
    }
    
    return outArray
}


let newArray6 = filter(array: arrayToChange) { $0 % 2 != 0 } // возвращаем только нечетные числа
print(newArray6)

// ВСТРОЕННЫЕ В МАССИВ ОПЕРАЦИИ С ЗАМЫКАНИЯМИ


// вместо функции changeArray(array

let newArray7 = arrayToChange.map { element in
    return element * 2
}

// аналогичные записи

let newArray77 = arrayToChange.map { $0 * 2 } // меняем коллекцию
let newArray8 = arrayToChange.filter { $0 % 2 == 0 } // оставляем только четные числа в коллекции
let index = arrayToChange.firstIndex { $0 % 2 != 0 } // индекс первого нечетного элемента
let sum = arrayToChange.reduce(0) {(prevResult, currentElement) -> Int in
    return prevResult + currentElement
} // сумма элементов массива

let mult = arrayToChange.reduce(1) { $0 * $1 } // произведение элементов массива
print(mult)

let sorted1 = arrayToChange.sorted { $0 > $1 }
let sorted2 = arrayToChange.sorted { $0 < $1 }

let mappedArray: [Int] = ["0", "1", "3", "sdkjvwrkjb", "5"].compactMap {
    Int($0)
} // compactMap - как map, но если в замыкании опционал, то элемент не попадет в выходную коллекцию

print(mappedArray)

let out1: [String] = ["0", "1", "3", "sdkjvwrkjb", "5"].compactMap {
    if Int($0) == nil {
        return $0
    } else {
        return nil
    }
}

func fetchMessages(offset: Int, count: Int, completion: ([String]) -> Void) {
    completion(["one", "two"])
}

// vs

func fetchMessages1(offset: Int, count: Int) -> [String] {
    return ["one", "two"]
}

let messages = fetchMessages1(offset: 0, count: 10)

// async - multithreading
fetchMessages(offset: 0, count: 10) { messages in
    // display ->
}

// Date

// ------ STRUCTS AND CLASSES ------- //

// в других языках - int, double и class/struct
// у нас все - struct / class
//https://ru.wikipedia.org/wiki/%D0%9E%D0%B1%D1%8A%D0%B5%D0%BA%D1%82%D0%BD%D0%BE-%D0%BE%D1%80%D0%B8%D0%B5%D0%BD%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%BD%D0%BE%D0%B5_%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5
// SOLID
// https://refactoring.guru/ru/design-patterns

/*
 - текст: String ("привет, встречаемся в 5")
 - дата отправки: Date
 - отправитель: User { nick: String, avatar: URL }
 - состояние: State { case new, delivered, read... }
 */

// описание интерфейса структуры
struct User {
    let name: String
    let avatar: URL?
}

enum State {
    case new
    case delivered
    case read
}

struct Message {
    // properties
    let id: String
    let text: String
    let sendDate: Date
    let user: User // зависимость
    var state: State
}

let user: User
func add(user: User) {}
[User]()

// создание экземпляров структур (создание объектов)

let user1 = User(name: "test", avatar: URL(string: "https://my-cdn"))
let message = Message(id: UUID().uuidString,
                      text: "привет!",
                      sendDate: Date(),
                      user: user1,
                      state: .new)

// обращение к интерфейсу структуры (интерфейс - то, к чему можем обратиться с помощью оператора ".")
// экземпляр структуры будем звать далее объектом

message.state
message.text

// конструктор, методы, private/public, struct vs class, протокол(?)
