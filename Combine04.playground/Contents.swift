import UIKit
import Combine

public struct Character: Codable {
    public var id: Int64
    public var name: String
    public var status: String
    public var species: String
    public var type: String
    public var gender: String
    public var image: String

    public init(id: Int64, name: String, status: String, species: String, type:
                String, gender: String, image: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.image = image
    }
}
public struct CharacterPage: Codable {
    public var info: PageInfo
    public var results: [Character]

    public init(info: PageInfo, results: [Character]) {
        self.info = info
        self.results = results
    }
}
public struct PageInfo: Codable {
    public var count: Int
    public var pages: Int
    public var prev: String?
    public var next: String?

    public init(count: Int, pages: Int, prev: String?, next: String?) {
        self.count = count
        self.pages = pages
        self.prev = prev
        self.next = next
    }
}



struct APIClient {

    enum Method {
        static let baseURL = URL(string: "https://rickandmortyapi.com/api/")!
        case character(Int)
        case location
        case episode

        var url: URL {
            switch self {
            case .character(let id):
                return Method.baseURL.appendingPathComponent("character/\(id)")
            default:
                // Homework
                fatalError("URL for this case is undefined.")
            }
        }
    }

    enum Error: LocalizedError {
        case unreachableAddress(url: URL)
        case invalidResponse

        var errorDescription: String? {
            switch self {
            case .unreachableAddress(let url): return "\(url.absoluteString) is unreachable"
            case .invalidResponse: return "Response with mistake"
            }
        }
    }

    private let decoder = JSONDecoder()
    private let queue = DispatchQueue(label: "APIClient", qos: .default, attributes: .concurrent)

func character(id: Int) -> AnyPublisher<Character, Error> {
    return URLSession.shared
        .dataTaskPublisher(for: Method.character(id).url) //создаём задачу на загрузку данных по переданному адресу
        .receive(on: queue) //указываем очередь, в которой будем получать ответ
        .map(\.data)
        //.print()
        .decode(type: Character.self, decoder: decoder)
//        .catch { _ in Empty<Character, Error>() }
        .mapError({ error -> Error in
            switch error {
            case is URLError:
                return Error.unreachableAddress(url: Method.character(id).url)
            default:
                return Error.invalidResponse }
        })
        .eraseToAnyPublisher()
}

    func mergedCharacters(ids: [Int]) -> AnyPublisher<Character, Error> {
        precondition(!ids.isEmpty)
        let initialPublisher = character(id: ids[0])
        let remainder = Array(ids.dropFirst())
        return remainder.reduce(initialPublisher) { (combined, id) in
            return combined
                .merge(with: character(id: id))
                .eraseToAnyPublisher()
        }
    }

}

let apiClient = APIClient()
var subscriptions: Set<AnyCancellable> = []
apiClient.character(id: 5)
    .sink(receiveCompletion: { print($0) },
          receiveValue: { print($0) })
    .store(in: &subscriptions)


apiClient.mergedCharacters(ids: [123, 77, 9])
    .sink(receiveCompletion: { print($0) },
          receiveValue: { print($0) })
    .store(in: &subscriptions)

//import UIKit
//import Combine
//
//let url = URL(string: "https://openweathermap.org")!
//var store: Set<AnyCancellable> = Set<AnyCancellable>()
//
//let publisher = URLSession.shared
//    .dataTaskPublisher(for: url)
//    .map(\.data)
//    .multicast { PassthroughSubject<Data, URLError>() }
//    //.print()
////print(publisher)
//
//publisher
//    .sink(receiveCompletion: { completion in
//        if case .failure(let err) = completion {
//            print("Sink1 Retrieving data failed with error \(err)")
//        }
//    }, receiveValue: { object in
//        print("Sink1 Retrieved object \(object)")
//    }).store(in: &store)
//
//publisher
//    .sink(receiveCompletion: { completion in
//        if case .failure(let err) = completion {
//            print("Sink2 Retrieving data failed with error \(err)")
//        }
//    }, receiveValue: { object in
//        print("Sink2 Retrieved object \(object)")
//    }).store(in: &store)
//
//publisher.connect().store(in: &store)
//
