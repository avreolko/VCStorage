//
//  VCDefaultsStorage.swift
//
//  Created by Valentin Cherepyanko on 20/06/2018.
//  Copyright © 2018 Valentin Cherepyanko. All rights reserved.
//

import UIKit

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
			assertionFailure("Failed to load object from defaults")
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
}
