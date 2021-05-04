[![Tests](https://github.com/avreolko/VCStorage/workflows/Tests/badge.svg?branch=master)](https://github.com/avreolko/VCStorage/actions/workflows/tests.yml)
# VCStorage
`IStorage` interface for your objects

## Features
- Codable support
- User defaults implementation included

## Installation
Install with SPM 📦

## Usage
```swift
enum Key: IObjectKey, String {
    case bar
}

struct SomeData: Codable {
    let foo: String
}

let storage = DefaultsStorage(UserDefaults.standard)

let dataToSave = SomeData(foo: "🤓")
storage.save(data, for: Key.bar)

let fetchedData: SomeData?  = self.storage.fetch(for: Key.bar)
```

## License
This project is released under the [MIT license](https://en.wikipedia.org/wiki/MIT_License).
