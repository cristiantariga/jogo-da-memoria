//
//  Int+Carta.swift
//  jogoDaMemoria
//
//  Created by Cristian Amora Santos Tariga on 11/06/21.
//

import Foundation

extension Int {
    var carta: String {
        switch self {
        case 0:
            return "Card"
        case 1, 2:
            return "CardBruxa"
        case 3, 4:
           return "CardAnao"
        case 5, 6:
           return "CardCavaleiro"
        case 7, 8:
           return "CardMago"
        default:
            return "CardElfa"
        }
    }
}
