import UIKit
import Combine

public func example (of description: String, action: () -> Void) {
    print("\n------ Example of:", description, "------")
    action()
}

example(of: "Publisher") {
    let myNotification = Notification.Name("MyNotification")
    let publisher = NotificationCenter.default
        .publisher(for: myNotification, object: nil)

let center = NotificationCenter.default
let observer = center.addObserver(
    forName: myNotification,
    object: nil,
    queue: nil) {notification in
        print("Notification received")
    }
    center.post(name: myNotification, object: nil)
    center.removeObserver(observer)
}

example(of: "Subscriber") {
    let myNotification = Notification.Name("MyNotification")
    let publisher = NotificationCenter.default
        .publisher(for: myNotification, object: nil)

let center = NotificationCenter.default
let subscription = publisher
        .sink{ _ in
            print("Notification received from a publisher")
        }

    center.post(name: myNotification, object: nil)
    subscription.cancel()
}

example(of: "Just") {
let just = Just("Hello world!")
    _ = just
        .sink(receiveCompletion: {
            print("Received complition", $0)
        },
              receiveValue: {
            print("Received value", $0)
        })
    _ = just.sink(receiveCompletion: {
        print("Received complition (another)", $0)
    },
          receiveValue: {
        print("Received value (another)", $0)
    })
}

example(of: "assign(to:on:)") {
    class SomeObject {
        var value: String = "" {
            didSet {
                print("Мы изменили value на: \(value)")
                print(value)
            }
        }
    }
    let object = SomeObject()
    let publisher = ["Hello", "world!"].publisher
    _ = publisher
        .assign(to: \.value, on: object)
}

// Custom subscriber
example(of: "Custom subscriber") {
    let publisher = (1...6).publisher

    final class IntSubscriber: Subscriber {
        typealias Input = Int
        typealias Failure = Never

        func receive(subscription: Subscription) {
            subscription.request(.max(3))
        }

        func receive(_ input: Int) -> Subscribers.Demand {
            print("Received value", input)
            return.unlimited
        }

        func receive(completion: Subscribers.Completion<Never>) {
            print("Receive complition", completion)
        }
    }
    let subscriber = IntSubscriber()
    publisher.subscribe(subscriber)
}

example(of: "Future") {
    func futureIncrement (
        integer: Int,
        afterDelay delay: TimeInterval) -> Future<Int, Never> {
            Future<Int, Never> { promise in
                print("Original")
                DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                    promise(.success(integer + 1))
                }
            }
        }
    var subscriptions = Set<AnyCancellable>()
    let future = futureIncrement(integer: 1, afterDelay: 3)
    
    future
        .sink(receiveCompletion: { print($0) },
              receiveValue: { print($0) })
        .store(in: &subscriptions)
}

example(of: "PassthroughSubject") {
    enum MyError: Error {
        case test
    }
    final class StringSubscriber: Subscriber {
        typealias Input = String
        typealias Failure = MyError
        
        func receive(subscription: Subscription) {
            subscription.request(.max(2))
        }
        
        func receive(_ input: String) -> Subscribers.Demand {
            print("Received value", input)
            return input == "World" ? .max(1) : .none
        }
        func receive(completion: Subscribers.Completion<MyError>) {
            print("Received complition", completion)
        }
    }
    let subscriber = StringSubscriber()
    let subject = PassthroughSubject<String, MyError>()
    subject.subscribe(subscriber)
    let subscription = subject
        .sink(receiveCompletion: { complition in
            print("Received complition (sink)", complition)
        },
              receiveValue: { value in
            print("Received value (sink)", value)
        }
        )
    
    subject.send("Hello!")
    subject.send("World!")
    
    //8
    subscription.cancel()
    
    //9
    subject.send("Still there?")
    
    subject.send(completion: .failure(MyError.test))
    
    subject.send(completion: .finished)
    subject.send("How about another one?")
}

