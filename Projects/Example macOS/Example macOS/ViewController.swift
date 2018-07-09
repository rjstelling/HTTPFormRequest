//
//  ViewController.swift
//  Example macOS
//
//  Created by Richard Stelling on 19/04/2018.
//  Copyright © 2018 Lionheart Applications Ltd. All rights reserved.
//

import Cocoa
import HTTPFormRequest

class ViewController: NSViewController {

    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    @IBOutlet weak var filePathLabel: NSTextField!
    @IBOutlet weak var uploadURLTextField: NSTextField!
    
    private var fileUrl: URL? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func onSelectFile(_ sender: NSButton) {
        
        NSLog("Select file...")
        
        let open = NSOpenPanel(contentRect: NSRect(x: 0, y: 0, width: 200, height: 300), styleMask: .docModalWindow, backing: .buffered, defer: false)
        open.canChooseDirectories = false
        open.canChooseFiles = true
        open.resolvesAliases = true
        open.allowsMultipleSelection = false
        open.message = "Select a file to upload…"
        open.prompt = "Add"
        
        if let win = NSApplication.shared.mainWindow {
            open.beginSheetModal(for: win) {
              
                
                //NSFileHandlingPanelOKButton if the user chose the OK button or NSFileHandlingPanelCancelButton
                
                print("\($0)")
                
                switch $0 {

                case .OK:
                    print("\(open.url?.path ?? "ERROR")")
                    self.filePathLabel.stringValue = open.url?.path ?? "ERROR"
                    self.fileUrl = open.url
                    break
                    
                case .cancel:
                    print("CANCEL")
                    break
                    
                default:
                    break
                }
            }
        }
    }
    
    @IBAction func onTest(_ sender: NSButton) {


        guard let url = URL(string: self.uploadURLTextField.stringValue) else {
            return
        }
        
        NSLog("URL -> \(self.uploadURLTextField.stringValue)")
        NSLog("URL -> \(url.absoluteString)")
        
        let request = HTTPFormRequest(withURL: url)
        request.add(formField: "TEST", value: "1, 2, 3, 4... 5!")
        
        if let dataURL = self.fileUrl {
            request.add(file: dataURL, name: "files_package")
        }
        
        let task = self.session.dataTaskWithHTTPFormRequest(request) {_,_,_ in
            NSLog("Done!!!!")
        }
        
        task.resume()
        
    }
    
//    @IBAction func onSendJSONObj(_ sender: UIButton) {
//        
//        
//        
//    }
    
    
}

