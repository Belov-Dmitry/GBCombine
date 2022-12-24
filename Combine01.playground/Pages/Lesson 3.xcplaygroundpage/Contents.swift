import UIKit
import Combine
import Foundation

var subscriptions = Set<AnyCancellable>()

public func example(of description: String, action: () -> Void) {
    print("\n------ Example of:", description, "------")
    action()
}

//example(of: "switchToLatest - Network Request") {
//    let url = URL(string: "https://source.unsplash.com/random")!
//
//    func getImage() -> AnyPublisher<UIImage?, Never> {
//        return URLSession.shared
//            .dataTaskPublisher(for: url)
//            .map { data, _ in UIImage(data: data) }
//            .print("image")
//            .replaceError(with: nil)
//            .eraseToAnyPublisher()
//    }
//
//    let taps = PassthroughSubject<Void, Never>()
//    taps
//        .map { _ in getImage() }
//        .switchToLatest()
//        .sink(receiveValue: { _ in })
//        .store(in: &subscriptions)
//    taps.send()
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//        taps.send()
//    }
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 3.1) {
//        taps.send()
//    }
//}

//example(of: "prepend(Output...)") {
//    let publisher = [3, 4].publisher
//    publisher
//        .prepend(1, 2)
//        .sink(receiveValue: { print ($0) })
//        .store(in: &subscriptions)
//}

//example(of: "prepend(Sequence)") {
//    let publisher = [5, 6, 7].publisher
//    publisher
//        .prepend([3, 4])
//        .prepend(Set(1...2))
//        .sink(receiveValue: { print ($0) })
//        .store(in: &subscriptions)
//}

//example(of: "prepend(Publisher)") {
//    let publisher1 = [3, 4].publisher
//    let publisher2 = [1, 2].publisher
//    publisher1
//        .prepend(publisher2)
//        .sink(receiveValue: { print ($0) })
//        .store(in: &subscriptions)
//}

//example(of: "prepend(Publisher) #2") {
//    let publisher1 = [3, 4].publisher
//    let publisher2 = PassthroughSubject<Int, Never>()
//    publisher1
//        .prepend(publisher2)
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//
//    publisher2.send(1)
//    publisher2.send(2)
//
//    publisher2.send(completion: .finished)
//}

//enum MyError: Error {
//    case caseError
//}
//
//example(of: "prepend(Publisher) #3") {
//    let publisher1 = [3, 4].publisher.mapError { _ in MyError.caseError }
//    let publisher2 = PassthroughSubject<Int, MyError>()
//    publisher1
//        .prepend(publisher2.catch { _ in Combine.Empty<Int, MyError>(completeImmediately: true) })
//        .sink(receiveCompletion: { print("got comletion: \($0)") },
//              receiveValue: { print($0) })
//        .store(in: &subscriptions)
//
//    publisher2.send(1)
//    publisher2.send(2)
//
//    publisher2.send(completion: .failure(MyError.caseError))
//}

//example(of: "merge(with:)") {
//    let publisher1 = PassthroughSubject<Int, Never>()
//    let publisher2 = PassthroughSubject<Int, Never>()
//
//    publisher1
//        .merge(with: publisher2)
//        .sink(receiveCompletion: { _ in print("Comleted") },
//              receiveValue: { print($0) })
//        .store(in: &subscriptions)
//
//    publisher1.send(1)
//    publisher1.send(2)
//    publisher2.send(3)
//    publisher1.send(4)
//    publisher2.send(5)
//    publisher1.send(completion: .finished)
//    publisher2.send(completion: .finished)
//}

//example(of: "combineLatest") {
//    let publisher1 = PassthroughSubject<Int, Never>()
//    let publisher2 = PassthroughSubject<String, Never>()
//
//    publisher1
//        .combineLatest(publisher2)
//        .sink(receiveCompletion: { _ in print("Comleted") },
//              receiveValue: { print("P1: \($0), P2: \($1)") })
//        .store(in: &subscriptions)
//
//    publisher1.send(1)
//    publisher1.send(2)
//    publisher2.send("a")
//    publisher2.send("b")
//    publisher1.send(3)
//    publisher2.send("c")
//    publisher1.send(completion: .finished)
//    publisher2.send(completion: .finished)
//}

//class MyClass {
//    var name: String = ""
//
//    init(name: String) {
//        self.name = name
//    }
//}
//example(of: "combineLatest #2") {
//    let publisher1 = PassthroughSubject<Int, Never>()
//    let publisher2 = PassthroughSubject<String, Never>()
//    let publisher3 = PassthroughSubject<MyClass, Never>()
//
//    publisher1
//        .combineLatest(publisher2, publisher3)
//        .sink(receiveCompletion: { _ in print("Completed")},
//              receiveValue: { print("P1: \($0), P2: \($1), P3: \($2.name) ") })
//        .store(in: &subscriptions)
//
//    publisher1.send(1)
//    publisher1.send(2)
//    publisher2.send("a")
//    publisher2.send("b")
//    publisher3.send(MyClass(name: "John"))
//    publisher1.send(3)
//    publisher2.send("c")
//
//    publisher1.send(completion: .finished)
//    publisher2.send(completion: .finished)
//    publisher3.send(completion: .finished)
//}
  
//example(of: "zip") {
//    let publisher1 = PassthroughSubject<Int, Never>()
//    let publisher2 = PassthroughSubject<String, Never>()
//    let publisher3 = PassthroughSubject<MyClass, Never>()
//
//    publisher1
//        .zip(publisher2, publisher3)
//        .sink(receiveCompletion: {_ in print("Completed")},
//              receiveValue: { print("P1 \($0), P2 \($1), P3 \($2)") })
//        .store(in: &subscriptions)
//
//    publisher1.send(1)
//    publisher1.send(2)
//    publisher2.send("a")
//    publisher2.send("b")
//    publisher1.send(3)
//    publisher3.send(MyClass(name: "John"))
//    publisher2.send("c")
//    publisher2.send("d")
//
//    publisher1.send(completion: .finished)
//    publisher2.send(completion: .finished)
//    publisher3.send(completion: .finished)
//}

//    let subject = PassthroughSubject<String, Never>()
//    let debounced = subject
//        .debounce(for: .seconds(1.0), scheduler: DispatchQueue.main)
//        .share()
//
//    let typingHelloWorld: [(TimeInterval, String)] = [
//        (0.0, "H"),
//        (0.1, "He"),
//        (0.2, "Hel"),
//        (0.3, "Hell"),
//        (0.4, "Hello"),
//        (0.5, "Hello "),
//        (0.6, "Hello w"),
//        (2.0, "Hello wo"),
//        (2.1, "Hello wor"),
//        (2.2, "Hello worl"),
//        (2.3, "Hello world")
//    ]
//
//    let startDate = Date()
//    let deltaFormatter: NumberFormatter = {
//        let format = NumberFormatter()
//        format.negativePrefix = ""
//        format.minimumFractionDigits = 1
//        format.maximumFractionDigits = 1
//        return format
//    }()
//
//    var deltaTime: String {return deltaFormatter.string(for: Date().timeIntervalSince(startDate))!
//    }
//
//    let subscription1 = subject.sink { string in
//        print("+\(deltaTime)s: Subject emitted: \(string)")
//
//    }
//    let subscription2 = subject.sink { string in
//        print("+\(deltaTime)s: Debounced emitted: \(string)")
//    }
//    for item in typingHelloWorld {
//        DispatchQueue.main.asyncAfter(deadline: .now() + item.0) {
//            subject.send(item.1)
//        }
//    }
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + typingHelloWorld.last!.0 + 2) {
//        subject.send(completion: .finished)
//    }





//let queue = DispatchQueue(label: "Collect")
//let passSubj = PassthroughSubject<Int, Error>()
//let subscription = passSubj
//    .collect(.byTime(queue, .seconds(1.0)))
//    .sink(receiveCompletion: { completion in
//        print("received the completion", String(describing: completion))
//    }, receiveValue: { responseValue in
//        print(responseValue)
//    })
//queue.asyncAfter(deadline: .now() + 0.1, execute: {
//    passSubj.send(1)
//})
//queue.asyncAfter(deadline: .now() + 0.2, execute: {
//    passSubj.send(2)
//})
//queue.asyncAfter(deadline: .now() + 1, execute: {
//    passSubj.send(3)
//})
//queue.asyncAfter(deadline: .now() + 3.1, execute: {
//    passSubj.send(4)
//})
//queue.asyncAfter(deadline: .now() + 3.2, execute: {
//    passSubj.send(5)
//})

//let queue = DispatchQueue(label: "Collect")
//let passSubj = PassthroughSubject<Int, Error>()
//let collectMaxCount = 4
//let subscription = passSubj
//    .collect(.byTimeOrCount(queue, .seconds(1.0), collectMaxCount))
//    .sink(receiveCompletion: { completion in
//        print("received the completion", String(describing: completion))
//    }, receiveValue: { responseValue in
//        print(responseValue)
//    })
//queue.asyncAfter(deadline: .now() + 0.1, execute: {
//    passSubj.send(1)
//})
//queue.asyncAfter(deadline: .now() + 0.2, execute: {
//    passSubj.send(2)
//})
//queue.asyncAfter(deadline: .now() + 0.3, execute: {
//    passSubj.send(3)
//})
//queue.asyncAfter(deadline: .now() + 0.4, execute: {
//    passSubj.send(4)
//})
//queue.asyncAfter(deadline: .now() + 0.5, execute: {
//    passSubj.send(5)
//})

//let myString = "1"
//var myUnicode = myString.unicodeScalars
//print(myUnicode)
//let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"

let flowers = ["Гномик "].publisher
    .sink(receiveCompletion: { print($0) }, receiveValue: {
        for v in $0.unicodeScalars {
        print(v.value) }
    }
)
