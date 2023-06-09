//
//  ExtensionBundle.swift
//  OnlineShop
//
//  Created by NikoS on 12.09.2022.
//

import UIKit
import Combine

extension Bundle {
    func readFile(file: String) -> AnyPublisher<Data, Error> {
        self.url(forResource: file, withExtension: nil)
            .publisher
            .tryMap{ string in
                guard let data = try? Data(contentsOf: string) else {
                    fatalError("Failed to load \(file) from bundle.")
                }
                return data
            }
            .mapError { error in
                return error
            }.eraseToAnyPublisher()
    }
    func decodeable<T: Decodable>(fileName: String) -> AnyPublisher<T, Error> {
        readFile(file: fileName)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
}
