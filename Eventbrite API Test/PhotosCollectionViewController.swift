//
//  PhotosCollectionViewController.swift
//  Eventbrite API Test
//
//  Created by Zoe Sheill on 7/29/16.
//  Copyright © 2016 ClassroomM. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    /*private let barSize : CGFloat = 44.0
    
    //@IBOutlet var collectionView: UICollectionView!
  
    var store: PhotoStore!
    
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        store.fetchRecentPhotos(){
            (photosResult) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                switch photosResult {
                case let .Success(photos):
                    print("Successfully found \(photos.count) recent photos.")
                case let .Failure(error):
                    self.photoDataSource.photos.removeAll()
                    print("Error fetching recent photos: \(error)")
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), { self.collectionView.reloadSections(NSIndexSet(index: 0))
                    self.collectionView.reloadData()
                    print("@reloadSectionsinBlock")
                })
                
                print("@reloadSections")
            })
        }
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        
        print("@setcollectioncell1")
        store.fetchImageForPhoto(photo) { (result) in
            NSOperationQueue.mainQueue().addOperationWithBlock({
                
                print("@setcollectioncellblock")
                
                let photoIndex = self.photoDataSource.photos.indexOf(photo)!
                let photoIndexPath = NSIndexPath(forRow: photoIndex, inSection: 0)
                
                if let cell = self.collectionView.cellForItemAtIndexPath(photoIndexPath) as? PhotoCollectionViewCell {
                    
                    cell.updateWithImage(photo.image)
                }
            })
        }
    }
    
    override func viewWillLayoutSubviews() {
        let frame = self.view.frame
        self.collectionView.frame = CGRectMake(frame.origin.x, frame.origin.y + barSize, frame.size.width, frame.size.height - barSize)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowPhoto" {
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems()?.first {
                let photo = photoDataSource.photos[selectedIndexPath.row]
                
                let destinationVC = segue.destinationViewController as! PhotoInfoViewController
                destinationVC.photo = photo
                destinationVC.store = store
            }
        }
    }*/

    

}
