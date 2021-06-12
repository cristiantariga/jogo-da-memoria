//
//  jogoDaMemoriaTests.swift
//  jogoDaMemoriaTests
//
//  Created by Cristian Amora Santos Tariga on 06/06/21.
//

import XCTest
@testable import jogoDaMemoria

class jogoDaMemoriaTests: XCTestCase {
    
    var tabuleiro: Tabuleiro!
    
    override func setUp() {
        tabuleiro = Tabuleiro()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_acertandoDuasCartasPares_deveIncrementarOsIndicesEncontrados() throws {
        
        tabuleiro.memorizarTentativa(tentativa: 1)
        tabuleiro.memorizarTentativa(tentativa: 2)
        
        XCTAssertEqual(tabuleiro.indicesEncontrados.count, 2)
    }
    
    func test_naoAcertandoDuasCartasPares_naoDeveIncrementarOsIndicesEncontrados() throws {

        tabuleiro.memorizarTentativa(tentativa: 1)
        tabuleiro.memorizarTentativa(tentativa: 3)
        
        XCTAssertEqual(tabuleiro.indicesEncontrados.count, 0)
    }
    
    func test_aposTresTentativas_asCartasPrecisamVirar() throws {

        tabuleiro.memorizarTentativa(tentativa: 6)
        tabuleiro.memorizarTentativa(tentativa: 3)
        tabuleiro.memorizarTentativa(tentativa: 8)
        
        XCTAssertTrue(tabuleiro.podeAbaixarCartas)
    }
    
    func test_aposTresTentativas_oNumeroDeTantativasDeveSerTres() throws {

        tabuleiro.memorizarTentativa(tentativa: 6)
        tabuleiro.memorizarTentativa(tentativa: 3)
        tabuleiro.memorizarTentativa(tentativa: 8)
        
        XCTAssertEqual(tabuleiro.numeroDeTentativas, 3)
    }
    
    func test_acertandoTodasAsCartas_deveDetectarVitoria() throws {

        tabuleiro.memorizarTentativa(tentativa: 1)
        tabuleiro.memorizarTentativa(tentativa: 2)
        tabuleiro.memorizarTentativa(tentativa: 3)
        tabuleiro.memorizarTentativa(tentativa: 4)
        tabuleiro.memorizarTentativa(tentativa: 5)
        tabuleiro.memorizarTentativa(tentativa: 6)
        tabuleiro.memorizarTentativa(tentativa: 7)
        tabuleiro.memorizarTentativa(tentativa: 8)
        tabuleiro.memorizarTentativa(tentativa: 9)
        tabuleiro.memorizarTentativa(tentativa: 10)
        
        XCTAssertTrue(tabuleiro.vitoria())
    }
    
    func test_naoAcertandoTodasAsCartas_naoDeveDetectarVitoria() throws {

        tabuleiro.memorizarTentativa(tentativa: 1)
        tabuleiro.memorizarTentativa(tentativa: 2)
        tabuleiro.memorizarTentativa(tentativa: 3)
        tabuleiro.memorizarTentativa(tentativa: 4)
        tabuleiro.memorizarTentativa(tentativa: 5)
        tabuleiro.memorizarTentativa(tentativa: 6)
        tabuleiro.memorizarTentativa(tentativa: 7)
        tabuleiro.memorizarTentativa(tentativa: 8)
        
        XCTAssertFalse(tabuleiro.vitoria())
    }
    
    func test_aCadaNovaInstancia_deveEmbaralharOsIndices() throws {

        let novoTabuleiro = Tabuleiro()
        
        XCTAssertTrue(novoTabuleiro.indicesEmbaralhados != tabuleiro.indicesEmbaralhados)
    }

}
