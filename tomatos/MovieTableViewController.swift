//
//  MovieTableViewController.swift
//  tomatos
//
//  Created by Hina Sakazaki on 9/19/15.
//  Copyright © 2015 Hina Sakazaki. All rights reserved.
//

import UIKit
import AFNetworking
import SwiftLoader

class MovieTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var refreshControl:UIRefreshControl!

    @IBOutlet weak var tableView: UITableView!
  
    var movies : NSArray = []
    var err : Bool = false
    
    override func viewDidLoad() {
        print("hello")

        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 100
        
        performAsyncMovieFetch()
        
        // Do any additional setup after loading the view.
    }
    
    func refresh(sender: AnyObject) {
        performAsyncMovieFetch()
        self.refreshControl.endRefreshing()
    }
    
    func performAsyncMovieFetch() {
        
        SwiftLoader.show(animated: true)

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
                            SwiftLoader.hide()
                        }

                    } catch {
                        print("JSON error")
                    }
                }
            } else if let error = error {
                print(error.description)
                self.err = true
            }
        }
        task.resume()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc = segue.destinationViewController as! MovieDetailsViewController
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        
        let index = indexPath!.row
        vc.movie = self.movies[index] as? NSDictionary
    }
   
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.hinerz.tomatoCell", forIndexPath: indexPath) as! MovieTableViewCell
        
        let movie = self.movies[indexPath.row] as? NSDictionary
        
        if (self.err){
            cell.setError()
        }
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
