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
    
    func testNestedStructs() {
        
        let json = JSON2(thing: ["a", "b", "c"], snufkin: Layer1(l1a: "hello", l1b: 123), moomin: Layer4(l4a: true, l4b : Layer3(l3a: nil, l3b : Layer2(l2a: 12.2, l2b : Layer1(l1a:nil, l1b:3)))))
        
        do {
            let encoded = try HTTPFormEncoder().encode(json)
            print("PRAMS: \(encoded)")
        }
        catch {
            print("ERROR: \(error)")
        }
    }
    
    func testnilNestedStructs() {
        
        let json = JSON2(thing: ["a", "b", "c"], snufkin: Layer1(l1a: nil, l1b: 123), moomin: Layer4(l4a: nil, l4b : Layer3(l3a: nil, l3b : Layer2(l2a: 12.2, l2b : Layer1(l1a:nil, l1b: 1)))))
        
        do {
            let encoded = try HTTPFormEncoder().encode(json)
            print("PRAMS: \(encoded)")
        }
        catch {
            print("ERROR: \(error)")
        }
        
    }
    


    func testArrayStructs() {
    
        let json = JSON3( stuff: [Layer1(l1a:"a", l1b:1), Layer1(l1a:"b", l1b:2), Layer1(l1a:"c", l1b:3)])
    
        do {
        let encoded = try HTTPFormEncoder().encode(json)
        print("PRAMS: \(encoded)")
        }
        catch {
        print("ERROR: \(error)")
        }
    }


func testArrays() {
    
    let json = JSON4( bleh: Nonsense(pup: [["a","b"],["c","d"]], birb: [[[1, 2], [3, 4]], [[5, 6], [7, 8]]] ))
    
    do {
        let encoded = try HTTPFormEncoder().encode(json)
        print("PRAMS: \(encoded)")
    }
    catch {
        print("ERROR: \(error)")
    }
}

func testSingelValueStructs() {
        
        //let svs = SingleValues(label: .abc1, more: [.efg, .efg, .abc1])
        let svs = SingleValues(label: .abc1, info: NestedSingleValues(name: .funk, food: .🎃), val: .egg)
        //let svs = SingleValues(info: NestedSingleValues(name: .funk))
        do {
            let encoded = try HTTPFormEncoder().encode(svs)
            print("PRAMS: \(encoded)")
        }
        catch {
          print("ERROR: \(error)")
        }
    }
}
