//
//  ViewController.swift
//  SwiftExample
//
//  Created by Nick Lockwood on 30/07/2014.
//  Copyright (c) 2014 Charcoal Design. All rights reserved.
//

import UIKit
import Parse



class ViewController: UIViewController, iCarouselDataSource, iCarouselDelegate
{
    @IBOutlet var container: UIView!
    @IBOutlet var carousel: iCarousel!
    var items:[String] = []
    
    func queryDatabase() {
        print("Running query database")
        PFGeoPoint.geoPointForCurrentLocationInBackground { (geopoint, error) in
            let query = PFQuery(className: "Posts")
            print("Successfully created geopoint")
            query.whereKey("location", nearGeoPoint: geopoint!, withinMiles: 20.0)
            //let posts = query.findObjects()
            print ("Queried geopoints in 20 mile radius")
            query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error) -> Void in
                if error == nil {
                    print ("Iterating through the posts")
                    for post in posts! {
                        if let postMessage = post.valueForKey("message") as? String {
                            self.items.append(postMessage)
                            
                            //print("New Message: " + postMessage);
                        }
                    }
                    // Populate carousel
                    self.carousel.reloadData();
                }
            }
        }
    }
    
    
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Query the database
        queryDatabase()
        
        // Add observers
        let mainColor = pulseOrange
        let sdryColor = lighterOrange
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [sdryColor.CGColor, mainColor.CGColor]
        let gradientLocations: [Float] = [0.0,0.66]
        gradientLayer.locations = gradientLocations
        container.layer.insertSublayer(gradientLayer, atIndex: 0)

        carousel.type = .Wheel
    }
    
    func queryFeeds(notification: NSNotification) {
        items = notification.object as! [String]
    }
    
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int
    {
        print("printing items in carousel")
        print(items.count)
        return items.count
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView
    {
        var textField: UITextView
        var itemView: UIImageView
        //create new view if no view is available for recycling
        if (view == nil)
        {
            //don't do anything specific to the index within
            //this `if (view == nil) {...}` statement because the view will be
            //recycled and used with other index values later
            itemView = UIImageView(frame:CGRect(x:0, y:0, width:300, height:250))
            itemView.contentMode = .Center
            itemView.backgroundColor = whiteTrans
            textField = UITextView(frame:itemView.bounds)
            textField.backgroundColor = whiteTrans
            textField.textColor = black
            textField.textAlignment = .Center
            textField.font = UIFont(name: "HelveticaNeue-Light", size: 17)
            textField.tag = 1
            itemView.addSubview(textField)
        }
        else
        {
            //get a reference to the label in the recycled view
            itemView = view as! UIImageView;
            //textField = itemView.viewWithTag(1) as! UITextView!
            itemView = UIImageView(frame:CGRect(x:0, y:0, width:300, height:250))
            itemView.contentMode = .Center
            itemView.backgroundColor = whiteTrans
            textField = UITextView(frame:itemView.bounds)
            textField.backgroundColor = whiteTrans
            textField.textColor = black
            textField.textAlignment = .Center
            textField.font = UIFont(name: "HelveticaNeue-Light", size: 17)
            itemView.addSubview(textField)
        }
        
        //set item label
        //remember to always set any properties of your carousel item
        //views outside of the `if (view == nil) {...}` check otherwise
        //you'll get weird issues with carousel item content appearing
        //in the wrong place in the carousel
        textField.text = "\(items[index])"
        
        return itemView
    }
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
    {
        //print("initializing options")
        if (option == .Spacing)
        {
            return value
        }
        else if (option == .Radius)
        {
            return value * 1.5
        }
        else if (option == .Wrap)
        {
            return 1.0
        }
        return value
    }
}

