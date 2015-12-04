//
//  ZHMarkdownParser.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/3/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

private enum ZHMarkdownParserRegularExpression: String {
    case Strong =     "[\\*_]{2}(\\w+( \\w+)*)[\\*_]{2}"
    case Emphasis =   "[\\*_](\\w+( \\w+)*)[\\*_]"
    case Highlight =  "==(\\w+( \\w+)*)=="
    case Deletion =   "~~(\\w+( \\w+)*)~~"
    case InlineCode = "`(\\w+( \\w+)*)`"
    case Link =       "\\[(\\w+( \\w+)*)\\]\\((.*)\\)"
}

public struct ZHMarkdownParser {
    
    private let string: String
    
    public var HTML: String {
        let mutableHTML = NSMutableString(string: string)
        
        func replaceMatchesForMarkdownElementRegularExpression(element: ZHMarkdownParserRegularExpression, withTemplate template: String) {
            let expression = try? NSRegularExpression(pattern: element.rawValue, options: .AnchorsMatchLines)
            expression?.replaceMatchesInString(mutableHTML, options: [], range: NSMakeRange(0, mutableHTML.length), withTemplate: template)
        }
        
        replaceMatchesForMarkdownElementRegularExpression(.Strong, withTemplate: "<strong>$1</strong>")
        replaceMatchesForMarkdownElementRegularExpression(.Emphasis, withTemplate: "<em>$1</em>")
        replaceMatchesForMarkdownElementRegularExpression(.Highlight, withTemplate: "<span style=\"background-color: #FFFF00\">$1</span>")
        replaceMatchesForMarkdownElementRegularExpression(.Deletion, withTemplate: "<del>$1</del>")
        replaceMatchesForMarkdownElementRegularExpression(.InlineCode, withTemplate: "<code>$1</code>")
        replaceMatchesForMarkdownElementRegularExpression(.Link, withTemplate: "<a href=\"$3\">$1</a>")
        
        return mutableHTML as String
    }
    
    public init(string: String) {
        self.string = string
    }
    
}