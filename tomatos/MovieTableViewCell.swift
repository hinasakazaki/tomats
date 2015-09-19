//
//  MovieTableViewCell.swift
//  tomatos
//
//  Created by Hina Sakazaki on 9/19/15.
//  Copyright © 2015 Hina Sakazaki. All rights reserved.
//

import UIKit
import AFNetworking

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var errorMessage: UILabel!
   
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var percent: UILabel!
    
    @IBOutlet weak var year: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal func setView(movie: NSDictionary){
        var urlString = movie.valueForKeyPath("posters.profile") as? NSString
        
        //image
        var range = urlString?.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let range = range {
            urlString = urlString!.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
        }
        
        let url = NSURL(string: urlString as! String)!
        
        self.movieImageView.setImageWithURL(url)
    
        //title
        let titleString = movie.valueForKey("title") as? String
        self.movieTitle.text =  titleString
        
        let ratingString = movie.valueForKey("mpaa_rating") as? String
        self.rating.text = "Rated " + ratingString!
        
        let yearString = movie.valueForKey("year") as? NSNumber
        self.year.text = yearString?.stringValue
        
        let timeString = movie.valueForKey("runtime") as? NSNumber
        self.time.text = (timeString?.stringValue)! + " mins"
        
        let percentString = movie.valueForKeyPath("ratings.audience_score") as? NSNumber
        self.percent.text = (percentString?.stringValue)! + "%"
    }

    func setError(){
        errorMessage.text = "Network Error."
    }
}
