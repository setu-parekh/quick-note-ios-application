//
//  NotesModel.swift
//  Quick Note
//
//  Created by Neel B Gandhi on 11/26/20.
//

import Foundation
import Firebase

protocol NotesModelProtocol {
    func notesRetrieved(notes:[Note])
}

class NotesModel {
    
    var delegate:NotesModelProtocol?
    var snapshotListener:ListenerRegistration?
    
    deinit {
        // Unregister snapshotListener
        self.snapshotListener?.remove()
    }
    
    func getNotes(_ starredOnly:Bool = false) {
        
        // Detach a listener
        snapshotListener?.remove()
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Declare a base query to fetch notes
        var notesQuery:Query = db.collection("notes")
        
        // If the starredOnly is set to True, update the query for that.
        if starredOnly {
            notesQuery = notesQuery.whereField("isStarred", isEqualTo: true)
        }
        
        // Get all the notes from database
        self.snapshotListener = notesQuery.addSnapshotListener({ (notesQuerySnapshot, error) in
            // Make sure there are no errors and that notesQuerySnapshot is not empty
            if error == nil && notesQuerySnapshot != nil {
                
                var notes = [Note]()
                
                // Parse data from DB into Notes
                for note in notesQuerySnapshot!.documents {
                    
                    let createdAtDate:Date = Timestamp.dateValue(note["createdAt"] as! Timestamp)()
                    let updatedAtDate:Date = Timestamp.dateValue(note["updatedAt"] as! Timestamp)()
                    
                    let n = Note(noteId: note["noteId"] as! String, title: note["title"] as! String, body: note["body"] as! String, isStarred: note["isStarred"] as! Bool, createdAt: createdAtDate, updatedAt: updatedAtDate)
                    
                    notes.append(n)
                }
                
                // Call the delegate and pass back the notes in the main thread
                DispatchQueue.main.async {
                    self.delegate?.notesRetrieved(notes: notes)
                }
            }
        })
    }
    
    func deleteNote(_ n: Note) {
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Delete a particular note
        db.collection("notes").document(n.noteId).delete()
    }
    
    func saveNote(_ n: Note) {
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Save a particular note
        db.collection("notes").document(n.noteId).setData(convertNoteToDict(n))
    }
    
    func updateIsStarredStatus(_ noteId:String, _ isStarred:Bool) {
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Save a particular note's isStarred status
        db.collection("notes").document(noteId).updateData(["isStarred": isStarred])
    }
    
    func convertNoteToDict(_ n:Note) -> [String:Any] {
        var noteDict = [String:Any]()
        
        noteDict["noteId"] = n.noteId
        noteDict["title"] = n.title
        noteDict["body"] = n.body
        noteDict["isStarred"] = n.isStarred
        noteDict["createdAt"] = n.createdAt
        noteDict["updatedAt"] = Date()
        
        return noteDict
    }
}
