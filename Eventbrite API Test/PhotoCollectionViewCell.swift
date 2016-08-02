//
//  PhotoCollectionViewCell.swift
//  Eventbrite API Test
//
//  Created by Zoe Sheill on 7/25/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    func updateWithImage(image: UIImage?) {
        if let imageToDisplay = image {
            activityIndicator.stopAnimating()
            imageView.image = imageToDisplay
        } else {
            activityIndicator.startAnimating()
            imageView.image = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateWithImage(nil)
    }
}
