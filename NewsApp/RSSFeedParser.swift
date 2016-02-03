//
//  RSSFeedParser.swift
//  NewsApp
//
//  Created by Jennifer Graham on 2/1/16.
//  Copyright © 2016 Jennifer Graham. All rights reserved.
//

import Foundation

/// Parses the Google News RSS feed and stores/retrieves the results from user defaults.
final class RSSFeedParser : NSObject {
    
    /// Google News RSS feed.
    private let googleNewsRSS = "https://news.google.com/?output=rss"
    
    /// The available keys for accessing information in user defaults.
    private enum defaultsKeys {
        static let lastFeed = "lastFeedKey"
    }
    
    /// The parser of the Google News RSS feed. In some cases this can incorrectly return zero matching elements.
    // TODO: Investigate further
    private var parser = NSXMLParser()
    
    /// The delegate for the parser.
    private var delegate : NSXMLParserDelegate
    
    /**
        Initializes the RSSFeedParser.
     
        - parameter delegate: for the parser
     
        - returns: an initialized RSSFeedParser
     */
    init(delegate: NSXMLParserDelegate) {
        self.delegate = delegate
    }
    
    /**
        Parses the current Google News RSS feed.
     
        - returns: true if the parse was successful; false otherwise
     */
    func parse() -> Bool {
        if let url = NSURL(string: googleNewsRSS),
            parser = NSXMLParser(contentsOfURL: url) {
                parser.delegate = delegate
                return parser.parse()
        }
        return false
    }

    /**
        Stores the results from the complete Google News RSS feed parse in user defaults.
     
        - parameter stories: the stories retrieved from Google News
     */
    func storeResults(stories: NSMutableArray) {
        let archivedObject = NSKeyedArchiver.archivedDataWithRootObject(stories as NSArray)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(archivedObject, forKey: defaultsKeys.lastFeed)
        defaults.synchronize()
    }
    
    /**
        Retrieves the results from the prior, successful parse of the Google News RSS feed.
     
        - returns: the prior stories retrieved from the Google News RSS feed
     */
    func retrieveResults() -> NSMutableArray {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let results = defaults.objectForKey(defaultsKeys.lastFeed) as? NSData {
            return (NSKeyedUnarchiver.unarchiveObjectWithData(results) as? NSMutableArray)!
        }
        return NSMutableArray()
    }
    
}
