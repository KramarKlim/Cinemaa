//
//  FilmCollectionViewCell.swift
//  Cinemaa
//
//  Created by Клим on 26.08.2021.
//

import UIKit

class FilmCollectionViewCell: UICollectionViewCell {
    
    var viewModel: FilmViewModelProtocol! {
        didSet {
            titleLabel.text = viewModel.title
            filmImage.image = viewModel.image
        }
    }

    
    @IBOutlet var filmImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
}
