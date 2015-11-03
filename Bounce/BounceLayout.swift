//
//  BounceLayout.swift
//  Bounce
//
//  Created by Tim Duckett on 03/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class BounceLayout: UICollectionViewLayout {
    
    var attributesArray = [UICollectionViewLayoutAttributes]()
    
    var numberOfItems: Int!

    var itemSize: CGSize!
    var minimums: (cvMin: CGFloat, itemMin: CGFloat)!
    var radius: CGFloat!
    var radiusOffset: Double!
    
    // MARK: -
    // MARK: Main methods
    
    override func prepareLayout() {
        
        if collectionView!.frame.width > collectionView!.frame.height {
            // Collection view is wider than tall, use the height as the minimum
            minimums = (cvMin: collectionView!.frame.height, itemMin: itemSize.height)
        } else {
            // Collection view is taller than wide, use the width as the minimum
            minimums = (cvMin: collectionView!.frame.width, itemMin: itemSize.width)
            
        }
        
        // Adjust radius of circle to account for size of item
        radius = minimums.cvMin - (minimums.itemMin / 2)
        
        radiusOffset = (2 * M_PI) / Double(numberOfItems)
        
        
    }
    
    override func collectionViewContentSize() -> CGSize {
        return collectionView!.frame.size
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        // All elements will be in the rect, so can compute for them all
        return attributesArray
        
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesArray[indexPath.row]
    }
    

    // MARK: -
    // MARK: Animation functions

    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {

        // Get final attributes
        let attrs = self.layoutAttributesForItemAtIndexPath(itemIndexPath)
        
        // Override initial values - invisible, and in the middle
        attrs?.alpha = 0.0
        let size = collectionView!.frame.size
        attrs?.center = CGPointMake(size.width/2, size.height/2)
        
        return attrs
        
    }
    
    
    // MARK: -
    // MARK: Unused functions
    
    override func layoutAttributesForDecorationViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }
    
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }

}
