//
//  Add_UpdateNoteVC.swift
//  noteApp
//
//  Created by Marcel Harvan on 2018-10-28.
//  Copyright © 2018 Marcel Harvan. All rights reserved.
//

import UIKit

class Add_UpdateNoteVC: UIViewController {
    
    var selectedNote: Note?
    var inUpdateMode = false
    
    private let noteTextView: UITextView = {
       let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textColor = .grayText
        textView.text = ""
        textView.backgroundColor = .yellowBody
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellowBody
        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if inUpdateMode {
            noteTextView.text = selectedNote?._note
        } else {
            noteTextView.text = ""
        }
    }
    
    private func rightBarButton(){
        let addNoteButton = UIButton(type: .system)
        addNoteButton.setTitle(NSLocalizedString("DONE", comment: ""), for: .normal)
        addNoteButton.addTarget(self, action: #selector(addUpdateNote), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addNoteButton)
    }
    
    @objc func addUpdateNote(){
        if inUpdateMode {
            guard let noteId = selectedNote?._id else {return}
            DataService.instance.updateNote(note: noteTextView.text, id: noteId, completion: {Success in
                if Success {
                    print("Successfully updated note")
                } else {
                    print("Could not update note")
                }
            })
            inUpdateMode = false
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            DataService.instance.addNewNote(note: noteTextView.text, completion: {Success in
                if Success {
                    print("Successfully saved note")

                } else {
                    print("Could not save note")
                }
            })
              self.navigationController?.popToRootViewController(animated: true)
        }
    }

   private func setupLayout(){
        rightBarButton()
        view.addSubview(noteTextView)
        noteTextView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
    }
}

