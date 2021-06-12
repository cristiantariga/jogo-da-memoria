//
//  ViewController.swift
//  jogoDaMemoria
//
//  Created by Cristian Amora Santos Tariga on 06/06/21.
//

import UIKit

class JogoDaMemoriaViewController: UIViewController {
    
    var tabuleiro = Tabuleiro()

    override func viewDidLoad() {
        super.viewDidLoad()
        inicializarCartasViradasParaBaixo()
    }

    @IBOutlet public var TodasAsCartas: [UIButton]!
    
    @IBAction func ReiniciarButtonView(_ sender: Any) {
        reiniciar()
    }
    
    @IBAction func ToqueNaCarta(_ sender: UIButton) {
        if let identificador = sender.accessibilityIdentifier {
            
            let tentativaAtualNaoDuplicada = !tabuleiro.tentativaAtual.contains(Int(identificador)!)
            let tentativaAtualAindaNaoAcertada = !tabuleiro.indicesEncontrados.contains(Int(identificador)!)
            
            if( tentativaAtualNaoDuplicada && tentativaAtualAindaNaoAcertada) {
                sender.setImage(
                    UIImage(named: sender.storedImage!), for: .normal
                )
                tabuleiro.memorizarTentativa(tentativa: Int(identificador)!)
                recarregarCartas(cartaAtual: identificador)
            }
        }
    }
    
    func reiniciar() {
        tabuleiro = Tabuleiro()
        inicializarCartasViradasParaBaixo()
    }
    
    func recarregarCartas(cartaAtual: String) {
        TodasAsCartas.forEach { carta in
            if let identificador = carta.accessibilityIdentifier {
                
                let indiceAindaNaoEncontrado = !self.tabuleiro.indicesEncontrados.contains(Int(identificador)!)
                
                if(indiceAindaNaoEncontrado && self.tabuleiro.podeAbaixarCartas) {
                    if(carta.accessibilityIdentifier != cartaAtual) {
                        carta.setImage(UIImage(named: 0.carta), for: .normal)
                    }
                }
            }
        }
        
        if(self.tabuleiro.vitoria()) {
            notificarVitoria()
        }
    }
    
   
    func inicializarCartasViradasParaBaixo() {
        TodasAsCartas.forEach { carta in
            if(!tabuleiro.indicesEmbaralhados.isEmpty) {
                
                let identificador = tabuleiro.indicesEmbaralhados.removeLast()

                carta.storedImage = identificador.carta
                carta.accessibilityIdentifier = String(identificador)
                carta.setImage(UIImage(named: 0.carta), for: .normal)
            }
        }
    }
    
    func notificarVitoria() {
        let numeroDeTentativas = self.tabuleiro.numeroDeTentativas / 2
        
        let alerta = UIAlertController(
            title: "Boa, você terminou!",
            message: "Você precisou de \(numeroDeTentativas) tentativas para finalizar o jogo da memória",
            preferredStyle: .alert
        )
        
        alerta.addAction(
            UIAlertAction(
                title: "Bacana, bora de novo",
                style: .cancel,
                handler: {
                    _ in self.reiniciar()
                }
            )
        )
        present(alerta, animated:  true)
    }
}

extension UIButton {
    private struct AssociatedKeys {
        static var storedImage = ""
    }

    @IBInspectable var storedImage: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.storedImage) as? String
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.storedImage,
                    newValue as NSString?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
}
