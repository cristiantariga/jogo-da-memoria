//
//  Carta.swift
//  jogoDaMemoria
//
//  Created by Cristian Amora Santos Tariga on 07/06/21.
//

import Foundation

class Carta {
    let identificador: Int
    var imagem: String = ""
    
    init(identificador: Int) {
        self.identificador = identificador
        self.imagem = self.definirImagem(identificador: identificador)
    }
    
    func definirImagem(identificador: Int) -> String {
        switch identificador {
        case 1, 2:
           return "CardAnao"
        case 3, 4:
           return "CardCavaleiro"
        case 5, 6:
           return "CardElfa"
        case 7, 8:
           return "CardMago"
        default:
            return "CardBruxa"
        }
    }
    
    func verificarCartaCombinada(carta: Carta) -> Bool {
        let identificadorConvertido = carta.identificador
        let identificadorDaCartaEPar = identificadorConvertido / 2 == 0
        
        if(identificadorDaCartaEPar) {
           // return carta.identificador == identificadorConvertido - 1
        }
        
        // return carta.identificador == identificadorConvertido + 1
        return false
    }
}
