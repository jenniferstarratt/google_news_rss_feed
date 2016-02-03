//
//  StoryTableViewCell.swift
//  NewsApp
//
//  Created by Jennifer Graham on 2/1/16.
//  Copyright © 2016 Jennifer Graham. All rights reserved.
//

import UIKit

/// A cell within the listing of Google News stories.
final class StoryTableViewCell: UITableViewCell {
    
    /// Title of the story.
    @IBOutlet weak var storyTitleLabel: UILabel!
    
    /// Image for the story.
    @IBOutlet weak var storyImageView: UIImageView!
    
    /// Body/description of the story.
    @IBOutlet weak var storyBodyWebView: UIWebView!
    
    /// A gradient view for the description of the story. This produces a "fade out" effect on the cells.
    @IBOutlet weak var gradientView: UIView!
    
    /// The gradient layer for the cell.
    private let gradientLayer = CAGradientLayer()
    
    /**
        Configures a cell within the table view.
     
        - parameter story: to be displayed within the cell
     */
    func configureCell(story: Story) {
        storyImageView.image = story.image
        storyTitleLabel.text = story.title
        storyBodyWebView.loadHTMLString(story.body, baseURL: nil)
        gradientLayer.frame = gradientView.bounds
        let color1 = UIColor.whiteColor().colorWithAlphaComponent(0.0).CGColor as CGColorRef
        let color2 = UIColor.whiteColor().CGColor as CGColorRef
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.0, 0.5]
        gradientView.layer.addSublayer(gradientLayer)
    }

}
