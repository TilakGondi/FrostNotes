//
//  NotesListDataSource.swift
//  FrostNotes
//
//  Created by Tilakkumar Gondi on 06/02/20.
//  Copyright © 2020 Tilakkumar Gondi. All rights reserved.
//  This is the Datasource class responsible for presenting the data in the table view cells in the NotesLisController

import Foundation
import UIKit

class NotesListDataSource: GenericDataSource<Note>,UITableViewDataSource {
    
    //UITableViewDataSource  protocoll methods to supply data to UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let note = self.data.value[indexPath.row]
        
        if let imageData = note.image {
            let cell:NoteWithImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! NoteWithImageTableViewCell
            cell.bgCellView.makeRoundedCorners(with: 15)
            cell.noteMediaImage.image = UIImage(data: imageData)
            cell.dateLbl.text = note.date?.getDateTimeForDisplay()
            cell.tagsLbl.text = note.tags
            cell.titleLbl.text = note.title
            cell.contentLbl.text = note.content
            return cell
        }else{
            let cell:NotesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotesTableViewCell
            cell.bgCellView.makeRoundedCorners(with: 15)
            cell.dateLbl.text = note.date?.getDateTimeForDisplay()
            cell.tagsLbl.text = note.tags
            cell.titleLbl.text = note.title
            cell.contentLbl.text = note.content
            return cell
        }
    }

    
}


