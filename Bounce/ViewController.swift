//
//  ViewController.swift
//  Bounce
//
//  Created by Tim Duckett on 03/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    var cvData = [String]()
    var layout: BounceLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        layout = BounceLayout()
        layout.itemSize = CGSizeMake(50, 50)
        self.collectionView.setCollectionViewLayout(layout, animated: false)
        
        setupData()
        setupCollectionView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {

    func setupData() {
        
        for index in 0...0 {
            cvData.append("\(index)")
        }
        
    }
    
    func setupCollectionView() {
        
        layout = BounceLayout()
        layout.itemSize = CGSizeMake(75,75)
        layout.sidePadding = 10
        
        collectionView.collectionViewLayout = layout
        
    }
    
    @IBAction func didTapAdd(sender: AnyObject) {

        // Get index of last item
        let index = cvData.count
        
        cvData.append("\(index)")

        // Create an NSIndexPath object for the new item
        let newItemIndexPath = NSIndexPath(forItem: index, inSection: 0)

        // Now update the collection view
        collectionView.insertItemsAtIndexPaths([newItemIndexPath])
    
    }

    @IBAction func didTapRemove(indexPath: NSIndexPath) {
        
        // Don't attempt to remove the last item!
        if cvData.count == 0 {
            return
        }
        
        // Remove it from the data array
        cvData.removeAtIndex(indexPath.row)
        
        // Now update the collection view
        collectionView.deleteItemsAtIndexPaths([indexPath])

    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cvData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cvCell", forIndexPath: indexPath)

        let cellLabel = cell.viewWithTag(1000) as! UILabel
        cellLabel.text = "Cell \(indexPath.row)"
        
        cell.contentView.layer.borderColor = UIColor.cyanColor().CGColor
        cell.contentView.layer.borderWidth = 1.0
        
        return cell
        
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
            
        case 0:
            didTapAdd(indexPath)
            
        default:
            didTapRemove(indexPath)
        }
        
    }
    
}