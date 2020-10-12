//
//  IStorage.swift
//  Audiobooker
//
//  Created by Valentin Cherepyanko on 01/07/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

public protocol IObjectKey {
    var stringID: String { get }
}

public protocol IStorage {
    func fetch<T: Codable>(for key: IObjectKey) -> T?
    func save<T: Codable>(_ data: T, for key: IObjectKey)
    func remove(for key: IObjectKey)
}
