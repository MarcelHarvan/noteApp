//
//  ViewController.swift
//  noteApp
//
//  Created by Marcel Harvan on 2018-10-28.
//  Copyright © 2018 Marcel Harvan. All rights reserved.
//

import UIKit

class MineVC: UITableViewController {
    
    var dataService = DataService.instance
    let noteAddController = Add_UpdateNoteVC()
    let cellId = "cellId"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        dataService.delegate = self 
        
        DataService.instance.getAllNotes()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = .yellowBody

        setupNavigationBarItems()
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.notes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = dataService.notes[indexPath.row]._note
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
        cell.textLabel?.textColor = .grayText
        cell.backgroundColor = .yellowBody
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            noteAddController.selectedNote = dataService.notes[indexPath.row]
            noteAddController.inUpdateMode = true
            navigationController?.pushViewController(noteAddController, animated: true)
 
    }
    
    func showNote(note: Note) {
        let noteAddController = Add_UpdateNoteVC()
        navigationController?.pushViewController(noteAddController, animated: true)

    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let id = dataService.notes[indexPath.row]._id else {return}
            DataService.instance.deleteNote(id: id)
            tableView.reloadData()
        }
    }
}

extension MineVC: DataServiceDelegate {
    func notesLoaded() {
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
}

