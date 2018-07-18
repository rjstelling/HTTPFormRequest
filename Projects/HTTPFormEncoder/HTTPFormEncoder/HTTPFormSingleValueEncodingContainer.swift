//
//  HTTPFormSingleValueEncodingContainer.swift
//  HTTPFormEncoder
//
//  Created by Richard Stelling on 18/07/2018.
//  Copyright © 2018 Lionheart Applications Ltd. All rights reserved.
//

import Foundation

struct HTTPFormSingleValueEncodingContainer: SingleValueEncodingContainer {
    
    var codingPath: [CodingKey]
    let encoder: HTTPFormEncoder
    let containerName: String
    
    internal init(referencing encoder: HTTPFormEncoder, codingPath: [CodingKey], name: String) {
        self.encoder = encoder
        self.codingPath = codingPath
        self.containerName = name
    }
    
    mutating func encodeNil() throws {
        print("nil… skipping!)")
    }
    
    mutating func encode(_ value: Bool) throws {

        
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: String) throws {

        
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: Double) throws {

        
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: Float) throws {

        
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: Int) throws {

        
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: Int8) throws {

        
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: Int16) throws {

        
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: Int32) throws {

        
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: Int64) throws {

        
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: UInt) throws {

        
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: UInt8) throws {

        
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: UInt16) throws {

        
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: UInt32) throws {

        
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode(_ value: UInt64) throws {

        
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
    }
    
    mutating func encode<T>(_ value: T) throws where T : Encodable {

        //self.encoder.parameters[self.containerName] = try encoder.box( value )
        //print("VLAUE: \(value)")
        //fatalError("NOT IMP")
        
        self.encoder.parameters.append( ( self.containerName, try encoder.box_(value) ) )
        
        //self.encoder.parameters[self.containerName] = try encoder.box_( value )
    }
}
