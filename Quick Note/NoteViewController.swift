//
//  NoteViewController.swift
//  Quick Note
//
//  Created by Neel B Gandhi on 11/26/20.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet weak var detailTitle: UITextField!
    @IBOutlet weak var detailBody: UITextView!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var note:Note?
    var notesModel:NotesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Modify the appearance of fields and buttons
        detailTitle.layer.sublayerTransform = CATransform3DMakeTranslation(12.5, 0, 0)
        detailTitle.layer.borderWidth = 2
        detailTitle.layer.borderColor = UIColor.lightGray.cgColor
        detailTitle.layer.cornerRadius = 5
        
        detailBody.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        detailBody.layer.borderColor = UIColor.lightGray.cgColor
        detailBody.layer.borderWidth = 2
        detailBody.layer.cornerRadius = 5
        
        saveButton.layer.borderColor = UIColor.blue.cgColor
        saveButton.layer.borderWidth = 2
        saveButton.layer.cornerRadius = 5
        
        deleteButton.layer.borderColor = UIColor.red.cgColor
        deleteButton.layer.borderWidth = 2
        deleteButton.layer.cornerRadius = 5
        
        starButton.layer.borderColor = UIColor.blue.cgColor
        starButton.layer.borderWidth = 2
        starButton.layer.cornerRadius = 5
        
        if note != nil {
            // Set the title and body text of detail view for an existing note.
            detailTitle.text = note?.title
            detailBody.text = note?.body
            
            // Set the star button image based on current status of the note.
            setStarButtonImage()
        }
        else {
            // This is a brand new note getting created, create a new note object with base values.
            let n = Note(noteId: UUID().uuidString, title: detailTitle.text ?? "Untitled", body: detailBody.text ?? "", isStarred: false, createdAt: Date(), updatedAt: Date())
            
            self.note = n
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Make sure the focus automatically goes to titleField when the note detail is loaded.
        detailTitle.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        note = nil
        detailTitle.text = ""
        detailBody.text = ""
    }
    
    func setStarButtonImage() {
        // Check if the note is starred or not. If it is, change the look and fill of star button.
        let starImageName = note!.isStarred ? "star.fill" : "star"
        starButton.setImage(UIImage(systemName: starImageName), for: .normal)
    }

    @IBAction func deleteTapped(_ sender: Any) {
        if self.note != nil {
            // Call methods in Notes model to delete
            notesModel?.deleteNote(self.note!)
        }
        
        // Dismiss the popup detailed view
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveTapped(_ sender: Any) {
        // Update the properties of the note after user tapped save from detailed view.
        if detailTitle.text == "" || detailTitle.text == nil {
            detailTitle.text = "Untitled"
        }
        
        self.note?.title = detailTitle.text!
        self.note?.body = detailBody.text ?? ""
        self.note?.updatedAt = Date()
        
        // Send the updated note to the NotesModel
        self.notesModel?.saveNote(self.note!)
        
        // Dismiss the popup detailed view
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func starTapped(_ sender: Any) {
        
        // Change the isStarred property in the note
        note?.isStarred.toggle()
        
        // Update the database
        notesModel?.updateIsStarredStatus(note!.noteId, note!.isStarred)
        
        // Update the star button image
        setStarButtonImage()
    }
}
