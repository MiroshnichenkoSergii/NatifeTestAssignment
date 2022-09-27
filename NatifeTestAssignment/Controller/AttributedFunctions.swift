//
//  AttributedFunctions.swift
//  NatifeTestAssignment
//
//  Created by Sergii Miroshnichenko on 26.09.2022.
//

import UIKit
import Foundation

class AttributedFunctions {
    
    func makeAttributedStringWithSubtitle(title: String, subtitle: String) -> NSAttributedString {
        let titleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)]

        let titleString = NSMutableAttributedString(string: "\(title)\n", attributes: titleAttributes)
        let subtitleString = NSAttributedString(string: subtitle, attributes: subtitleAttributes)

        titleString.append(subtitleString)

        return titleString
    }
    
    func makeAttributedTitle(title: String) -> NSAttributedString {
        let titleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        let titleString = NSMutableAttributedString(string: "\(title)\n", attributes: titleAttributes)
        return titleString
    }
    
    func makeAttributedSubtitle(subtitle: String) -> NSAttributedString {
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)]
        let subtitleString = NSAttributedString(string: subtitle, attributes: subtitleAttributes)
        return subtitleString
    }
}
