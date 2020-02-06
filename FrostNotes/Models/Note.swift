//
//  Notes.swift
//  FrostNotes
//
//  Created by Tilakkumar Gondi on 05/02/20.
//  Copyright © 2020 Tilakkumar Gondi. All rights reserved.
//  This is the struct used as Note entity model for use as object to perform create & view for the notes.

import Foundation


struct Note {
    var title:String?
    var content:String?
    var date:Date?
    var image:Data?
    var tags:String?
    var id:String?
}


