//
//  MovieDetailsViewController.swift
//  tomatos
//
//  Created by Hina Sakazaki on 9/19/15.
//  Copyright © 2015 Hina Sakazaki. All rights reserved.
//

import UIKit
import AFNetworking

class MovieDetailsViewController: UIViewController {
    
    var movie : NSDictionary?
    
    @IBOutlet weak var movieDescription: UITextView!

    @IBOutlet weak var poster: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlString = movie!.valueForKeyPath("posters.profile") as? NSString
        
        //image
        var range = urlString?.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let range = range {
            urlString = urlString!.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
        }
        
        let url = NSURL(string: urlString as! String)!
        
        self.poster.setImageWithURL(url)

        self.movieDescription.text = movie!.valueForKey("synopsis") as? String
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
