//
//  HTTPFormRequest.swift
//  HTTPFormRequest
//
//  Created by Richard Stelling on 17/11/2016.
//  Copyright © 2017 Richard Stelling. All rights reserved.
//

import Foundation

public extension URLSession {
    
    public func dataTaskWithHTTPFormRequest(_ request: HTTPFormRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        //First boundry
        let lastBoundry = "\r\n--\(request.boundary)--\r\n"
        request.data.append(lastBoundry.data(using: String.Encoding.utf8)!)
        
        let length = request.data.length
        request.urlRequest.setValue("\(length)", forHTTPHeaderField: "Content-Length")
        
        request.urlRequest.httpBody = request.data as Data
        
        return self.dataTask(with: request.urlRequest, completionHandler: completionHandler)
    }
}

public class HTTPFormRequest {
    
    fileprivate var urlRequest: URLRequest
    fileprivate let boundary: String
    fileprivate let data: NSMutableData = NSMutableData()
    
    public init(withURL url: URL) {
        
        self.boundary = UUID().uuidString
        self.urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 5.0)
        self.urlRequest.httpMethod = "POST"
        self.urlRequest.setValue("multipart/form-data; boundary=\(self.boundary)", forHTTPHeaderField: "Content-Type")
    }
}

extension HTTPFormRequest {
    
    /// Add a key-valuse pair to the post request
    ///
    /// - Parameters:
    ///   - field: name of the field
    ///   - value: the string value for the field
    public func add(formField field: String, value: String) {
        
        self.data.append(self.data(withField: field, value: value))
    }
    
    public func add(formField field: String, value: Int) {
        
        self.data.append(self.data(withField: field, value: "\(value)"))
    }
    
    fileprivate func data(withField field: String, value: String) -> Data {
        
        let formField = "\r\n--\(self.boundary)\r\nContent-Disposition: form-data; name=\"\(field)\"\r\n\r\n\(value)"
        return formField.data(using: String.Encoding.utf8)! //TODO: throw
    }
    
    /// Add a file to the post request
    ///
    /// - Parameters:
    ///   - data: The file data
    ///   - filename: the file name of the file
    func add(file data: Data, filename: String) {
        
        let fileField = "\r\n--\(self.boundary)\r\n" +
                        "Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n" +
                        "Content-Type: application/octet-stream\r\n\r\n"
        
        self.data.append(fileField.data(using: String.Encoding.utf8)!)
        self.data.append(data)
    }
}

