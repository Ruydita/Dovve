//
//  UIString.swift
//  Dovve
//
//  Created by Dheeraj Kumar Sharma on 21/09/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

extension String {
    
    func height(withWidth width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [.font : font], context: nil)
        return actualSize.height
    }
    
    func stringByAddingPercentEncodingForRFC3986() -> String? {
      let unreserved = "-._~/?"
      let allowed = NSMutableCharacterSet.alphanumeric()
      allowed.addCharacters(in: unreserved)
      return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
    }
    
    func removeSpecialCharsFromString() -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890")
        return String(self.filter {okayChars.contains($0) })
    }
    
    //
    var byteArray: [UInt8] {
      return Array(self.utf8)
    }

    var data: Data {
      return Data(self.utf8)
    }

    var percentEscaped: String {
      let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ").inverted)
      guard let escapedString = self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) else {
        fatalError("Unable to encode string. My apologies.")
      }
      return escapedString
    }
    
    func parseTwitterDate()->String?{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        let indate = formatter.date(from: self)
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "hh:mm a dd:MM:yy"
        var outputDate:String?
        if let d = indate {
            outputDate = outputFormatter.string(from: d)
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a dd:MM:yy"
        guard let date = dateFormatter.date(from: outputDate!) else {return String()}
        return date.getTimeAgoDisplay("short")
    }
    
}

extension Double {
    var kmFormatted: String {
        if self >= 10000, self <= 999999 {
            return String(format: "%.1fK", locale: Locale.current,self/1000).replacingOccurrences(of: ".0", with: "")
        }
        if self > 999999 {
            return String(format: "%.1fM", locale: Locale.current,self/1000000).replacingOccurrences(of: ".0", with: "")
        }
        return String(format: "%.0f", locale: Locale.current,self)
    }
}