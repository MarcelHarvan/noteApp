//
//  NoteViewController+NavigationBar.swift
//  noteApp
//
//  Created by Marcel Harvan on 2018-10-28.
//  Copyright © 2018 Marcel Harvan. All rights reserved.
//

import UIKit

extension NoteViewController {
    
    func setupNavigationBarItems(){
        navigationController?.navigationBar.backgroundColor = .blue
        navigationController?.navigationBar.isTranslucent = false
        navigationItemTitle()
        rightBarButton()
    }
    
    private func navigationItemTitle(){
        navigationItem.title = "My Notes"
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
    
    @objc func addNewNote(){
        print("here")
    }
}
