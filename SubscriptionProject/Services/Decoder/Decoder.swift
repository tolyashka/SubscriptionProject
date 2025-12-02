//
//  Decoder.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 02.12.2025.
//

import Foundation

protocol DataDecodable {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

extension JSONDecoder: DataDecodable { }
