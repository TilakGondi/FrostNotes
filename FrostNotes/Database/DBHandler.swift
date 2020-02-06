//
//  DBHandler.swift
//  FrostNotes
//
//  Created by Tilakkumar Gondi on 05/02/20.
//  Copyright © 2020 Tilakkumar Gondi. All rights reserved.
//  This is the helper class for DB operatoions like insert new note to db and fetch the notes.

import Foundation
import CoreData
import UIKit

class DBHandler {
    
    private let userDefaults = UserDefaults.standard
    static let shared = DBHandler()
    
    private func getNotesContextAndEntity() -> (NSManagedObjectContext?,NSEntityDescription?){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return(nil,nil)
        }
        let context = appDelegate.persistentContainer.viewContext
                
        guard let note = NSEntityDescription.entity(forEntityName: "Notes", in: context) else {
            return(nil,nil)
        }
        return (context,note)
        
    }
    
    
    func insert(note:Note) -> Bool  {
        //To prepare and get the (NSManagedObjectContext?,NSEntityDescription?)
        let contexEntity = self.getNotesContextAndEntity()
        guard let insertContext = contexEntity.0, let notesEntityDesc = contexEntity.1  else {
            return false
        }
        //To create the managed object to insert the note into DB
        guard let noteEntity = NSManagedObject(entity: notesEntityDesc, insertInto: insertContext) as? Notes else{
            return false
        }
        
        noteEntity.mapNotesEntitWithValuesFrom(model: note)

        do {
            try insertContext.save()
            return true
        } catch {
            print("Could not save the note. \(error), \(error.localizedDescription)")
            return false
        }
    }
    
    func fetchAllNotes(with titleStr:String) -> [Note]{
        //To prepare and get the (NSManagedObjectContext?,NSEntityDescription?)
        let contexEntity = self.getNotesContextAndEntity()
        guard let fetchContext = contexEntity.0, let notesEntityDesc = contexEntity.1  else {
            return []
        }

        //To create the fetch request for the notes entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = notesEntityDesc
        
        //To fetch the notes matching the search criteria
        var titlePredicate: NSPredicate?
        if titleStr.count > 0 {
            titlePredicate = NSPredicate(format: "title CONTAINS[c] '\(titleStr)'")
            fetchRequest.predicate = titlePredicate
        }else{
            fetchRequest.predicate = nil
        }
        
        //To add the sortdescriptor when date filter is applied
        if userDefaults.bool(forKey: "FilterByDate") {
            let sort = NSSortDescriptor(key: #keyPath(Notes.datetime), ascending: false)
            fetchRequest.sortDescriptors = [sort]
        }
        
        var notesList = [Note]()
        do {
            let notesDBList = try fetchContext.fetch(fetchRequest) as! [Notes]
            for note in notesDBList {
                notesList.append(note.mapNotesEntityToModelObj())
            }
            return notesList

        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return []
        }
        
    }
}

//MARK: Helper Extensions
extension Notes {
    func mapNotesEntitWithValuesFrom(model:Note) {
        self.title = model.title
        self.content = model.content
        self.image = model.image
        self.datetime = model.date
        self.id = model.id
        self.tags = model.tags
    }
    
    func mapNotesEntityToModelObj() -> Note {
        var tmpNote:Note = Note()
        tmpNote.title = self.title
        tmpNote.content = self.content
        tmpNote.image = self.image
        tmpNote.date = self.datetime
        tmpNote.id = self.id
        tmpNote.tags = self.tags
        return tmpNote
    }
}


