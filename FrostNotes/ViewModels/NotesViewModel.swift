//
//  NotesViewModel.swift
//  FrostNotes
//
//  Created by Tilakkumar Gondi on 06/02/20.
//  Copyright © 2020 Tilakkumar Gondi. All rights reserved.
//

import Foundation

struct NotesViewModel {
 
    weak var dataSrc : GenericDataSource<Note>?
    
    
    init(dataSource:GenericDataSource<Note>) {
        self.dataSrc = dataSource
    }
    
    func loadNotesListFromDB() {
        let notesList:[Note] = DBHandler.shared.fetchAllNotes(with: "")
        if notesList.count > 0 {
            DispatchQueue.main.async {
                self.dataSrc?.data.value = notesList
            }
        }
    }
    //To fetch the notes when the search term is entered. THis method to be used to implement search function..
    func loadNotesWithTitleStrin(title:String)  {
        let notesList:[Note] = DBHandler.shared.fetchAllNotes(with: title)
        if notesList.count > 0 {
            DispatchQueue.main.async {
                self.dataSrc?.data.value = notesList
            }
        }
    }

   
}
