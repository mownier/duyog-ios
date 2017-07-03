//
//  PhotoPageController.swift
//  Duyog
//
//  Created by Mounir Ybanez on 01/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol PhotoPageControllerDataSource: class {
    
    func photoPageControllerPhotoCount(_ controller: PhotoPageController) -> Int
    func photoPageController(_ controller: PhotoPageController, assetFor index: Int) -> PhotoPageAsset
}

protocol PhotoPageControllerDelegate: class {
    
    func photoPageController(_ controller: PhotoPageController, configure imageView: UIImageView)
    func photoPageController(_ controller: PhotoPageController, didChoose index: Int)
    func photoPageController(_ controller: PhotoPageController, computePageSizeRelativeTo referenceSize: CGSize) -> CGSize
    func photoPageController(_ controller: PhotoPageController, computeLineSpacingRelativeTo horizontalEdgeInset: CGFloat) -> CGFloat
}

extension PhotoPageControllerDelegate {
    
    func photoPageController(_ controller: PhotoPageController, didChoose index: Int) { }
    
    func photoPageController(_ controller: PhotoPageController, computePageSizeRelativeTo referenceSize: CGSize) -> CGSize {
        var size = CGSize.zero
        size.width = min(referenceSize.width, referenceSize.height)
        size.height = size.width
        return size
    }
    
    func photoPageController(_ controller: PhotoPageController, computeLineSpacingRelativeTo horizontalEdgeInset: CGFloat) -> CGFloat {
        return horizontalEdgeInset * 0.2
    }
}

class PhotoPageController: UIViewController {
    
    var collectionView: UICollectionView!
    var flowLayout: UICollectionViewFlowLayout!

    weak var dataSource: PhotoPageControllerDataSource!
    weak var delegate: PhotoPageControllerDelegate!
    
    override func loadView() {
        super.loadView()
        
        flowLayout = CenterCellCollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        
        PhotoPageCell.register(in: collectionView)
        
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        var rect = CGRect.zero
        
        rect.size = view.frame.size
        collectionView.frame = rect
        
        flowLayout.itemSize = delegate.photoPageController(self, computePageSizeRelativeTo: rect.size)
        
        // Reference [1]
        var insets = collectionView.contentInset
        let horizonalEdgeInset = (collectionView.frame.width - flowLayout.itemSize.width) * 0.5
        insets.left = horizonalEdgeInset
        insets.right = horizonalEdgeInset
        collectionView.contentInset = insets
        
        flowLayout.minimumLineSpacing = delegate.photoPageController(self, computeLineSpacingRelativeTo: horizonalEdgeInset)
        
        collectionView.reloadData()
    }
}

extension PhotoPageController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.photoPageControllerPhotoCount(self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = PhotoPageCell.dequeue(from: collectionView, at: indexPath)
        cell.configure(dataSource.photoPageController(self, assetFor: indexPath.row))
        delegate.photoPageController(self, configure: cell.imageView)
        return cell
    }
}

extension PhotoPageController: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let point = CGPoint(
            x: scrollView.center.x + scrollView.contentOffset.x,
            y: scrollView.center.y + scrollView.contentOffset.y
        )
        let indexPath = collectionView.indexPathForItem(at: point)
        
        guard indexPath != nil else { return }
        
        delegate.photoPageController(self, didChoose: indexPath!.row)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !decelerate else { return }
        
        scrollViewDidEndDecelerating(scrollView)
    }
}

class PhotoPageCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetup()
    }
    
    func initSetup() {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        var rect = CGRect.zero
        
        rect.size = frame.size
        imageView.frame = rect
    }
}

extension PhotoPageCell: CollectionViewReusableProtocol {
    
    typealias Cell = PhotoPageCell
}

enum PhotoPageAsset {
    
    case bundle(String)
    case remote(String)
    case local(String)
    case image(UIImage?)
}

protocol PhotoPageConfig {
    
    func configure(_ asset: PhotoPageAsset)
}

extension PhotoPageCell: PhotoPageConfig {
    
    func configure(_ asset: PhotoPageAsset) {
        switch asset {
        case .image(let image):
            imageView.image = image
            
        case .bundle(let imageName):
            imageView.image = UIImage(named: imageName)
            
        default:
            break
        }
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}

// Reference [1]
class CenterCellCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var mostRecentOffset : CGPoint = CGPoint()
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        if velocity.x == 0 {
            return mostRecentOffset
        }
        
        if let cv = self.collectionView {
            let cvBounds = cv.bounds
            let halfWidth = cvBounds.size.width * 0.5;
            
            if let attributesForVisibleCells = self.layoutAttributesForElements(in: cvBounds) {
                var candidateAttributes : UICollectionViewLayoutAttributes?
                for attributes in attributesForVisibleCells {
                    // == Skip comparison with non-cell items (headers and footers) == //
                    if attributes.representedElementCategory != UICollectionElementCategory.cell {
                        continue
                    }
                    
                    if (attributes.center.x == 0) || (attributes.center.x > (cv.contentOffset.x + halfWidth) && velocity.x < 0) {
                        continue
                    }
                    candidateAttributes = attributes
                }
                
                // Beautification step , I don't know why it works!
                if(proposedContentOffset.x == -(cv.contentInset.left)) {
                    return proposedContentOffset
                }
                
                guard let _ = candidateAttributes else {
                    return mostRecentOffset
                }
                
                mostRecentOffset = CGPoint(x: floor(candidateAttributes!.center.x - halfWidth), y: proposedContentOffset.y)
                return mostRecentOffset
            }
        }
        
        // fallback
        mostRecentOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        return mostRecentOffset
    }
}

// Reference
// [1] http://blog.karmadust.com/centered-paging-with-preview-cells-on-uicollectionview/
