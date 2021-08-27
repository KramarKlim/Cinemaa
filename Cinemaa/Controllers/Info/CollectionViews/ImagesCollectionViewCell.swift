//
//  ImagesCollectionViewCell.swift
//  Cinemaa
//
//  Created by Клим on 26.08.2021.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
    
    var modelView: ImagesModelViewProtocol! {
        didSet {
            DispatchQueue.main.async {
                self.filmImages.fetchImage(from: self.modelView.imagesString)
            }
        }
    }
    
    @IBOutlet var filmImages: UIImageView!
}
