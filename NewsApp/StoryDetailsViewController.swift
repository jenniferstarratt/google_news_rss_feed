//
//  StoryDetailsViewController.swift
//  NewsApp
//
//  Created by Jennifer Graham on 2/1/16.
//  Copyright © 2016 Jennifer Graham. All rights reserved.
//

import UIKit

/// Manages the details view of a particular story.
final class StoryDetailsViewController: UIViewController {
    
    /// The image for the story.
    @IBOutlet weak var storyImageView: UIImageView!
    
    /// The title of the story.
    @IBOutlet weak var storyTitleLabel: UILabel!
    
    /// The details of the story.
    @IBOutlet weak var storyWebView: UIWebView!
    
    /// The details of the story to be displayed.
    var story = Story()
    
    /**
        Populates the details of the story.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        storyImageView.image = story.image
        storyTitleLabel.text = story.title
        storyWebView.loadHTMLString(story.body, baseURL: nil)
    }

}
