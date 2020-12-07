//
//  ViewController.swift
//  Quick Note
//
//  Created by Neel B Gandhi on 11/26/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var starredFilter: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    private var isStarFiltered = false
    private var notes = [Note]()
    private var notesModel = NotesModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set tableView delegate and dataSource
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set self as delegate for NotesModel
        notesModel.delegate = self
        
        // Set the star filter image
        setStarFilterImage()
        
        // Retrieve notes based on status of the star filter
        isStarFiltered ? notesModel.getNotes(true) : notesModel.getNotes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let noteViewController = segue.destination as! NoteViewController
        
        // If the user has selected a note in the list, transition to notes view controller.
        if tableView.indexPathForSelectedRow != nil {
            
            // Set the note and notesModel property of notes view controller
            noteViewController.note = notes[tableView.indexPathForSelectedRow!.row]
            
            // Deselect the selected row, so that it doesn't interfere with new note creation
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: false)
        }
        // Whether it is a new note or an updated note, we still want to pass it through to the NotesModel.
        // Hence this is outside the IF condition.
        noteViewController.notesModel = self.notesModel
    }
    
    
    @IBAction func starFilterTapped(_ sender: Any) {
        
        // Update the star toggle with latest star filter status
        isStarFiltered.toggle()
        
        // Retrieve notes based on status of the star filter
        isStarFiltered ? notesModel.getNotes(true) : notesModel.getNotes()
        
        
        // Update the image of star filter button
        setStarFilterImage()
        
    }
    
    func setStarFilterImage() {
        // Set the status of the star filter button
        let imageName = isStarFiltered ? "star.fill" : "star"
        starredFilter.image = UIImage(systemName: imageName)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            let note = self.notes[indexPath.row]
            
            // Call methods in Notes model to delete
            self.notesModel.deleteNote(note)
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

// MARK: - UITableViewDelegate and UITableViewDataSource Methods

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        
        // Customize the cell
        let titleLabel = cell.viewWithTag(1) as? UILabel
        let bodyLabel = cell.viewWithTag(2) as? UILabel
        
        // Set the text for title and body
        titleLabel?.text = notes[indexPath.row].title
        bodyLabel?.text = notes[indexPath.row].body
        
        return cell
    }
}


extension ViewController: NotesModelProtocol {
    func notesRetrieved(notes: [Note]) {
        // Set notes property and refresh the table view
        self.notes = notes
        tableView.reloadData()
    }
}
