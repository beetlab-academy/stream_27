import UIKit

var str = "Hello, playground"

/*
 Массив
 
 - последовательность элементов
 
 - в памяти элементы лежат один рядом с другим
 - потому есть возможность обращаться по индексам
 
 x[0] - addr, sizeof(x)
 addr[N] = addr[0] + N * sizeof(x)
 */

let x = 4

let intArray = [1,2,3,4,5,9]
let strArray: [String] = ["asfsef", "dfef"]

let heteroArray: [Any] = [1, "srfgerg"]

intArray[0]

func func1(array: [Int]) -> [String] {
    return []
}

var array1 = [1,2,3,4]
let array3 = [50,60,70]

let array4 = array1 + array3

array1.append(5)
array1.insert(-10, at: 0)
array1.insert(304, at: 6)
array1.insert(contentsOf: array3, at: 0)

array1.append(contentsOf: array3)

array1.count

// Циклы

/*
 
 for <variable>(_) in <Sequence> {
    // при каждом проходе по телу цикла <variable> принимает очередное значение из <Sequence>
 }
 
 */

for i in 0...5 {
    print(i)
}

print("***")

for i in stride(from: 0, through: 5, by: 1) {
    print(i)
}

print("***")

for i in stride(from: 0, to: 5, by: 1) {
    print(i)
}

print("***")

for i in stride(from: 5, to: 0, by: -1) {
    print(i)
}

print("***")

for i in 0..<5 {
    print(i)
}

print("***")

//for i in 5...0 {
//    print(i)
//}

for _ in 0...5 {
    print("executing")
}

print("***")

// массивы - приложение

func iterate(array: [String]) {
    for i in 0..<array.count {
        let element = array[i]
        
        print(element)
    }
    
    print("***")
    
    for element in array {
        print(element)
    }
    
    print("***")
    // Tuple
    for (index, element) in array.enumerated() {
        print("\(element)[\(index)]")
    }
}

iterate(array: ["one", "two", "aekfnwekn"])

func generate() -> [Int] {
    var out = [Int]()
    
    for i in 0..<10 {
        if i % 2 == 0 {
            out.append(i)
        }
    }
    
    return out
}

print(generate())

//func firstIndex(of digit: Int, in array: [Int]) -> Int {
//    var out = 0
//
//    for i in 0..<array.count {
//        if array[i] == digit {
//            out = i
//            break
//        }
//    }
//
//    return out
//}

func firstIndex(of digit: Int, in array: [Int]) -> Int {
    for i in 0..<array.count {
        if array[i] == digit {
            return i
        }
    }
    
    return NSNotFound
}


let array44 = [55,4,32,4,7]

//if firstIndex(of: 100, in: array44) != NSNotFound {
//    /// presents element
//} else {
//    print("not found")
//}

print(firstIndex(of: 100, in: array44))

// optional


func firstIndex1(of digit: Int, in array: [Int]) -> Int? {
    for i in 0..<array.count {
        if array[i] == digit {
            return i
        }
    }
    
    return nil
}

// Int -> Int? ; String -> String?; [Int] -> [Int]?;

// Enum (Enum with associated value), Generic

enum MyOptional<T> {
    case none
    case some(T)
}

func firstIndex2(of digit: Int, in array: [Int]) -> MyOptional<Int> {
    for i in 0..<array.count {
        if array[i] == digit {
            return .some(i)
        }
    }
    
    return .none
}

func firstIndex4(of digit: String, in array: [String]) -> MyOptional<Int> {
    for i in 0..<array.count {
        if array[i] == digit {
            return .some(i)
        }
    }
    
    return .none
}

let possibleIndex = firstIndex(of: 78, in: array44)

print("индекс - \(possibleIndex)")

let digit = array44[possibleIndex]

if possibleIndex != NSNotFound {
    // гарантированно число есть в массиве
} else {
    // не нашел число, функция вернула NSNotFound
}


let possibleIndex1 = firstIndex1(of: 4, in: array44)

// как не надо делать

let digit3 = array44[possibleIndex1!]


// if let
if let unwrappedIndex = possibleIndex1 {
    let digit = array44[unwrappedIndex]
} else {
    // nil
}


guard let unwrappedIndex = possibleIndex1 else {
    // nil
    exit(-1)
}

let digit1 = array44[unwrappedIndex]

// closures
// https://docs.swift.org/swift-book/LanguageGuide/Closures.html

/*
 
 firstIndex -> closure
 задачка по месяцам -> .map {}
 
 */
