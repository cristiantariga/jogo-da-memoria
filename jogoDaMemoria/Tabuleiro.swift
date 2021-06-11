//
//  Carta.swift
//  jogoDaMemoria
//
//  Created by Cristian Amora Santos Tariga on 06/06/21.
//

import Foundation

class Tabuleiro {
    public var indicesEmbaralhados = [1,2,3,4,5,6,7,8,9,10].shuffled()
    public var indicesEncontrados: [Int] = []
    private(set) var tentativaAtual: [Int] = []
    private(set) var numeroDeTentativas = 0
    private(set) var podeAbaixarCartas: Bool = false
    
    func memorizarTentativa(tentativa: Int) {
        numeroDeTentativas += 1
        tentativaAtual.append(tentativa)
        
        self.podeAbaixarCartas = false
        
        if(tentativaAtual.count == 2) {
            verificarCartasEncontradas()
            return
        }
        guard tentativaAtual.count != 1 else {
            self.podeAbaixarCartas = true
            return
        }
    }
    
    public enum Cartas: String {
        case bruxa = "CardBruxa"
        case anao = "CardAnao"
        case cavaleiro = "CardCavaleiro"
        case mago = "CardMago"
        case elfa = "CardElfa"
    }
    
    func definirImagem(identificador: Int) -> String {
        switch identificador {
        case 1, 2:
            return Cartas.bruxa.rawValue
        case 3, 4:
           return Cartas.anao.rawValue
        case 5, 6:
           return Cartas.cavaleiro.rawValue
        case 7, 8:
           return Cartas.mago.rawValue
        default:
            return Cartas.elfa.rawValue
        }
    }
    
    func verificarCartasEncontradas() {
        
        let primeiraTentativa = self.tentativaAtual[0]
        let segundaTentativa = self.tentativaAtual[1]
           
        let imagemPrimeiraTentativa = definirImagem(identificador: primeiraTentativa)
        let imagemSegundaTentativa = definirImagem(identificador: segundaTentativa)
        
        if(imagemPrimeiraTentativa == imagemSegundaTentativa) {
            indicesEncontrados.append(primeiraTentativa)
            indicesEncontrados.append(segundaTentativa)
        }
        
        tentativaAtual = []
    }
}
