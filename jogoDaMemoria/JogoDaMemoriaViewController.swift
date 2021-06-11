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
    
    func reiniciar() {
        tabuleiro = Tabuleiro()
        inicializarCartasViradasParaBaixo()
    }
    
    
    func recarregarCartas(cartaAtual: String) {
        TodasAsCartas.forEach { carta in
            if let indentificador = carta.accessibilityIdentifier {
                
                let indiceAindaNaoEncontrado = !self.tabuleiro.indicesEncontrados.contains(Int(indentificador)!)
                
                if(indiceAindaNaoEncontrado && self.tabuleiro.podeAbaixarCartas) {
                    if(carta.accessibilityIdentifier != cartaAtual) {
                        carta.setImage(UIImage(named: "Card"), for: .normal)
                    }
                }
            }
        }
        
        if(self.tabuleiro.indicesEncontrados.count >= 10) {
            notificarVitoria()
        }
    }
    
    @IBAction func ReiniciarButtonView(_ sender: Any) {
        reiniciar()
    }
    
    @IBAction func ToqueNaCarta(_ sender: UIButton) {
        if let indentificador = sender.accessibilityIdentifier {
            
            let tentativaAtualNaoDuplicada = !tabuleiro.tentativaAtual.contains(Int(indentificador)!)
            let tentativaAtualAindaNaoAcertada = !tabuleiro.indicesEncontrados.contains(Int(indentificador)!)
            
            if( tentativaAtualNaoDuplicada && tentativaAtualAindaNaoAcertada){
                sender.setImage(
                    UIImage(named: sender.guardImage!), for: .normal
                )
                tabuleiro.memorizarTentativa(tentativa: Int(indentificador)!)
                recarregarCartas(cartaAtual: indentificador)
            }
            
        }
    }

    func inicializarCartasViradasParaBaixo() {
        TodasAsCartas.forEach { carta in
            if(!tabuleiro.indicesEmbaralhados.isEmpty) {
                
                let identificador = tabuleiro.indicesEmbaralhados.removeLast()

                carta.guardImage = tabuleiro.definirImagem(identificador: identificador)
                carta.accessibilityIdentifier = String(identificador)
                carta.setImage(UIImage(named: "Card"), for: .normal)
            }
        }
    }
    
    func notificarVitoria() {
        let alerta = UIAlertController(
            title: "Boa, você terminou!",
            message: "Você precisou de \(self.tabuleiro.numeroDeTentativas / 2) tentativas para finalizar o jogo da memória",
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
        static var guardImage = ""
    }

    @IBInspectable var guardImage: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.guardImage) as? String
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.guardImage,
                    newValue as NSString?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
}
