//
//  NoteViewController+NavigationBar.swift
//  noteApp
//
//  Created by Marcel Harvan on 2018-10-28.
//  Copyright © 2018 Marcel Harvan. All rights reserved.
//

import UIKit

extension MineVC {
    // NavBar setup
    func setupNavigationBarItems(){
        navigationController?.navigationBar.isTranslucent = false
        navigationItemTitle()
        rightBarButton()
    }
    
    private func navigationItemTitle(){
        navigationItem.title = NSLocalizedString("My Notes", comment: "")
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func rightBarButton(){
        let addNoteButton = UIButton(type: .system)
        let addImage = UIImage(named: "add_button")
        addNoteButton.setImage(addImage, for: .normal)
        addNoteButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        addNoteButton.addTarget(self, action: #selector(addNewNote), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addNoteButton)
    }
    
    // add new note functiopn pushes into Add_UpdateNoteVC
    @objc func addNewNote(){
        noteAddController.selectedNote = nil
        navigationController?.pushViewController(noteAddController, animated: true)
    }
}
