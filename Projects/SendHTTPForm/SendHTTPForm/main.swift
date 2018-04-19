//
//  main.swift
//  SendHTTPForm
//
//  Created by Richard Stelling on 18/04/2018.
//  Copyright © 2018 Lionheart Applications Ltd. All rights reserved.
//

import Foundation
import Cocoa

print("SendHTTPForm… initilizing")

let args = ProcessInfo.processInfo.arguments

guard let url = URL(string: args[1]) else {
    exit(1)
}

let paramName = args[2]
let paramData = args[3]

print("Connecting to: \(url.absoluteString)")
print("Sending: \(paramName) = \(paramData)")

let session = URLSession(configuration: URLSessionConfiguration.default)
let request = HTTPFormRequest(withURL: url)
request.add(formField: "TEST", value: "1, 2, 3, 4... 5!")

let task = session.dataTaskWithHTTPFormRequest(request) {_,_,_ in
    
    
}

task.resume()

exit(0)
