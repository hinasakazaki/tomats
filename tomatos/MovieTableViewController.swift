//
//  MovieTableViewController.swift
//  tomatos
//
//  Created by Hina Sakazaki on 9/19/15.
//  Copyright © 2015 Hina Sakazaki. All rights reserved.
//

import UIKit
import AFNetworking

class MovieTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
  
    var movies : NSArray = []
    
    override func viewDidLoad() {
        print("hello")

        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 100
        
        performAsyncMovieFetch()
        
        // Do any additional setup after loading the view.
    }
    
    func performAsyncMovieFetch() {

        let url = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json")!

        let req = NSURLRequest(URL: url)

        let task = NSURLSession.sharedSession().dataTaskWithRequest(req) { (data, response, error) -> Void in
            if let data = data {
                dispatch_async(dispatch_get_main_queue()){
                    do {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue : 0)) as? NSDictionary {
                            //set the variables
                            self.movies = (json["movies"] as? [NSDictionary])!
                            self.tableView.reloadData()
                        }

                    } catch {

                    }
                }
            }
        }
        task.resume()
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.hinerz.tomatoCell", forIndexPath: indexPath) as! MovieTableViewCell
        
        let movie = self.movies[indexPath.row] as? NSDictionary
        
        cell.setView(movie!);
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
}
