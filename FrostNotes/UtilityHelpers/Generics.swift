//
//  Generics.swift
//  FrostNotes
//
//  Created by Tilakkumar Gondi on 22/01/20.
//  Copyright © 2020 Tilakkumar Gondi. All rights reserved.
//  This class contains the definations of the generic objects with the implementation of observer pattern to achieve binding of tableview datasource.

import Foundation

typealias CompletionHandler = (()->Void)
//Generic value class to support the recative programming with observers on the properties of model objects.
class GenericValue<T> {
    
    var value:T {
        didSet{
            self.notify()
        }
    }
    
    private var observers =  [String:CompletionHandler]()
    
    init(with value:T) {
        self.value = value
    }
    
    public func addObserver(_ obsrv:NSObject, completionHandler: @escaping CompletionHandler){
        observers[obsrv.description] = completionHandler
    }
    
    public func addAndNotify(obsrv:NSObject, completionHandler: @escaping CompletionHandler){
        self.addObserver(obsrv, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify(){
        observers.forEach({ $0.value() })
    }
    
    deinit {
        observers.removeAll()
    }
}

//Generic class to handel the data source values in the app.
class GenericDataSource<T>: NSObject {
    var data:GenericValue<[T]> = GenericValue(with: [])
}

//Generic class to handel the data source values in the app.
class GenericDataDelegate<T>: NSObject {
    var data:GenericValue<[T]> = GenericValue(with: [])
   
}
