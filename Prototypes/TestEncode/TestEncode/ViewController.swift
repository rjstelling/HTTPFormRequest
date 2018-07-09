//
//  ViewController.swift
//  TestEncode
//
//  Created by Richard Stelling on 09/07/2018.
//  Copyright © 2018 Lionheart Applications Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let json = JSON(foo: "hello world", bar: "magic swift", moo: 123, moo8: 127, moo16: 789, moo32: 159, moo64: 753, loo: 2.0, boo: 3.14159262, baz0: false, baz1: true, zaz: nil, zaz1: nil, blup: ["a", "b", "c"], blop: Inner(foo: "hello", bar: 123), deep: Deep(scale: 3.0, planet: Inner(foo: "deep-inner", bar: 654)))
        
        do {
            let encoded = try FormEncoder().encode(json)
            print("PRAMS: \(encoded)")
        }
        catch {
            print("ERROR: \(error)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

struct Inner: Codable {
    let foo: String
    let bar: Int
}

struct Deep: Codable {
    let scale: Double
    let planet: Inner
}

struct JSON: Codable {
    let foo: String
    let bar: String
    let moo: Int
    let moo8: Int8
    let moo16: Int16
    let moo32: Int32
    let moo64: Int64
    
    let loo: Float
    let boo: Double
    
    let baz0: Bool
    let baz1: Bool
    
    let zaz: String?
    let zaz1: Int?
    
    let blup: [String]
    
    let blop: Inner
    
    let deep: Deep
    
    //let loo: [String]
}

///-------------------------------------------------------------

struct FormKeyedEncodingContainer<K : CodingKey> : KeyedEncodingContainerProtocol {
    
    typealias Key = K
    var codingPath: [CodingKey]
    let encoder: FormEncoder
    let containerName: String?
    
    fileprivate init(referencing encoder: FormEncoder, codingPath: [CodingKey], name: String?) {
        self.codingPath = codingPath
        self.encoder = encoder
        self.containerName = name
    }
    
    private func paramName(forKey key: K) -> String {
        if let containerName = self.containerName {
            return "\(containerName)[\(key.stringValue)]"
        }
        else {
            return key.stringValue
        }
    }
    
    mutating func encodeNil(forKey key: K) throws {
        print("\(key.stringValue) is nil… skipping!)") //???: never called
    }
    
    mutating func encode(_ value: Bool, forKey key: K) throws {
        self.encoder.codingPath.append(key)
        defer { self.encoder.codingPath.removeLast() }
        self.encoder.parameters.append( ( paramName(forKey: key), encoder.box(value) ) )
    }
    
    mutating func encode(_ value: String, forKey key: K) throws {
        self.encoder.codingPath.append(key)
        defer { self.encoder.codingPath.removeLast() }
        self.encoder.parameters.append( ( paramName(forKey: key), encoder.box(value) ) )
    }
    
    mutating func encode(_ value: Double, forKey key: K) throws {
        self.encoder.codingPath.append(key)
        defer { self.encoder.codingPath.removeLast() }
        self.encoder.parameters.append( ( paramName(forKey: key), encoder.box(value) ) )
    }
    
    mutating func encode(_ value: Float, forKey key: K) throws {
        self.encoder.codingPath.append(key)
        defer { self.encoder.codingPath.removeLast() }
        self.encoder.parameters.append( ( paramName(forKey: key), encoder.box(value) ) )
    }
    
    mutating func encode(_ value: Int, forKey key: K) throws {
        self.encoder.codingPath.append(key)
        defer { self.encoder.codingPath.removeLast() }
        self.encoder.parameters.append( ( paramName(forKey: key), encoder.box(value) ) )
    }
    
    mutating func encode(_ value: Int8, forKey key: K) throws {
        self.encoder.codingPath.append(key)
        defer { self.encoder.codingPath.removeLast() }
        self.encoder.parameters.append( ( paramName(forKey: key), encoder.box(value) ) )
    }
    
    mutating func encode(_ value: Int16, forKey key: K) throws {
        self.encoder.codingPath.append(key)
        defer { self.encoder.codingPath.removeLast() }
        self.encoder.parameters.append( ( paramName(forKey: key), encoder.box(value) ) )
    }
    
    mutating func encode(_ value: Int32, forKey key: K) throws {
        self.encoder.codingPath.append(key)
        defer { self.encoder.codingPath.removeLast() }
        self.encoder.parameters.append( ( paramName(forKey: key), encoder.box(value) ) )
    }
    
    mutating func encode(_ value: Int64, forKey key: K) throws {
        self.encoder.codingPath.append(key)
        defer { self.encoder.codingPath.removeLast() }
        self.encoder.parameters.append( ( paramName(forKey: key), encoder.box(value) ) )
    }
    
    mutating func encode(_ value: UInt, forKey key: K) throws {
        self.encoder.codingPath.append(key)
        defer { self.encoder.codingPath.removeLast() }
        self.encoder.parameters.append( ( paramName(forKey: key), encoder.box(value) ) )
    }
    
    mutating func encode(_ value: UInt8, forKey key: K) throws {
        self.encoder.codingPath.append(key)
        defer { self.encoder.codingPath.removeLast() }
        self.encoder.parameters.append( ( paramName(forKey: key), encoder.box(value) ) )
    }
    
    mutating func encode(_ value: UInt16, forKey key: K) throws {
        self.encoder.codingPath.append(key)
        defer { self.encoder.codingPath.removeLast() }
        self.encoder.parameters.append( ( paramName(forKey: key), encoder.box(value) ) )
    }
    
    mutating func encode(_ value: UInt32, forKey key: K) throws {
        self.encoder.codingPath.append(key)
        defer { self.encoder.codingPath.removeLast() }
        self.encoder.parameters.append( ( paramName(forKey: key), encoder.box(value) ) )
    }
    
    mutating func encode(_ value: UInt64, forKey key: K) throws {
        self.encoder.codingPath.append(key)
        defer { self.encoder.codingPath.removeLast() }
        self.encoder.parameters.append( ( paramName(forKey: key), encoder.box(value) ) )
    }
    
   mutating func encode<T>(_ value: T, forKey key: K) throws where T : Encodable {
    
        self.encoder.codingPath.append(key)
        defer { self.encoder.codingPath.removeLast() }
    
        // We have found an array, dictionary or other Encodable object
        try encoder.box( value, name: key.stringValue )
    }
        
    
//    mutating func encode<T>(_ value: T, forKey key: K) throws where T : Encodable {
//
//        if T.self == Array<Any>.self || T.self == NSArray.self {
//            throw NSError(domain: "FormEncoder - encode ARRAY", code: -99, userInfo: nil)
//        }
//        else if T.self == Dictionary<String, Any>.self || T.self == NSDictionary.self {
//            throw NSError(domain: "FormEncoder - encode DICTIONAT", code: -99, userInfo: nil)
//        }
//
//        throw NSError(domain: "FormEncoder - encode T", code: -99, userInfo: nil)
//    }
    
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: K) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        fatalError("NOT IMP")
    }
    
    mutating func nestedUnkeyedContainer(forKey key: K) -> UnkeyedEncodingContainer {
        fatalError("NOT IMP")
    }
    
    mutating func superEncoder() -> Encoder {
        fatalError("NOT IMP")
    }
    
    mutating func superEncoder(forKey key: K) -> Encoder {
        fatalError("NOT IMP")
    }
    
    
    
    
}

// Arrays in Forms have the following syntax:
//    name[] = value
struct FormUnkeyedEncodingContainer: UnkeyedEncodingContainer {
    
    let encoder: FormEncoder
    
    var codingPath: [CodingKey]
    
    var count: Int = 0
    
    let containerName: String
    
    var storage: [String] = []
    
    /// Initializes `self` with the given references.
    fileprivate init(referencing encoder: FormEncoder, codingPath: [CodingKey], name: String) {
        self.encoder = encoder
        self.codingPath = codingPath
        self.containerName = name + "[]"
    }
    
    mutating func encodeNil() throws {
        print("nil… skipping!)")
    }
    
    mutating func encode(_ value: Bool) throws {
        defer { self.count += 1 }
        self.storage.append( encoder.box( value ) )
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: String) throws {
        defer { self.count += 1 }
        self.storage.append( encoder.box( value ) )
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: Double) throws {
        defer { self.count += 1 }
        self.storage.append( encoder.box( value ) )
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: Float) throws {
        defer { self.count += 1 }
        self.storage.append( encoder.box( value ) )
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: Int) throws {
        defer { self.count += 1 }
        self.storage.append( encoder.box( value ) )
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: Int8) throws {
        defer { self.count += 1 }
        self.storage.append( encoder.box( value ) )
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: Int16) throws {
        defer { self.count += 1 }
        self.storage.append( encoder.box( value ) )
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: Int32) throws {
        defer { self.count += 1 }
        self.storage.append( encoder.box( value ) )
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: Int64) throws {
        defer { self.count += 1 }
        self.storage.append( encoder.box( value ) )
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: UInt) throws {
        defer { self.count += 1 }
        self.storage.append( encoder.box( value ) )
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: UInt8) throws {
        defer { self.count += 1 }
        self.storage.append( encoder.box( value ) )
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: UInt16) throws {
        defer { self.count += 1 }
        self.storage.append( encoder.box( value ) )
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: UInt32) throws {
        defer { self.count += 1 }
        self.storage.append( encoder.box( value ) )
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: UInt64) throws {
        defer { self.count += 1 }
        self.storage.append( encoder.box( value ) )
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode<T>(_ value: T) throws where T : Encodable {
        defer { self.count += 1 }
        //self.encoder.parameters[self.containerName] = try encoder.box( value )
        //print("VLAUE: \(value)")
        //fatalError("NOT IMP")

        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
        
       //self.encoder.parameters[self.containerName] = try encoder.box_( value )
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        fatalError("NOT IMP")
    }
    
    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        fatalError("NOT IMP")
    }
    
    mutating func superEncoder() -> Encoder {
        fatalError("NOT IMP")
    }
    

}

extension CodingUserInfoKey {
    fileprivate static let ContainerName = CodingUserInfoKey(rawValue: "ARRAY-NAME")!
}

class FormEncoder: Encoder {
    
    
    var codingPath: [CodingKey]
    
    var userInfo: [CodingUserInfoKey : Any] = [:]
    
    // This is an arrya so it can hold multiple parama keyed with `name[]` etc
    fileprivate var parameters: [(String, String)] = []
    
    fileprivate init(codingPath: [CodingKey] = []) {
        self.codingPath = codingPath
    }
    
    func encode<T : Encodable>(_ value: T) throws -> [(String, String)] {

        try value.encode(to: self)

        return self.parameters
    }
    
    fileprivate func box(_ value: Bool)   -> String { return "\(value ? "true" : "false")" }
    fileprivate func box(_ value: Int)    -> String { return "\(value)" }
    fileprivate func box(_ value: Int8)   -> String { return "\(value)" }
    fileprivate func box(_ value: Int16)  -> String { return "\(value)" }
    fileprivate func box(_ value: Int32)  -> String { return "\(value)" }
    fileprivate func box(_ value: Int64)  -> String { return "\(value)" }
    fileprivate func box(_ value: UInt)   -> String { return "\(value)" }
    fileprivate func box(_ value: UInt8)  -> String { return "\(value)" }
    fileprivate func box(_ value: UInt16) -> String { return "\(value)" }
    fileprivate func box(_ value: UInt32) -> String { return "\(value)" }
    fileprivate func box(_ value: UInt64) -> String { return "\(value)" }
    fileprivate func box(_ value: Float) -> String { return "\(value)" }
    fileprivate func box(_ value: Double) -> String { return "\(value)" }
    fileprivate func box(_ value: String) -> String { return value }
    
    fileprivate func box_<T: Encodable>(_ value: T) throws -> String /*where T : Encodable*/ {
        
        if T.self == Int.self {
             return self.box(value as! Int64)
        }
        else if T.self == Double.self {
            return self.box(value as! Double)
        }
        else if T.self == Float.self {
            return self.box(value as! Float)
        }
        else if T.self == Bool.self {
            return self.box(value as! Bool)
        }
        else if T.self == String.self {
            return self.box(value as! String)
        }
        else {
            fatalError()
        }
    }
    
    fileprivate func box<T>(_ value: T, name: String) throws where T : Encodable {
        self.userInfo[.ContainerName] = name
        try value.encode(to: self)
    }
}

extension SingleValueEncodingContainer {
    
    public func encode(_ value: String) throws {
        //self.storage.push(container: self.box(value))
    }
    
}

extension FormEncoder {
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        
        var containerName: String? = self.codingPath.first?.stringValue
        
        if let name = containerName {
            containerName = self.codingPath[1...].reduce(name) { $0 + "[\($1.stringValue)]" }
        }
        
        let container = FormKeyedEncodingContainer<Key>(referencing: self, codingPath: self.codingPath, name: containerName)
        return KeyedEncodingContainer(container)
    }
    
    func unkeyedContainer() -> UnkeyedEncodingContainer {
        
        let container = FormUnkeyedEncodingContainer(referencing: self, codingPath: self.codingPath, name: self.userInfo[.ContainerName] as! String)
        return container
    }
    
    func singleValueContainer() -> SingleValueEncodingContainer {
        fatalError("NOT IMP")
    }
    
    public func nestedContainer<NestedKey, Key>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> {
        fatalError("NOT IMP")
    }
    
    public func nestedUnkeyedContainer<Key>(forKey key: Key) -> UnkeyedEncodingContainer {
         fatalError("NOT IMP")
    }
}
