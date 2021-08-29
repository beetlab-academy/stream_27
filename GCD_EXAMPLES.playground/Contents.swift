import UIKit
import Combine

var greeting = "Hello, playground"

// гонка (race condition)
func asyncFunc() -> Int {
    var result = 0
    print("1")
    DispatchQueue.global().async {
        print("2")
        result += 100
    }
    print("3")
    return result
}

func syncFunc() -> Int {
    var result = 0
    print("11")
    DispatchQueue.global().sync {
        print("12")
        result += 100
    }
    
    print("13")
    return result
}

func asyncFunc1(completion: @escaping (Int) -> Void) {
    var result = 0
    print("1")
    DispatchQueue.global().async {
        print("2")
        result += 100
        completion(result)
    }
    print("3")
}

func asyncFunc2() -> AnyPublisher<Int, Never> {
    Future { promise in
        var result = 0
        print("1")
        DispatchQueue.global().async {
            print("2")
            result += 100
            promise(.success(result))
        }
        print("3")
    }
    .eraseToAnyPublisher()
}


let x = asyncFunc()
let y = syncFunc()

asyncFunc1 {
    print("result: \($0)")
}

let cancellable = asyncFunc2()
    .sink {
        print("result2: \($0)")
    }

/*
 https://www.raywenderlich.com/5370-grand-central-dispatch-tutorial-for-swift-4-part-1-2
 https://www.raywenderlich.com/5371-grand-central-dispatch-tutorial-for-swift-4-part-2-2
 */

var array = [Int]()

//for i in 0..<100 {
//    DispatchQueue.global().async {
//        array.append(i)
//    }
//}

let url = URL(string: "http://data.fixer.io/api/latest?access_key=46fdb5d1ebbdc593682f41afc3985f77")!

typealias CurrencyCode = String

enum RatesServiceError: Error {
    case internalError
    case networkError(Error)
}

protocol RatesService {
    func load(base: CurrencyCode) -> AnyPublisher<[CurrencyCode: Double], RatesServiceError>
}

class RatesServiceImpl: RatesService {
    func load(base: CurrencyCode) -> AnyPublisher<[CurrencyCode : Double], RatesServiceError> {
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=46fdb5d1ebbdc593682f41afc3985f77&base=\(base)") else {
            return Future { $0(.failure(RatesServiceError.internalError)) }.eraseToAnyPublisher()
        }
        
        
        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .tryMap { (data: Data, response: URLResponse) -> [CurrencyCode : Double] in
                try JSONDecoder().decode([CurrencyCode : Double].self, from: data)
            }
            .mapError {
                .networkError($0)
            }
            .eraseToAnyPublisher()
    }
}

let service = RatesServiceImpl()

let cancellable1 = service
    .load(base: "RUB")
    .sink(receiveCompletion: {_ in}) {
        print("data: \($0)")
    }

// пример интеграции сервиса

class ViewController: UIViewController {
    var cancellable: AnyCancellable?
    var service: RatesService! // injected
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancellable = service
            .load(base: "RUB")
            .sink(receiveCompletion: {_ in}) {
                print("data: \($0)")
            }
    }
}
