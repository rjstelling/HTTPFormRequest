//
//  HTTPFormUnkeyedEncodingContainer.swift
//  HTTPFormEncoder
//
//  Created by Richard Stelling on 10/07/2018.
//  Copyright © 2018 Lionheart Applications Ltd. All rights reserved.
//

import Foundation

// Arrays in Forms have the following syntax:
//    name[] = value
struct HTTPFormUnkeyedEncodingContainer: UnkeyedEncodingContainer {
    
    let encoder: HTTPFormEncoder
    
    var codingPath: [CodingKey]
    
    var count: Int = 0
    
    let containerName: String
    
    var storage: [String] = []
    
    /// Initializes `self` with the given references.
    internal init(referencing encoder: HTTPFormEncoder, codingPath: [CodingKey], name: String) {
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
