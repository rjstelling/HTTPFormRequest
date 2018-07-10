//
//  HTTPFormRequest.swift
//  HTTPFormRequest
//
//  Created by Richard Stelling on 17/11/2016.
//  Copyright © 2017 Richard Stelling. All rights reserved.
//

import Foundation
import HTTPFormEncoder

#if canImport(MobileCoreServices)
import MobileCoreServices
#elseif canImport(CoreServices)
import CoreServices
#endif

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
    
    public enum ContentType: String {
        
        case octetStream = "application/octet-stream"
        
        // Images
        case png = "image/png"
        case jpg = "image/jpg"
        
        // Documents
        case excel = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    }
    
    fileprivate var urlRequest: URLRequest
    fileprivate let boundary: String
    fileprivate let data: NSMutableData = NSMutableData()

    /// Specifies the limit on the idle interval allotted to a request in the process of loading.
    public var timeoutInterval: TimeInterval {
        set { self.urlRequest.timeoutInterval = newValue }
        get { return self.urlRequest.timeoutInterval }
    }
    
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
    
    /// Add a key-valuse pair to the post request
    ///
    /// - Parameters:
    ///   - field: name of the field
    ///   - value: the integer value for the field
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
    private func add(file data: Data, filename: String, contentType: String, name: String = "file") {
        
        let fileField = "\r\n--\(self.boundary)\r\n" +
            "Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\n" +
        "Content-Type: \(contentType)\r\n\r\n"
        
        self.data.append(fileField.data(using: String.Encoding.utf8)!)
        self.data.append(data)
    }

    public func add(file data: Data, filename: String, contentType: ContentType = .octetStream, name: String = "file") {
        self.add(file: data, filename: filename, contentType: contentType.rawValue, name: name)
    }
    
    /// Add a local file (at `url`) to the request. Passing a URL that is not a local file
    /// i.e. `url.isFileURL == true` will cause a fatal error.
    ///
    /// - Parameters:
    ///   - url: URL to a loca file with read permissions
    ///   - filename: The name of the file, if nil the file name from `url` will be used
    ///   - contentType: The UTI of the data, passing nil will cause the system to determine the UTI and convert to a mime type
    public func add(file url: URL, filename: String? = nil, contentType: ContentType? = nil, name: String = "file") {
        
        guard url.isFileURL else {
            fatalError("URL must be local!")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        
        // Get name for file
        let fName = filename ?? url.lastPathComponent
        let extention = (url.path as NSString).pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, extention as CFString, nil)?.takeRetainedValue(),
            let mimeType = (UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() as String?) {
            self.add(file: data, filename: fName, contentType: mimeType, name: name)
        }
        else {
            self.add(file: data, filename: fName, name: name)
        }
    }
    
    public func add<T>(parameters params: T) throws where T: Encodable {
        
        let encoder = HTTPFormEncoder()
        let encodedParams = try encoder.encode(params)
        
        encodedParams.forEach {
            self.add(formField: $0.0, value: $0.1)
        }
    }
}

