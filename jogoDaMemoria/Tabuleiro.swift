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
    
    func verificarCartasEncontradas() {
        
        let primeiraTentativa = self.tentativaAtual[0]
        let segundaTentativa = self.tentativaAtual[1]
        
        if(primeiraTentativa.carta == segundaTentativa.carta) {
            indicesEncontrados.append(primeiraTentativa)
            indicesEncontrados.append(segundaTentativa)
        }
        
        tentativaAtual = []
    }
}
