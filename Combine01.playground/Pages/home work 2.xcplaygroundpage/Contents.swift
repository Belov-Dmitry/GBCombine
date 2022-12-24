import UIKit
import Combine
import Foundation

//#1
(1...100).publisher
    .dropFirst(50)
    .prefix(20)
    .filter({$0 % 2 == 0})
    .sink(receiveCompletion: { print($0) },
          receiveValue: { print($0) })
    
//#2
func arithmeticalMean (_ arrayOfNSNumber: [NSNumber]) -> Double {
    let myArray = arrayOfNSNumber.map{ Double(truncating: $0) }
    let sumArray = myArray.reduce(0, +)
    let avgArrayValue = sumArray / Double(myArray.count)
    print("Среднее арифметическое: \(avgArrayValue)")
    return avgArrayValue
}

let formatter = NumberFormatter()
var subscriptions = Set<AnyCancellable>()
var array = [NSNumber]()
["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"].publisher
    .compactMap{formatter.number(from: $0)}
    .collect()
    .sink(receiveValue: {array.append(contentsOf: $0)})
    .store(in: &subscriptions)
print(array)
arithmeticalMean(array)

