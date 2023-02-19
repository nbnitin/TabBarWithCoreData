//
//  GifDisplayCollectionViewCell.swift
//  CoreDataWithTabBar
//
//  Created by Nitin Bhatia on 16/02/23.
//

import UIKit

class GifDisplayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var imgFav : UIImageView!
    
    func configCell(_ url:String) {
        loader.startAnimating()
        img.downloaded(from: url, completionHandler: {status,data in
            if status {
                self.img.image = UIImage.gif(data: data!)
            }
            self.loader.stopAnimating()
        })
        if let isFav = DataBaseHandler.shared.searchData(imageId: url) {
            favouriteStatus(true)
        } else {
            favouriteStatus(false)
        }
    }
    
    func favouriteStatus(_ status:Bool) {
        if status {
            imgFav.image = UIImage(systemName: "star.fill")
        } else {
            imgFav.image = UIImage(systemName: "star")
        }
    }
}
