import UIKit

struct JSON: Codable {
    let foo: String
    //let moo: Int
    //let loo: [String]
}

///-------------------------------------------------------------

struct FormKeyedEncodingContainer<K : CodingKey> : KeyedEncodingContainerProtocol {
    
    typealias Key = K
    var codingPath: [CodingKey]
    let encoder: FormEncoder
    
    fileprivate init(referencing encoder: FormEncoder, codingPath: [CodingKey]) {
        self.codingPath = codingPath
        self.encoder = encoder
    }
    
    mutating func encodeNil(forKey key: K) throws {
        throw NSError(domain: "FormEncoder", code: -99, userInfo: nil)
    }
    
    mutating func encode(_ value: Bool, forKey key: K) throws {
        throw NSError(domain: "FormEncoder", code: -99, userInfo: nil)
    }
    
    mutating func encode(_ value: String, forKey key: K) throws {
        self.encoder.parameters[key.stringValue] = encoder.box( value ) as String
    }
    
    mutating func encode(_ value: Double, forKey key: K) throws {
        throw NSError(domain: "FormEncoder", code: -99, userInfo: nil)
    }
    
    mutating func encode(_ value: Float, forKey key: K) throws {
        throw NSError(domain: "FormEncoder", code: -99, userInfo: nil)
    }
    
    mutating func encode(_ value: Int, forKey key: K) throws {
        throw NSError(domain: "FormEncoder", code: -99, userInfo: nil)
    }
    
    mutating func encode(_ value: Int8, forKey key: K) throws {
        throw NSError(domain: "FormEncoder", code: -99, userInfo: nil)
    }
    
    mutating func encode(_ value: Int16, forKey key: K) throws {
        throw NSError(domain: "FormEncoder", code: -99, userInfo: nil)
    }
    
    mutating func encode(_ value: Int32, forKey key: K) throws {
        throw NSError(domain: "FormEncoder", code: -99, userInfo: nil)
    }
    
    mutating func encode(_ value: Int64, forKey key: K) throws {
        throw NSError(domain: "FormEncoder", code: -99, userInfo: nil)
    }
    
    mutating func encode(_ value: UInt, forKey key: K) throws {
        throw NSError(domain: "FormEncoder", code: -99, userInfo: nil)
    }
    
    mutating func encode(_ value: UInt8, forKey key: K) throws {
        throw NSError(domain: "FormEncoder", code: -99, userInfo: nil)
    }
    
    mutating func encode(_ value: UInt16, forKey key: K) throws {
        throw NSError(domain: "FormEncoder", code: -99, userInfo: nil)
    }
    
    mutating func encode(_ value: UInt32, forKey key: K) throws {
        throw NSError(domain: "FormEncoder", code: -99, userInfo: nil)
    }
    
    mutating func encode(_ value: UInt64, forKey key: K) throws {
        throw NSError(domain: "FormEncoder", code: -99, userInfo: nil)
    }
    
    mutating func encode<T>(_ value: T, forKey key: K) throws where T : Encodable {
        throw NSError(domain: "FormEncoder", code: -99, userInfo: nil)
    }
    
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

class FormEncoder: Encoder {
    
    
    var codingPath: [CodingKey]
    
    var userInfo: [CodingUserInfoKey : Any] = [:]
    
    fileprivate var parameters: [String:String] = [:]
    
    fileprivate init(codingPath: [CodingKey] = []) {
        self.codingPath = codingPath
    }
    
    func encode<T : Encodable>(_ value: T) throws -> [String:String] {
        
        do {
            try value.encode(to: self)
        }
        catch {
            
        }
        
        return self.parameters
    }
    
//    func box_<T : Encodable>(_ value: T) throws -> NSObject? {
//
//
//
//    }
    
    fileprivate func box(_ value: Bool)   -> NSString { return NSString(string: "\(value ? "true" : "false")") }
    fileprivate func box(_ value: Int)    -> NSString { return NSString(string: "\(value)") }
    fileprivate func box(_ value: Int8)   -> NSString { return NSString(string: "\(value)") }
    fileprivate func box(_ value: Int16)  -> NSString { return NSString(string: "\(value)") }
    fileprivate func box(_ value: Int32)  -> NSString { return NSString(string: "\(value)") }
    fileprivate func box(_ value: Int64)  -> NSString { return NSString(string: "\(value)") }
    fileprivate func box(_ value: UInt)   -> NSString { return NSString(string: "\(value)") }
    fileprivate func box(_ value: UInt8)  -> NSString { return NSString(string: "\(value)") }
    fileprivate func box(_ value: UInt16) -> NSString { return NSString(string: "\(value)") }
    fileprivate func box(_ value: UInt32) -> NSString { return NSString(string: "\(value)") }
    fileprivate func box(_ value: UInt64) -> NSString { return NSString(string: "\(value)") }
    fileprivate func box(_ value: String) -> NSString { return NSString(string: value) }
}

extension SingleValueEncodingContainer {
    
    public func encode(_ value: String) throws {
        //self.storage.push(container: self.box(value))
    }
    
}

extension FormEncoder {
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        
        let container = FormKeyedEncodingContainer<Key>(referencing: self, codingPath: self.codingPath)
        return KeyedEncodingContainer(container)
    }
    
    func unkeyedContainer() -> UnkeyedEncodingContainer {
        fatalError("NOT IMP")
    }
    
    func singleValueContainer() -> SingleValueEncodingContainer {
        fatalError("NOT IMP")
    }
}
