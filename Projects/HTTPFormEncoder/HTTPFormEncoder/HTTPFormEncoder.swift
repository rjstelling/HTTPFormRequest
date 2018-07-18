//
//  HTTPFormEncoder.swift
//  HTTPFormEncoder
//
//  Created by Richard Stelling on 10/07/2018.
//  Copyright © 2018 Lionheart Applications Ltd. All rights reserved.
//

import Foundation

extension CodingUserInfoKey {
    internal static let ContainerName = CodingUserInfoKey(rawValue: "ContainerName.HTTPFormEncoder")!
}

public class HTTPFormEncoder: Encoder {
    
    public var codingPath: [CodingKey] = []
    
    public var userInfo: [CodingUserInfoKey : Any] = [:]
    
    // This is an arrya so it can hold multiple parama keyed with `name[]` etc
    internal var parameters: [(String, String)] = []
    
    //public init() {}
    
    public init(codingPath: [CodingKey] = []) {
        self.codingPath = codingPath
    }
    
    public func encode<T>(_ value: T) throws -> [(String, String)] where T : Encodable {
        
        try value.encode(to: self)
        
        return self.parameters
    }
    
    internal func box(_ value: Bool)   -> String { return "\(value ? "true" : "false")" }
    internal func box(_ value: Int)    -> String { return "\(value)" }
    internal func box(_ value: Int8)   -> String { return "\(value)" }
    internal func box(_ value: Int16)  -> String { return "\(value)" }
    internal func box(_ value: Int32)  -> String { return "\(value)" }
    internal func box(_ value: Int64)  -> String { return "\(value)" }
    internal func box(_ value: UInt)   -> String { return "\(value)" }
    internal func box(_ value: UInt8)  -> String { return "\(value)" }
    internal func box(_ value: UInt16) -> String { return "\(value)" }
    internal func box(_ value: UInt32) -> String { return "\(value)" }
    internal func box(_ value: UInt64) -> String { return "\(value)" }
    internal func box(_ value: Float) -> String { return "\(value)" }
    internal func box(_ value: Double) -> String { return "\(value)" }
    internal func box(_ value: String) -> String { return value }
    
    internal func box_<T: Encodable>(_ value: T) throws -> String /*where T : Encodable*/ {
        
        if T.self == Int.self {
            return self.box(value as! Int)
        }
        if T.self == Int64.self { //TODO: all other ints
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
    
    internal func box<T>(_ value: T, name: String) throws where T : Encodable {
        self.userInfo[.ContainerName] = name
        try value.encode(to: self)
    }
}

extension HTTPFormEncoder /* Encoder Overrides */ {
    
    public func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        
        var containerName: String? = self.codingPath.first?.stringValue
        
        if let name = containerName {
            containerName = self.codingPath[1...].reduce(name) { $0 + "[\($1.stringValue)]" }
        }
        
        let container = HTTPFormKeyedEncodingContainer<Key>(referencing: self, codingPath: self.codingPath, name: containerName)
        return KeyedEncodingContainer(container)
    }
    
    public func unkeyedContainer() -> UnkeyedEncodingContainer {
        
        let container = HTTPFormUnkeyedEncodingContainer(referencing: self, codingPath: self.codingPath, name: self.userInfo[.ContainerName] as! String)
        return container
    }
    
    public func singleValueContainer() -> SingleValueEncodingContainer {
        
        var containerName: String? = self.codingPath.first?.stringValue
        
        if let name = containerName {
            containerName = self.codingPath[1...].reduce(name) { $0 + "[\($1.stringValue)]" }
        }
        
        return HTTPFormSingleValueEncodingContainer(referencing: self, codingPath: self.codingPath, name: containerName ?? "UNSUPPORTED")
    }
    
    public func nestedContainer<NestedKey, Key>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> {
        fatalError("NOT IMP")
    }
    
    public func nestedUnkeyedContainer<Key>(forKey key: Key) -> UnkeyedEncodingContainer {
        fatalError("NOT IMP")
    }
}
