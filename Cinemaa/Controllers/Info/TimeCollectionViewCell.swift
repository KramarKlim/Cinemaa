//
//  TimeCollectionViewCell.swift
//  Cinemaa
//
//  Created by Клим on 26.08.2021.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    
    var viewModel: TimeViewModelProtocol! {
        didSet {
            timeLabel.layer.masksToBounds = true
            timeLabel.layer.cornerRadius = 10
            timeLabel.text = viewModel.time
            costLabel.text = viewModel.cost
        }
    }
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var costLabel: UILabel!
    
    
}
