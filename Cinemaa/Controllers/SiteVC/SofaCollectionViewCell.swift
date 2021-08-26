//
//  SofaCollectionViewCell.swift
//  Cinemaa
//
//  Created by Клим on 26.08.2021.
//

import UIKit

class SofaCollectionViewCell: UICollectionViewCell {
    
    var viewModel: SofaViewModelProtocol! {
        didSet {
            sofaImage.image = viewModel.sofaImage
        }
    }
    
    @IBOutlet var sofaImage: UIImageView!
}
