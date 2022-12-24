import UIKit
import Combine
import Foundation
//var someInts = [Int]()
//print("someInts is of type [Int] with \(someInts.count) items.")
//// Выведет "someInts is of type [Int] with 0 items."
//someInts.append(3)
//print(someInts)
//// массив someInts теперь содержит одно значение типа Int
//someInts = []
//// массив someInts теперь пуст, но все равно имеет тип [Int]

var subscriptions = Set<AnyCancellable>()

public func example(of description: String, action: () -> Void) {
    print("\n------ Example of:", description, "------")
    action()
}

example(of: "collect") {
    
    ["A", "B", "C", "D", "E"].publisher
//        .collect()
        .collect(2)
        .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
        .store(in: &subscriptions)
}

//example(of: "map") {
//    // 1 создали форматтер
//    let formatter = NumberFormatter()
//    formatter.numberStyle = .spellOut
//    // 2 создали издателя целых чисел
//    [123, 4, 56].publisher
//    // 3 используем map для преобразования цифр в слова
//        .map {
//            formatter.string(for: NSNumber(integerLiteral: $0)) ?? ""
//        }
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}

//example(of: "tryMap") {
//    // 1 создали издателя строки, представляющей несуществующее имя каталога
//    Just("Directory name that does not exist")
//    // 2 используем tryMap, чтобы попытаться получить содержимое каталога
//        .tryMap { try FileManager.default.contentsOfDirectory(atPath: $0) }
//    // 3 получаем и выводим любые значения или события завершения
//        .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}

//public struct Chatter {
//    public let name: String
//    public let message: CurrentValueSubject<String, Never>
//    public init(name: String, message: String) {
//        self.name = name
//        self.message = CurrentValueSubject(message)
//    }
//}
//example(of: "flatMap") {
//    // 1. Создали два примера разговора
//    let charlotte = Chatter(name: "Charlotte", message: "Hi, I'm Charlotte!")
//    let james = Chatter(name: "James", message: "Hi, I'm James!")
//    // 2. Создали издателя сообщений, инициализированного с Charlotte
//    let chat = CurrentValueSubject<Chatter, Never>(charlotte)
//    // 3. Подписались на чат и печатаем полученные сообщения из разговоров
//    chat
//    chat
//       //.flatMap { $0.message }
//        .flatMap(maxPublishers: .max(2)) { $0.message }
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//    // 4 меняем сообщение у Шарлотты
//    charlotte.message.value = "Charlotte: How's it going?"
//    // 5 меняем значение у publisher на Джеймс
//    chat.value = james
//
//    james.message.value = "James: Doing great. You?"
//    charlotte.message.value = "Charlotte: I'm doing fine thanks."
//}

//example(of: "replaceNil") {
//    // 1. Создали массив элементов типа Optional<String>
//    ["A", nil, "C"].publisher
//        .replaceNil(with: "-")
//        .map { $0! }
//    // 2. Используем оператор для замены всех nil на “-”
//        .sink(receiveValue: { print($0) })
//    // 3. Выводим каждое значение в консоль
//        .store(in: &subscriptions)
//}

//example(of: "scan") {
//    var dailyGainLoss: Int { .random(in: -10...10) }
//    let days = (0..<15) .map { _ in dailyGainLoss } .publisher
//    days
//        .scan(50) { latest, current in
//            max(0, latest + current)
//        }
//        .sink(receiveValue: { _ in })
//        .store(in: &subscriptions)
//}

//example(of: "filter") {
//    let numbers = (100...200).publisher
//    numbers
//        .filter { $0 % 3 == 0 }
//        .sink(receiveValue: { n in
//            print("\(n) is a multiple of 3!")
//        })
//        .store(in: &subscriptions)
//}

//example(of: "first(where:)") {
//    let numbers = (1...9).publisher
//    numbers
//        .first(where: { $0 - 5 > 0 })
//        .sink(receiveCompletion: { print("Completed with: \($0)") },
//              receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}

//example(of: "drop(while:)") {
//    let numbers = (1...10).publisher
//    numbers
//        .drop(while: { $0 % 5 != 0 })
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}

//example(of: "drop(untilOutputFrom:)") {
//    let isReady = PassthroughSubject<Void, Never>()
//    let taps = PassthroughSubject<Int, Never>()
//    taps
//        .drop(untilOutputFrom: isReady)
//        .sink(receiveValue: { print($0) })
//        .store(in: &subscriptions)
//    (1...5).forEach { n in
//        taps.send(n)
//        if n == 3 {
//            isReady.send()
//        }
//    }
//}
