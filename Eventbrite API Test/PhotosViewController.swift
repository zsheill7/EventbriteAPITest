//
//  PhotosViewController.swift
//  Eventbrite API Test
//
//  Created by Zoe Sheill on 7/24/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {

    //private let barSize : CGFloat = 44.0
     @IBOutlet var collectionView: UICollectionView!
    
    let backView: UIView = UIView()
    
    
   
    var store: PhotoStore!
    
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        collectionView.addSubview(backView)
        
        store.fetchRecentPhotos(){
            (photosResult) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                switch photosResult {
                case let .Success(photos):
                    print("Successfully found \(photos.count) recent photos.")
                    self.photoDataSource.photos = photos
                    
                    dispatch_async(dispatch_get_main_queue(), { self.collectionView.reloadSections(NSIndexSet(index: 0))
                        self.collectionView.reloadData()
                      
                    })
                case let .Failure(error):
                    self.photoDataSource.photos.removeAll()
                    print("Error fetching recent photos: \(error)")
                    
                }
                
                
                
                
            })
        }
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        
        store.fetchImageForPhoto(photo) { (result) in
            NSOperationQueue.mainQueue().addOperationWithBlock({
                
              
                
                let photoIndex = self.photoDataSource.photos.indexOf(photo)!
                let photoIndexPath = NSIndexPath(forRow: photoIndex, inSection: 0)
                
                if let cell = self.collectionView.cellForItemAtIndexPath(photoIndexPath) as? PhotoCollectionViewCell {
                    
                    cell.updateWithImage(photo.image)
                }
            })
        }
    }
    
    
    
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1 
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowPhoto" {
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems()?.first {
                let photo = photoDataSource.photos[selectedIndexPath.row]
                
                let destinationNC = segue.destinationViewController as! UINavigationController
                let targetController = destinationNC.topViewController as! PhotoInfoViewController
                targetController.photo = photo
                targetController.store = store
            }
        }
    }
}
