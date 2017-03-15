//  Created by Виктор Заикин on 01.04.16.
//  Copyright © 2016 Виктор Заикин. All rights reserved.

import UIKit

public enum CollectionViewSupplementaryKind {
    case header
    case footer
}

public extension UICollectionView {
    public func reloadAnimated() {
        let sectionsNumber = self.numberOfSections
        let indexSet: NSMutableIndexSet = NSMutableIndexSet()
        for i in 0..<sectionsNumber {
            indexSet.add(i)
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.reloadSections(indexSet as IndexSet)
        }) 
    }
    
    public func deleteAnimated(atIndexPaths indexPaths: [IndexPath]) {
        UIView.animate(withDuration: 0.25, animations: {
            self.deleteItems(at: indexPaths)
        }) 
    }
    
    public func insertAnimated(atIndexPaths indexPaths: [IndexPath]) {
        UIView.animate(withDuration: 0.25, animations: {
            self.insertItems(at: indexPaths)
        }) 
    }
    
    public func reloadAnimated(atIndexPaths indexPaths: [IndexPath]) {
        UIView.animate(withDuration: 0.25, animations: { 
            self.reloadItems(at: indexPaths)
        }) 
    }
    
    public func deleteAnimated(atIndexSet indexSet: IndexSet) {
        UIView.animate(withDuration: 0.25, animations: {
            self.deleteSections(indexSet)
        })
    }
    
    public func insertAnimated(atIndexSet indexSet: IndexSet) {
        UIView.animate(withDuration: 0.25, animations: {
            self.insertSections(indexSet)
        })
    }
    
    public func reloadAnimated(atIndexSet indexSet: IndexSet) {
        UIView.animate(withDuration: 0.25, animations: {
            self.reloadSections(indexSet)
        })
    }
}
