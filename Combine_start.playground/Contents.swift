import UIKit
import Combine

var greeting = "Hello, playground"


let cancellable = [1,2,3,4].publisher.receive(on: DispatchQueue.main).map { "\($0)" }.sink(receiveCompletion: { completion in
    switch completion {
    case .failure:
        print("error")
    case .finished:
        print("finished")
    }
}, receiveValue: { value in
    print(value)
})

struct Data2 {}

struct ViewModelData {
    init(data: Data2) {}
}

protocol FetchService {
    func fetch() -> AnyPublisher<Data, Error>
}

protocol FetchService2 {
    func fetch(data: Data) -> AnyPublisher<Data2, Error>
}

class ViewController {
    var cancellable: AnyCancellable?
    var service: FetchService!
    var service2: FetchService2!
    
    func viewDidLoad() {
    }
    
    func buttonTapped() {
        cancellable = service
            .fetch()
            .flatMap { self.service2.fetch(data: $0) }
            .map { ViewModelData(data: $0) }
            .sink(receiveCompletion: {_ in}, receiveValue: { data in
            print("\(data)")
        })
    }
}

protocol SomeProtocol {
    
}

protocol GenericConstraint {
    associatedtype T
    
    func doSmth() -> T
}

class AnyGenericConstraint: GenericConstraint {
    func doSmth() -> Any {
        5
    }
}

enum SomeServiceError: Error {
    case test
}

protocol SomeService {
    func fetch(data: Data) -> AnyPublisher<Int, Error>
}

class SomeServiceImpl: SomeService {
    func fetch(data: Data) -> AnyPublisher<Int, Error> {
        Future { promise in
            promise(.success(45))
            promise(.failure(SomeServiceError.test))
        }
        .eraseToAnyPublisher()
        
//        Just(4).eraseToAnyPublisher()
    }
}

func someFunc1() -> Int? {
    5
}

enum SomeFuncError: Error {
    case error
}

func someFunc2() throws -> Int {
    throw SomeFuncError.error
    
    return 5
}

func someFunc3() -> Result<Int, SomeFuncError> {
    return .success(5)
    return .failure(.error)
}

do {
    let result = try someFunc2()
} catch {
    print(error)
}

switch someFunc3() {
case let .success(value):
    break
case let .failure(error):
    switch error {
    case .error:
        break
    }
}

struct Output {
    let value: Int
}

enum NetworkClientError: Error {
    
}

protocol NetworkClient {
    func load(completion: @escaping (Output?) -> Void) // нет обработки ошибок
    func load(completion: @escaping (Result<Output, NetworkClientError>) -> Void) // нету жизненного цикла подписки (нельзя отменить задачу) + трудно flatMap
    func load() -> AnyPublisher<Output, NetworkClientError>
}

class NetworkClientImpl {
    func load(completion: @escaping (Output?) -> Void) {
        guard let url = URL(string: "3commas...") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil)
            } else if let data = data {
                // парсить и вызывать completion()
            } else {
                completion(nil)
            }
        }
    }
}

/*
 
 1 задача  // есть номер телефона нужно из этого телефона вытащить цифры которые четные без остатка или в остатке 0

 Пример номера телефона ( + 4951344567)  // Подсказка сперва нужно избавиться от плюса
 
 */

"+4951344567"
    .publisher
    .filter { element in
        if let int = Int(String(element)), int % 2 == 0 {
            return true
        } else {
            return false
        }
    }
    .sink { element in
        print(element)
    }

let filteredString = "+4951344567".filter {
    if let int = Int(String($0)), int % 2 == 0 {
        return true
    } else {
        return false
    }
}

"+4951344567".forEach { character in
    if let int = Int(String(character)), int % 2 == 0 {
        print(int)
    }
}

class Assembly {
    func vc(completion: @escaping (Data)-> Void) {}
}

class Router {
    let assembly = Assembly()
    func present() -> AnyPublisher<Data, Never> {
        Future { promise in
            self.assembly.vc { data in
                promise(.success(data))
            }
        }
        .eraseToAnyPublisher()
        
    }
}

protocol SomeView {
    func display(int: Int)
}

class Presenter {
    var service: SomeService!
    var router: Router!
    var view: SomeView!
    var cancellable: AnyCancellable?
    
    func buttonTapped() {
        cancellable = router
            .present()
            .flatMap { self.service.fetch(data: $0) }
            .sink(receiveCompletion: {_ in}, receiveValue: {
                self.view.display(int: $0)
            })
    }
}
