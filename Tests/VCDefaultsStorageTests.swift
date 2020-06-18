//
//  VCDefaultsStorageTests.swift
//  VCDefaultsStorageTests
//
//  Created by Valentin Cherepyanko on 12/04/2019.
//  Copyright © 2019 Valentin Cherepyanko. All rights reserved.
//

import XCTest
@testable import VCDefaultsStorage

class VCDefaultsStorageTests: XCTestCase {

    let storage = DefaultsStorage(UserDefaults.standard)

    enum StorageKey: String, IObjectKey {
        case string
        case object

        var stringID: String {
            return self.rawValue
        }
    }

    struct SomeStruct: Codable {
        let string: String
        let array: [String]
    }

    func testGenericTypeSavingAndFetching() {
        let string = "test"
        self.storage.save(string, for: StorageKey.string)

        let loadedString: String! = self.storage.fetch(for: StorageKey.string)
        XCTAssert(loadedString == "test")
    }

    func testComplexObjectSavingAndFetching() {
        let object = SomeStruct(string: "string", array: ["1", "2"])
        self.storage.save(object, for: StorageKey.object)

        let fetchedObject: SomeStruct! = self.storage.fetch(for: StorageKey.object)

        XCTAssert(fetchedObject.string == "string")
        XCTAssert(fetchedObject.array == ["1", "2"])
    }
}
