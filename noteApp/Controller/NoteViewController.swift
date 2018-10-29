//
//  ViewController.swift
//  noteApp
//
//  Created by Marcel Harvan on 2018-10-28.
//  Copyright © 2018 Marcel Harvan. All rights reserved.
//

import UIKit

class NoteViewController: UITableViewController {
    
    var dataService = DataService.instance
    
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        dataService.delegate = self 
        
        DataService.instance.getAllNotes()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        setupNavigationBarItems()
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.notes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = dataService.notes[indexPath.row]._note
        
        
        return cell
    }


}

extension NoteViewController: DataServiceDelegate {
    func notesLoaded() {
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
}

