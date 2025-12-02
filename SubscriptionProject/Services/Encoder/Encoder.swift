//
//  Encoder.swift
//  SubscriptionProject
//
//  Created by Анатолий Лушников on 02.12.2025.
//

import Foundation

protocol DataEncodable {
    func encode<T>(_ value: T) throws -> Data where T : Encodable
}

extension JSONEncoder: DataEncodable { }
