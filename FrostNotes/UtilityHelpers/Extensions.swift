//
//  Extensions.swift
//  FrostNotes
//
//  Created by Tilakkumar Gondi on 19/01/20.
//  Copyright © 2020 Tilakkumar Gondi. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    //To get the string from the UNIX date format .
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateStyle = .long
        dateFormatter.dateFormat = "MMM dd YYYY - HH:mm"
        return dateFormatter.string(from: date)
    }
    
    //To calculate the number of minutes past the previous live rates refresh.
    func getTimeInterval() -> Double {
        let cal = Calendar.current
        let currentDate = Date()
        let previousDate = Date.init(timeIntervalSince1970: self)
        let components = cal.dateComponents([.minute], from: previousDate, to: currentDate)
        let diffMinutes = components.minute!
        return Double(diffMinutes)
    }
}

extension UIView {
    func makeRoundedCorners(with radius:Int) {
        self.layer.cornerRadius = CGFloat(radius)
    }
    
}

extension Date{
    func getDateStringForId() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateStyle = .long
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    func getDateTimeForDisplay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateStyle = .long
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter.string(from: self)
    }
}

extension String{
    func randomStringWith(PrefixStr prefix:String) -> String {
        return prefix + Date().getDateStringForId()
    }
}



