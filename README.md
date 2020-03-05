# VCDefaultsStorage
User defaults storage with Codable support.

## How to get started
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

## Installation
For now VCDefaultsStorage supports installation through SPM 📦
