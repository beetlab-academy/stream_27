import UIKit

var greeting = "Hello, playground"


class DangerousClass {
    var array = [Int]()
    let lock = NSLock() // NSRecursiveLock
    let semaphore = DispatchSemaphore(value: 1)
    var context: os_unfair_lock_s = .init(_os_unfair_lock_opaque: 10)
    var dispatchQueue = DispatchQueue(label: "com.DangerousClass.queue", attributes: .concurrent)

    
    func add(digit: Int) {
        array.append(digit)
    }
    
    func addLock(digit: Int) {
        lock.lock()
        array.append(digit)
        lock.unlock()
    }
    
    func addSemaphore(digit: Int) {
        
        semaphore.wait(timeout: .distantFuture) // уменьшаем на 1, блокируем

        array.append(digit)

        semaphore.signal() // число уменьшается на 1, когда чиcло (0) - следующий тред ждет в очереди
    }
    
    func osLock(digit: Int) {
        os_unfair_lock_lock(&context)
        
        array.append(digit)
        
        os_unfair_lock_unlock(&context)
    }
    
    //// потокобезопасный массив / словаря и т д
    
    func gcdLock(digit: Int) {
        dispatchQueue.async(flags: .barrier) {
            self.array.append(digit)
        }
    }
    
    func read(at index: Int) -> Int {
        dispatchQueue.sync {
            self.array[index]
        }
    }
}


let obj = DangerousClass()


for i in 0..<1000 {
    DispatchQueue.global().async {
        obj.addLock(digit: 1)
    }
}

for i in 0..<1000 {
    DispatchQueue.global().async {
        obj.addSemaphore(digit: 1)
    }
}

/*https://stackoverflow.com/questions/59962747/osspinlock-was-deprecated-in-ios-10-0-use-os-unfair-lock-from-os-lock-h-i*/
//for i in 0..<1000 {
//    DispatchQueue.global().async {
//        obj.osLock(digit: 1)
//    }
//}
//
//obj.add(digit: 10)

for i in 0..<1000 {
    DispatchQueue.global().async {
        obj.gcdLock(digit: 1)
    }
}

/// на собесе говорят - ну ка потокобезопасный массив/словарь

class ThreadSafeArray<T> {
    var inner = [T]()
    let queue = DispatchQueue(label: "com.ThreadSafeArray.queue", attributes: .concurrent)
    
    func append(_ value: T) {
        queue.async(flags: .barrier) {
            self.inner.append(value)
        }
    }
    
    subscript(_ index: Int) -> T {
        queue.sync {
            self.inner[index]
        }
    }
}

class ThreadSafeDictionary<Value>{
    var inner = [AnyHashable: Value]()
    let queue = DispatchQueue(label: "com.ThreadSafeDictionary.queue", attributes: .concurrent)
    
    func append(_ value: Value, _ key: AnyHashable) {
        queue.async(flags: .barrier) {
            self.inner[key] = value
        }
    }
    
    subscript(_ key: AnyHashable) -> Value? {
        queue.sync {
            self.inner[key]
        }
    }
}
