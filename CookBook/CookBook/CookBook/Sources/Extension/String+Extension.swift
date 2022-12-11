//
//  String+Extension.swift
//  CookBook
//
//  Created by Дария Григорьева on 03.12.2022.
//

import Foundation

extension String {
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return NSAttributedString()
        }
        
        do {
            return try NSAttributedString(data: data, options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
