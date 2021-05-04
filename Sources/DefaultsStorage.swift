//
//  DefaultsStorage.swift
//  VCStorage
//
//  Created by Valentin Cherepyanko on 20/06/2018.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public struct DefaultsStorage {

    private let defaults: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(_ defaults: UserDefaults,
                encoder: JSONEncoder = JSONEncoder(),
                decoder: JSONDecoder = JSONDecoder()) {

        self.defaults = defaults
        self.encoder = encoder
        self.decoder = decoder
    }
}

extension DefaultsStorage: IStorage {

    public func save<T: Codable>(_ object: T, for key: IObjectKey) {

        if let encodedData = try? self.encoder.encode(object) {
            self.defaults.set(encodedData, forKey: key.stringID)
        } else {
            self.defaults.set(object, forKey: key.stringID)
        }
    }

    public func fetch<T: Codable>(for key: IObjectKey) -> T? {

        guard let any = self.defaults.value(forKey: key.stringID) else {
            return nil
        }

        switch any {
        case let data as Data:
            return try? self.decoder.decode(T.self, from: data)
        case let typedObject as T:
            return typedObject
        default:
            return nil
        }
    }

    public func remove(for key: IObjectKey) {
        self.defaults.removeObject(forKey: key.stringID)
    }
}
