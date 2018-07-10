//
//  HTTPFormKeyedEncodingContainer.swift
//  HTTPFormEncoder
//
//  Created by Richard Stelling on 10/07/2018.
//  Copyright © 2018 Lionheart Applications Ltd. All rights reserved.
//

import Foundation

struct HTTPFormKeyedEncodingContainer<K : CodingKey> : KeyedEncodingContainerProtocol {
    
    typealias Key = K
    var codingPath: [CodingKey]
    let encoder: HTTPFormEncoder
    let containerName: String?
    
    internal init(referencing encoder: HTTPFormEncoder, codingPath: [CodingKey], name: String?) {
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
