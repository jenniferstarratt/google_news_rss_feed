//
//  StoryListViewController.swift
//  NewsApp
//
//  Created by Jennifer Graham on 2/1/16.
//  Copyright © 2016 Jennifer Graham. All rights reserved.
//

import UIKit

/// Manages the listing of Google News stories that appear on the initial screen.
final class StoryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate {
    
    /// The table view that displays the listing of stories.
    @IBOutlet var storyTableView: UITableView!
    
    /// The view that displays when no stories were able to be parsed.
    @IBOutlet weak var noStoriesView: UIView!
    
    /// The RSS feed parser.
    private lazy var rssFeedParser : RSSFeedParser = {
        return RSSFeedParser(delegate: self)
    }()
    
    /// The segue identifier for navigating to details.
    private let segueToDetails = "StoryDetails"
    
    /// The listing of stories retrieved from the parser.
    private var stories = NSMutableArray()
    
    /// The current element being parsed.
    private var currentElement = ""
    
    /// The current title being parsed.
    private var currentTitle = ""
    
    /// The current body being parsed.
    private var currentBody = ""
    
    /**
        Parses either the available feed or accesses any cached stories as a failover.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        let result = rssFeedParser.parse()
        if !result {
            stories = rssFeedParser.retrieveResults()
            noStoriesView.hidden = stories.count > 0
            storyTableView.reloadData()
        }
    }
    
    /**
        Refreshes the listing of stories when no stories were initially shown.
     
        - parameter sender: refresh button within "no stories" view
     */
    @IBAction func refreshListing(sender: AnyObject) {
        rssFeedParser.parse()
    }
    
    // MARK: - NSXMLParserDelegate -
    
    func parserDidStartDocument(parser: NSXMLParser) {
        storyTableView.reloadData()
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        noStoriesView.hidden = stories.count > 0
        if stories.count > 0 {
            rssFeedParser.storeResults(stories)
        } else {
            stories = rssFeedParser.retrieveResults()
            noStoriesView.hidden = stories.count > 0
        }
        storyTableView.reloadData()
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
            currentBody = ""
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if currentElement == "title" {
            currentTitle += string
        } else if currentElement == "description" {
            currentBody += string
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            stories.addObject(Story(title: currentTitle, body: currentBody))
        }
    }

    // MARK: - UITableViewDataSource -
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(StoryTableViewCell), forIndexPath: indexPath)
        (cell as! StoryTableViewCell).configureCell(stories[indexPath.row] as! Story)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    // MARK: - UITableViewDelegate -
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(segueToDetails, sender: nil)
    }
    
    // MARK: - Navigation -

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let storyDetails = segue.destinationViewController as? StoryDetailsViewController {
            storyDetails.story = stories[storyTableView.indexPathForSelectedRow!.row] as! Story
            storyTableView.deselectRowAtIndexPath(storyTableView.indexPathForSelectedRow!, animated: false)
        }
    }

}
