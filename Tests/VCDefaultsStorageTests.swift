//
//  VCStorageTests.swift
//  VCStorage
//
//  Created by Valentin Cherepyanko on 12/04/2019.
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

import XCTest
@testable import VCStorage

class VCDefaultsStorageTests: XCTestCase {

    let storage = DefaultsStorage(UserDefaults.standard)

    enum StorageKey: String, IObjectKey {
        case string
        case object
        case toRemove

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

    func testRemovingObjects() {
        let object = "to remove"
        self.storage.save(object, for: StorageKey.toRemove)

        XCTAssertEqual(self.storage.fetch(for: StorageKey.toRemove)!, "to remove")

        self.storage.remove(for: StorageKey.toRemove)

        let fetched: String? = self.storage.fetch(for: StorageKey.toRemove)

        XCTAssertNil(fetched)
    }
}
