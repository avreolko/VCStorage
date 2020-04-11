# VCDefaultsStorage
User defaults storage with Codable support

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
