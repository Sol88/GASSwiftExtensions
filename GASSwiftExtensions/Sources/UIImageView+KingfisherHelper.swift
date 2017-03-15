//  Created by Виктор Заикин on 20.10.16.
//  Copyright © 2016 Виктор Заикин. All rights reserved.

import UIKit
import Kingfisher

public typealias ImageCompletion = (UIImage?) -> Void

private let KFShared = KingfisherManager.shared

public extension UIImage {
    public static func getImage(urlString: String?, completion: ImageCompletion? = nil) {
        guard let urlString = urlString else { return }
        guard let url = URL(string: urlString) else { return }
        
        if let image = getCachedImage(url: urlString) {
            completion?(image)
        } else {
            KFShared.downloader.downloadImage(with: url, progressBlock: nil) { (image, error, imageURL, originalData) in
                completion?(image)
            }
        }
    }
    
    public static func getImage(url: String?, completion: ImageCompletion? = nil) {
        guard let url = url, let _url = URL(string: url) else {return}
        KFShared.downloader.downloadImage(with: _url, progressBlock: nil) { (image, error, imageURL, originalData) in
            completion?(image)
        }
    }
    
    public static func getCachedImage(url: String) -> UIImage? {
        var image = KFShared.cache.retrieveImageInDiskCache(forKey: url)
        if image == nil {
            image = KFShared.cache.retrieveImageInMemoryCache(forKey: url)
        }
        return image
    }
}

private var urlAssociatedKey: UInt = 1111
private var taskAssociatedKey: UInt = 1112

public extension UIImageView {
    
    private var url: URL? {
        get {
            return objc_getAssociatedObject(self, &urlAssociatedKey) as? URL
        }
        set {
            objc_setAssociatedObject(self, &urlAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var imageTask: RetrieveImageTask? {
        get {
            return objc_getAssociatedObject(self, &taskAssociatedKey) as? RetrieveImageTask
        }
        set {
            objc_setAssociatedObject(self, &taskAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func setImageAnimated(
        string: String?,
        placeholder: UIImage? = nil,
        time: TimeInterval = 0.25,
        animateCached: Bool = false,
        completion: ImageCompletion? = nil)
    {
        if let string = string {
            let url = URL(string: string)
            self.setImageAnimated(url: url, placeholder: placeholder, time: time, animateCached: animateCached, completion: completion)
        } else {
            shouldRasterize(false)
            self.image = placeholder
            shouldRasterize(true)
            completion?(nil)
        }
    }

    public func stopDownloading() {
        imageTask?.cancel()
    }
    
    public func setImageAnimated(
        url: URL?,
        placeholder: UIImage? = nil,
        time: TimeInterval = 0.25,
        animateCached: Bool = false,
        completion: ImageCompletion? = nil)
    {
        completion?(nil)
        DispatchQueue.main.async(execute: {
            self.image = placeholder
        })
        if let url = url {
            let shouldRasterizeValue = self.isRasterized
            self.url = url
            let resource = ImageResource(downloadURL: url)
            imageTask = KFShared
                .retrieveImage(with: resource,
                               options: nil,
                               progressBlock: nil,
                               completionHandler: { [weak self] (image, error, cacheType, imageURL) in
                                guard let strongSelf = self else {
                                    completion?(nil)
                                    return
                                }
                                guard strongSelf.url == imageURL else {
                                    completion?(nil)
                                    return
                                }
                                guard let image = image else {
                                    completion?(nil)
                                    return
                                }
                                strongSelf.imageTask = nil
                                strongSelf.shouldRasterize(false)
                                if cacheType == .none {
                                    strongSelf.setAnimate(image,
                                                          for: time,
                                                          shouldRasterize: shouldRasterizeValue,
                                                          completion: completion)
                                } else {
                                    if animateCached {
                                        strongSelf.setAnimate(image,
                                                              for: time,
                                                              shouldRasterize: shouldRasterizeValue,
                                                              completion: completion)
                                    }
                                    else {
                                        strongSelf.set(image,
                                                       shouldRasterize: shouldRasterizeValue,
                                                       completion: completion)
                                    }
                                }
                })
        } else {
            DispatchQueue.main.async(execute: {
                completion?(nil)
            })
        }
    }
    
    private func setAnimate(_ image: UIImage, for time: TimeInterval, shouldRasterize: Bool, completion: ImageCompletion?) {
        DispatchQueue.main.async {
            UIView.transition(with: self,
                              duration: time,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.image = image
            },
                              completion: { [weak self] (completed) in
                                guard let strongSelf = self else { return }
                                if completed {
                                    strongSelf.url = nil
                                    strongSelf.shouldRasterize(shouldRasterize)
                                    DispatchQueue.main.async {
                                        completion?(image)
                                    }
                                }
            })
        }
    }
    
    private func set(_ image: UIImage, shouldRasterize: Bool, completion: ImageCompletion?) {
        DispatchQueue.main.async {
            self.image = image
            self.shouldRasterize(shouldRasterize)
            completion?(image)
        }
        self.url = nil
    }
    
}

