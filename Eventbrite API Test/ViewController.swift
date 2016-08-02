//
//  ViewController.swift
//  Eventbrite API Test
//
//  Created by Zoe Sheill on 7/23/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import UIKit
import YouTubePlayer
import AFNetworking

class ViewController: UIViewController {

    
    
    var videoPlayer = YouTubePlayerView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let playerFrame = CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height - 60)
        var videoPlayer = YouTubePlayerView( frame: playerFrame)
        
        let fightSongURL = NSURL(string: "https://www.youtube.com/watch?v=o9lQwhE7iI0")
        
        videoPlayer.loadVideoURL(fightSongURL!)
        
        self.view.addSubview(videoPlayer)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        var names = [String]()
        var startTimes = [NSDate]()
        
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer.setValue("Bearer LGGNOVP3JBBZWDW3LUZ5", forHTTPHeaderField: "Authorization")
        manager.GET(
            
            "https://www.eventbriteapi.com/v3/users/me/owned_events/",
           
            
            parameters: nil,
            
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                
                if let events = responseObject["events"] as? [[String: AnyObject]] {
                    for event in events {
                        if let name = event["name"] as? [String: String] {
                            if let text = name["text"] {
                                names.append(text)
                            }
                        }
                        
                        if let start = event["start"] as? [String: String] {
                            if let localTime = start["local"] {
                                if let date = dateFormatter.dateFromString(localTime) {
                                 startTimes.append(date)
                                }
                            }
                        }
                    }
                    print(names)
                    print(startTimes)
                } else {
                    print("Names not found")
                }
                
                
            },
            
            
            failure: { (operation: AFHTTPRequestOperation?,
                error: NSError) in
                print("Error: " + error.localizedDescription)
                
            
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

