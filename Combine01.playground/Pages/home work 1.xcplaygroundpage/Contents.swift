import UIKit
import Combine
//#1
let publisher = (1...10).publisher
//#2
final class IntSubscriber: Subscriber {
    typealias Input = Int
    typealias Failure = Never
    
    func factorial(_ N: Int) -> Int {
        if N == 1 {
            return 1
        } else {
            return N * factorial(N - 1)
        }
    }

    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    func receive(_ input: Int) -> Subscribers.Demand {
        print("Factorial", input, "is equal to", factorial(input))
        return.none
    }

    func receive(completion: Subscribers.Completion<Never>) {

    }
}
let subscriber = IntSubscriber()
publisher.subscribe(subscriber)

