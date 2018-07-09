//
//  ViewController.swift
//  Example iOS
//
//  Created by Richard James Stelling on 09/01/2017.
//  Copyright © 2017 Richard Stelling. All rights reserved.
//

import UIKit
import HTTPFormRequest

class ViewController: UIViewController {

    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Actions
    
    @IBAction func onSend1Param(_ sender: UIButton) {
        
//        guard let url = URL(string: "http://requestb.in/1aycjwo1") else {
//            return
//        }
        
        guard let url = URL(string: "http://localhost:1973/httpformrequest-test-000") else {
            return
        }
        
        let request = HTTPFormRequest(withURL: url)
        request.add(formField: "TEST", value: "1, 2, 3, 4... 5!")
        
        let task = self.session.dataTaskWithHTTPFormRequest(request) {_,_,_ in
        
            
        }
        
        task.resume()
    }

    struct JSON: Codable {
        let foo: String
        let moo: Int
        let loo: [String]
    }
    
    @IBAction func onUploadJSON(_ sender: UIButton) {
        
        let json = JSON(foo: "bar", moo: 123, loo: ["a", "b", "c"])

        guard let url = URL(string: "http://localhost:1973/httpformrequest-test-000") else {
            return
        }
        
        let request = HTTPFormRequest(withURL: url)
        request.add(parameters: json)
        
        let task = self.session.dataTaskWithHTTPFormRequest(request) {_,_,_ in
            
            
        }
        
        task.resume()
        
    }
    
}

