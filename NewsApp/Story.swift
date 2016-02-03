//
//  Story.swift
//  NewsApp
//
//  Created by Jennifer Graham on 2/1/16.
//  Copyright © 2016 Jennifer Graham. All rights reserved.
//

import UIKit

/// A story retrieved from Google News which contains a title, a description, and an image.
final class Story: NSObject, NSCoding {
    
    /// Title of the story.
    var title = ""
    
    /// Body/description of the story.
    var body = ""
    
    /// Image for the story.
    var image = UIImage()
    
    /// Image URL (mostly for testing).
    var imageURL = ""
    
    /// The raw HTML from the RSS feed.
    var entireHTML = ""
    
    override init() { }
    
    /**
        Initializes a new story.
     
        - parameter title: of the story
        - parameter body:  of the story
        - parameter image: for the story
     
        - returns: a Story object with all the necessary details
     */
    init(title: String, body: String) {
        super.init()
        self.title = title
        self.entireHTML = body
        self.body = cleanHTML(body)
        self.imageURL = retrieveImageLocation(body)
        self.image = retrieveUIImage(imageURL)
    }
    
    /**
        Removes the formatting that is returned by the RSS feed for the story description.
     
        - parameter html: from the RSS feed
     
        - returns: a readable description of the story
     */
    func cleanHTML(html: String) -> String {
        // Removes the initial HTML within the description
        var components = html.componentsSeparatedByString("<br><font size=\"-1\">")
        if components.endIndex > 1 {
            components.removeFirst(2)
            let summaryWithAdditionalHTMLString = components.joinWithSeparator("")
            // Removes the second half of the HTML within the description
            if let additionalHTMLRange = summaryWithAdditionalHTMLString.rangeOfString(".*?&nbsp;", options: .RegularExpressionSearch) {
                let summary = summaryWithAdditionalHTMLString.substringWithRange(additionalHTMLRange)
                // Removes any remaining HTML tags that may persist
                if let cleanSummaryRange = summary.rangeOfString(".*?<", options: .RegularExpressionSearch) {
                    let cleanSummary = summary.substringWithRange(cleanSummaryRange)
                    return cleanSummary.stringByReplacingOccurrencesOfString("<", withString: "...")
                }
                return summary.stringByReplacingOccurrencesOfString("&nbsp;", withString:"...")
            }
        }
        return html
    }
    
    /**
        Retrieves the UIImage from the description HTML.
     
        - parameter imageURL: from within the description returned from the RSS feed
     
        - returns: a UIImage from the given image URL
     */
    func retrieveUIImage(imageURL: String) -> UIImage {
        if let imageURL = NSURL(string: imageURL),
            imageData = NSData(contentsOfURL: imageURL),
            image = UIImage(data: imageData){
                return image
        }
        return UIImage()
    }
    
    /**
        Retrieves the image URL from the description HTML.
     
        - parameter html: from within the description returned from the RSS feed
     
        - returns: the raw image URL
     */
    func retrieveImageLocation(html: String) -> String {
        // Retrieve only the <img> tag
        if let imageTagRange = html.rangeOfString("<img[^>]+>", options: .RegularExpressionSearch) {
            let imageTag = html.substringWithRange(imageTagRange)
            // Remove the extra characters around the image URL within the tag
            if let imageAddressRange = imageTag.rangeOfString("//?.*?\"", options: .RegularExpressionSearch) {
                var rawImageURL = imageTag.substringWithRange(imageAddressRange)
                // Remove the extra \ at the end
                rawImageURL.removeAtIndex(rawImageURL.endIndex.predecessor())
                // Add the "http:" to the beginning
                return rawImageURL.stringByReplacingOccurrencesOfString("//", withString: "http:")
            }
        }
        return html
    }
    
    // MARK: - NSCoding -
    
    init(coder aDecoder: NSCoder) {
        super.init()
        title = aDecoder.decodeObjectForKey("title") as! String
        entireHTML = aDecoder.decodeObjectForKey("entireHTML") as! String
        body = aDecoder.decodeObjectForKey("body") as! String
        image = aDecoder.decodeObjectForKey("image") as! UIImage
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(entireHTML, forKey: "entireHTML")
        aCoder.encodeObject(body, forKey: "body")
        aCoder.encodeObject(image, forKey: "image")
    }
    
}
