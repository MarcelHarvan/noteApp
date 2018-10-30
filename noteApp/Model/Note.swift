//
//  Note.swift
//  noteApp
//
//  Created by Marcel Harvan on 2018-10-28.
//  Copyright © 2018 Marcel Harvan. All rights reserved.
//

import Foundation

struct Note {
    var _id: Int!
    var _note: String!
    
    static func parseNoteJSONData(data: Data) -> [Note] {
        var notes = [Note]()
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            if let listOfNotes = jsonResult as? [Dictionary<String, AnyObject>] {
                for note in listOfNotes {
                    var newNote = Note()
                    newNote._id = note["id"] as? Int
                    newNote._note = note["title"] as? String
//                    print(newNote._id, newNote._note)
                    notes.append(newNote)
                }
            }
        } catch let err {
            print(err)
        }
        
        return notes
    }
}
