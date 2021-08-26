//
//  extension Array.swift
//  Cinemaa
//
//  Created by Клим on 26.08.2021.
//

import Foundation

extension Array {
    var toPrint: String  {
        var str = ""
        for element in self {
            str += "\(element), "
        }
        return str
    }
}
