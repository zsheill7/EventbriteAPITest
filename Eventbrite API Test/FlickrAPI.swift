//
//  FlickrAPI.swift
//  Eventbrite API Test
//
//  Created by Zoe Sheill on 7/24/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import Foundation

enum Method: String {
    case RecentPhotos = "flickr.photos.getRecent"
    //case GalleryPhotos = "flickr.galleries.get
    
}

enum PhotosResult {
    case Success([Photo])
    case Failure(ErrorType)
}

enum FlickrError: ErrorType {
    case InvalidJSONData
}

struct FlickrAPI {
    private static let baseURLString = /*"https://api.flickr.com/services/rest"*/ "https://api.flickr.com/services/rest/?method=flickr.galleries.getPhotos&api_key=b5a9a14b1529748d4c8e301b10ebb042&gallery_id=72157670380338171&format=rest&auth_token=72157671772406106-6be63959e28970c9&api_sig=e188a532033cff7c9fb29cfc7c132e98"
    
    
    private static let APIKey = /*"a6d819499131071f158fd740860a5a88"*/"2ec50c2435e7567b0f3d4ae7f9380a47"
    
    private static let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    
    private static func flickrURL(method method: Method, parameters: [String:String]?) -> NSURL {
        let components = NSURLComponents(string: baseURLString)!
        
        var queryItems = [NSURLQueryItem]()
        
        let baseParams = [
            "method": method.rawValue,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": APIKey
        ]
        
        for (key, value) in baseParams {
            let item = NSURLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = NSURLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        
        return components.URL!
    }

    static func recentPhotosURL() -> NSURL {
        
        /*if let photosURL = NSURL(string: baseURLString) {
            return photosURL//flickrURL(method: .RecentPhotos, parameters: ["extras": "url_h,date_taken"])
        }*/
         return flickrURL(method: .RecentPhotos, parameters: ["extras": "url_h,date_taken"])
        //if let australiaURL = NSURL(string: "https://www.flickr.com/photos/95526288@N06/sets/72157650847931154/")  {
            //return australiaURL
        //}
        
        //return flickrURL(method: .RecentPhotos, parameters: ["extras": "url_h,date_taken"])
    }
    
    static func getURL() -> NSURL{
        return NSURL(string: baseURLString)!
    }
    
    static func photosFromJSONData(data: NSData) -> PhotosResult {
        do {
            let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            
            guard let
                jsonDictionary = jsonObject as? [NSObject:AnyObject],
                photos = jsonDictionary["photos"] as? [String:AnyObject],
                photosArray = photos["photo"] as? [[String:AnyObject]] else {
                    
                    return .Failure(FlickrError.InvalidJSONData)
                    
            }
            
            var finalPhotos = [Photo]()
            
            for photoJSON in photosArray {
                if let photo = photoFromJSONObject(photoJSON) {
                    finalPhotos.append(photo)
                }
            }
            
            if finalPhotos.count == 0 && photosArray.count > 0 {
                return .Failure(FlickrError.InvalidJSONData)
            }
            return .Success(finalPhotos)
        }
        catch let error {
            return .Failure(error)
        }
    }
    
    private static func photoFromJSONObject(json: [String: AnyObject]) -> Photo? {
        guard let
            photoID = json["id"] as? String,
            title = json["title"] as? String,
            dateString = json["datetaken"] as? String,
            photoURLString = json["url_h"] as? String,
            url = NSURL(string: photoURLString),
            dateTaken = dateFormatter.dateFromString(dateString) else {
                
                return nil
        }
        
        return Photo(title: title, photoID: photoID, remoteURL: url, dateTaken: dateTaken)
        
    }
}





