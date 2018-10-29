//
//  DataService.swift
//  noteApp
//
//  Created by Marcel Harvan on 2018-10-28.
//  Copyright © 2018 Marcel Harvan. All rights reserved.
//

import Foundation

protocol DataServiceDelegate: class {
    func notesLoaded()
}

class DataService {
    static let instance = DataService()
    
    weak var delegate: DataServiceDelegate?
    var notes = [Note]()
    
    func getAllNotes() {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = URL(string: BASE_API_URL) else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if error == nil {
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                if let data = data {
                    self.notes = Note.parseNoteJSONData(data: data)
                    self.delegate?.notesLoaded()
                }
            } else {
                print("URL Session Task Failed: \(error!.localizedDescription)")
            }
            
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    func addNewNote(note: String, completion: @escaping callback) {
        let json: [String: Any] = [
            "title": note
        ]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            guard let URL = URL(string: BASE_API_URL) else {return}
            var request = URLRequest(url: URL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if error == nil {
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("URL Session Task Succeeded: HTTP \(statusCode)")
                    if statusCode != 201 {
                        completion(false)
                        return
                    } else {
                        self.getAllNotes()
                        completion(true)
                    }
                } else {
                    print("URL Session Task Failed: \(String(describing: error?.localizedDescription))")
                    completion(false)
                }
                
            })
            task.resume()
            session.finishTasksAndInvalidate()
        } catch let err {
            completion(false)
            print(err)
        }
    }
}
