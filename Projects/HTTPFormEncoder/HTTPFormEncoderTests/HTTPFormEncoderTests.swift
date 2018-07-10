//
//  HTTPFormEncoderTests.swift
//  HTTPFormEncoderTests
//
//  Created by Richard Stelling on 10/07/2018.
//  Copyright © 2018 Lionheart Applications Ltd. All rights reserved.
//

import XCTest
@testable import HTTPFormEncoder

class HTTPFormEncoderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSimpleStructs() {
        
        let json = JSON(foo: "hello world", bar: "magic swift", moo: 123, moo8: 127, moo16: 789, moo32: 159, moo64: 753, loo: 2.0, boo: 3.14159262, baz0: false, baz1: true, zaz: nil, zaz1: nil, blup: ["a", "b", "c"], blop: Inner(foo: "hello", bar: 123), deep: Deep(scale: 3.0, planet: Inner(foo: "deep-inner", bar: 654)))
        
        do {
            let encoded = try HTTPFormEncoder().encode(json)
            print("PRAMS: \(encoded)")
        }
        catch {
            print("ERROR: \(error)")
        }
        
    }
    
}
