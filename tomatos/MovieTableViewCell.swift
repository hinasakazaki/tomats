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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal func setView(movie: NSDictionary){
        let urlString = movie.valueForKeyPath("posters.profile") as? NSString
        let url = NSURL(string: urlString as! String)!
        self.movieImageView.setImageWithURL(url)
    }

}
