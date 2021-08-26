//
//  SofaViewModel.swift
//  Cinemaa
//
//  Created by Клим on 26.08.2021.
//

import UIKit

protocol SofaViewModelProtocol {
    var sofaImage: UIImage { get }
    init(sofaImage: UIImage)
}

class SofaViewModel: SofaViewModelProtocol {
    var sofaImage: UIImage
    required init(sofaImage: UIImage) {
        self.sofaImage = sofaImage
    }
    
}
