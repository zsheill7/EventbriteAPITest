//
//  PhotoInfoViewController.swift
//  Eventbrite API Test
//
//  Created by Zoe Sheill on 7/25/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import UIKit
class PhotoInfoViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchImageForPhoto(photo) { (result) in
            switch result {
            case let .Success(image):
                NSOperationQueue.mainQueue().addOperationWithBlock() {
                    self.imageView.image = image
                }
            case let .Failure(error):
                print("Error fetching image for photo: \(error)")
            }
            
        }
    }
    
    

}
