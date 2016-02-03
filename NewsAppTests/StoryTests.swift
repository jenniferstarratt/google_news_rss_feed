//
//  StoryTests.swift
//  StoryTests
//
//  Created by Jennifer Graham on 2/1/16.
//  Copyright © 2016 Jennifer Graham. All rights reserved.
//

import XCTest
@testable import NewsApp

/// Tests for the "Story" model.
class StoryTests: XCTestCase {
    
    /// Sample title of a story.
    static let sampleTitle = "Marco Rubio becomes early hope for mainstream Republicans - Reuters"
    
    /// Sample HTML returned from the RSS feed.
    static let sampleHTML = "<table border=\"0\" cellpadding=\"2\" cellspacing=\"7\" style=\"vertical-align:top;\"><tr><td width=\"80\" align=\"center\" valign=\"top\"><font style=\"font-size:85%;font-family:arial,sans-serif\"><a href=\"http://news.google.com/news/url?sa=t&amp;fd=R&amp;ct2=us&amp;usg=AFQjCNH2KIuo1nQE55Rg-3_Hcpd4mt3c5A&amp;clid=c3a7d30bb8a4878e06b80cf16b898331&amp;cid=52779041185457&amp;ei=u0KxVvi_MZWP3QGelqSYCg&amp;url=http://www.reuters.com/article/us-usa-election-iowa-idUSMTZSAPEC21V82B3P\"><img src=\"//t1.gstatic.com/images?q=tbn:ANd9GcQ_GKDcmD_tLENrhzEhSyM3Yvfu_BzIsndEapp0v_iUKQHbs45oDz-epmyMMqk2KrDIrm3fuT8b\" alt=\"\" border=\"1\" width=\"80\" height=\"80\"><br><font size=\"-2\">Reuters</font></a></font></td><td valign=\"top\" class=\"j\"><font style=\"font-size:85%;font-family:arial,sans-serif\"><br><div style=\"padding-top:0.8em;\"><img alt=\"\" height=\"1\" width=\"1\"></div><div class=\"lh\"><a href=\"http://news.google.com/news/url?sa=t&amp;fd=R&amp;ct2=us&amp;usg=AFQjCNH2KIuo1nQE55Rg-3_Hcpd4mt3c5A&amp;clid=c3a7d30bb8a4878e06b80cf16b898331&amp;cid=52779041185457&amp;ei=u0KxVvi_MZWP3QGelqSYCg&amp;url=http://www.reuters.com/article/us-usa-election-iowa-idUSMTZSAPEC21V82B3P\"><b>Marco Rubio becomes early hope for mainstream Republicans</b></a><br><font size=\"-1\"><b><font color=\"#6f6f6f\">Reuters</font></b></font><br><font size=\"-1\">DES MOINES, Iowa/RINDGE, N.H. U.S. Senator Marco Rubio, emerging from the first Republican nominating contest of the 2016 presidential campaign as the party&#39;s leading mainstream candidate, faces a strong field of rival establishment figures in next&nbsp;...</font><br><font size=\"-1\"><a href=\"http://news.google.com/news/url?sa=t&amp;fd=R&amp;ct2=us&amp;usg=AFQjCNG8pnS5I52LIF5P2RsJDjTp1ES0fA&amp;clid=c3a7d30bb8a4878e06b80cf16b898331&amp;cid=52779041185457&amp;ei=u0KxVvi_MZWP3QGelqSYCg&amp;url=https://www.washingtonpost.com/news/post-politics/wp/2016/02/02/inside-a-democratic-caucus-that-almost-felt-the-bern/\">Inside a Democratic caucus that (almost) felt the Bern</a><font size=\"-1\" color=\"#6f6f6f\"><nobr>Washington Post</nobr></font></font><br><font size=\"-1\"><a href=\"http://news.google.com/news/url?sa=t&amp;fd=R&amp;ct2=us&amp;usg=AFQjCNGp_JJ_VFrM-V9-WRzp4W8OxWVDhg&amp;clid=c3a7d30bb8a4878e06b80cf16b898331&amp;cid=52779041185457&amp;ei=u0KxVvi_MZWP3QGelqSYCg&amp;url=http://www.nytimes.com/aponline/2016/02/02/us/politics/ap-us-2016-election-how-it-happened.html\">In Iowa, Late Deciders and Evangelicals Sided Against Trump</a><font size=\"-1\" color=\"#6f6f6f\"><nobr>New York Times</nobr></font></font><br><font size=\"-1\"><a href=\"http://news.google.com/news/url?sa=t&amp;fd=R&amp;ct2=us&amp;usg=AFQjCNGWM3WNJOdDRUpa3cM0_T9opDFGfw&amp;clid=c3a7d30bb8a4878e06b80cf16b898331&amp;cid=52779041185457&amp;ei=u0KxVvi_MZWP3QGelqSYCg&amp;url=http://www.politico.com/story/2016/02/rubios-establishment-rivals-sharpen-their-knives-in-new-hampshire-218620\">The rush to derail Rubio</a><font size=\"-1\" color=\"#6f6f6f\"><nobr>Politico</nobr></font></font><br><font size=\"-1\" class=\"p\"><a href=\"http://news.google.com/news/url?sa=t&amp;fd=R&amp;ct2=us&amp;usg=AFQjCNGVM50VNAhLRfU4j4P18WRIliSrng&amp;clid=c3a7d30bb8a4878e06b80cf16b898331&amp;cid=52779041185457&amp;ei=u0KxVvi_MZWP3QGelqSYCg&amp;url=http://www.theatlantic.com/politics/archive/2016/02/hillary-clinton-bernie-sanders-coin-flips-iowa-caucus/459429/\"><nobr>The Atlantic</nobr></a>&nbsp;-<a href=\"http://news.google.com/news/url?sa=t&amp;fd=R&amp;ct2=us&amp;usg=AFQjCNGe-OC98wU1yisPi2xRIpa7zx3woQ&amp;clid=c3a7d30bb8a4878e06b80cf16b898331&amp;cid=52779041185457&amp;ei=u0KxVvi_MZWP3QGelqSYCg&amp;url=http://www.cnn.com/2016/02/02/politics/new-hampshire-primary-2016/index.html\"><nobr>CNN International</nobr></a>&nbsp;-<a href=\"http://news.google.com/news/url?sa=t&amp;fd=R&amp;ct2=us&amp;usg=AFQjCNESeAl6HgkLpfN2Srzf1SQXpCc7Rw&amp;clid=c3a7d30bb8a4878e06b80cf16b898331&amp;cid=52779041185457&amp;ei=u0KxVvi_MZWP3QGelqSYCg&amp;url=http://www.csmonitor.com/USA/Politics/Decoder/2016/0202/The-two-numbers-that-explain-Iowa-vote\"><nobr>Christian Science Monitor</nobr></a></font><br><font class=\"p\" size=\"-1\"><a class=\"p\" href=\"http://news.google.com/news/more?ncl=dYurR6iwUGvWFYMz_YjJNg3YWVVAM&amp;authuser=0&amp;ned=us&amp;topic=h\"><nobr><b>all 14,427 news articles&nbsp;&raquo;</b></nobr></a></font></div></font></td></tr></table>"
    
    /// Sample body to compare to.
    static let sampleBody = "DES MOINES, Iowa/RINDGE, N.H. U.S. Senator Marco Rubio, emerging from the first Republican nominating contest of the 2016 presidential campaign as the party&#39;s leading mainstream candidate, faces a strong field of rival establishment figures in next..."
    
    /// Sample image URL.
    static let sampleImageURL = "http:t1.gstatic.com/images?q=tbn:ANd9GcQ_GKDcmD_tLENrhzEhSyM3Yvfu_BzIsndEapp0v_iUKQHbs45oDz-epmyMMqk2KrDIrm3fuT8b"
    
    /// Sample story model to compare to.
    static let sampleStory = Story(title: sampleTitle, body: sampleHTML)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
    Tests that Story's entireHTML is retained.
     */
    func testRetentionOfHTML() {
        XCTAssert(StoryTests.sampleStory.entireHTML == StoryTests.sampleHTML)
    }
    
    /**
    Tests that the image URL is correctly being retrieved from the description of the story.
     */
    func testRetrieveImage() {
        XCTAssert(StoryTests.sampleStory.imageURL == StoryTests.sampleImageURL)
    }
    
    /**
     Tests that the description does not contain any HTML tags.
     */
    func testCleanHTML() {
        XCTAssert(StoryTests.sampleStory.body == StoryTests.sampleBody)
    }
}
