//
//  APIClient.swift
//  Combine-L4
//
//  Created by Dmitry Belov on 13.12.2022.
//

import Foundation
import Combine

struct APIClient {

    private let decoder = JSONDecoder()
    private let queue = DispatchQueue(label: "APIClient", qos: .default, attributes: .concurrent)
    
    func character(id: Int) -> AnyPublisher<Character, NetworkError> {
        return URLSession.shared
            .dataTaskPublisher(for: Method.character(id).url)
            .receive(on: queue)
            .map(\.data)
            .decode(type: Character.self, decoder: decoder)
    //        .catch { _ in Empty<Character, NetworkError>() }
            .mapError({ error -> NetworkError in
                switch error {
                case is URLError:
                    return NetworkError.unreachableAddress(url: Method.character(id).url)
                default:
                    return NetworkError.invalidResponse }
            })
            .eraseToAnyPublisher()
    }
    
    func mergedCharacters(ids: [Int]) -> AnyPublisher<Character, NetworkError> {
        precondition(!ids.isEmpty)
        
        let initialPublisher = character(id: ids[0])
        let remainder = Array(ids.dropFirst())
        
        return remainder.reduce(initialPublisher) { (combined, id) in
            return combined
                .merge(with: character(id: id))
                .eraseToAnyPublisher()
        }
    }

    func location(id: Int) -> AnyPublisher<Location, NetworkError> {
        return URLSession.shared
            .dataTaskPublisher(for: Method.location(id).url)
            .receive(on: queue)
            .map(\.data)
            .decode(type: Location.self, decoder: decoder)
            .mapError({ error -> NetworkError in
                switch error {
                case is URLError:
                    return NetworkError.unreachableAddress(url: Method.location(id).url)
                default:
                    return NetworkError.invalidResponse }
            })
            .eraseToAnyPublisher()
    }
    
    func episode(id: Int) -> AnyPublisher<Episode, NetworkError> {
        return URLSession.shared
            .dataTaskPublisher(for: Method.episode(id).url)
            .receive(on: queue)
            .map(\.data)
            .decode(type: Episode.self, decoder: decoder)
            .mapError({ error -> NetworkError in
                switch error {
                case is URLError:
                    return NetworkError.unreachableAddress(url: Method.episode(id).url)
                default:
                    return NetworkError.invalidResponse }
            })
            .eraseToAnyPublisher()
    }
}
