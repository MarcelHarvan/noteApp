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
        view.reloadInputViews()
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

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?,
                left: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                right: NSLayoutXAxisAnchor?,
                paddingTop: CGFloat,
                paddingLeft: CGFloat,
                paddingBottom: CGFloat,
                paddingRight: CGFloat,
                width: CGFloat,
                height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

extension UIColor {
    static var yellowNavBar = UIColor(red: 255/255, green: 255/255, blue: 153/255, alpha: 1)
    static var grayText = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
    static var yellowBody = UIColor(red: 255/255, green: 255/255, blue: 204/255, alpha: 1)
}
