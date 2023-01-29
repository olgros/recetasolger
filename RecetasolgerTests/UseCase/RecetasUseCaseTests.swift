//
//  RecetasUseCaseTests.swift
//  RecetasolgerTests
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import Foundation
import XCTest
import PromiseKit

@testable import Recetasolger

class RecetasUseCaseTests: XCTestCase {

    let repository: RecetasRepository = RecetasRepositoryMock2()
    var  useCase: RecetasUseCase?
    var expectation = XCTestExpectation(description: "RecetasUseCaseTests")
    
    let statusExpected = "OK"
        
    
    var nameResponse = ""
    var descriptionResponse = ""
    var ingredientesResponse = ""
    
    var recetasResponse = [Receta]()
    
    override func setUpWithError() throws {
        useCase = RecetasUseCaseImp(repository: repository)
        
        useCase?.delegate = self
        
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   
    
    func testGetRecetas() throws {
        let nameExpected = "receta1"
        let descriptionExpected = "description1"
        let ingredientesExpected = "ingredientes1"
        
        useCase?.getRecetas()
        
        wait(for: [expectation], timeout: Constants.timeOutTest)
        XCTAssertEqual(nameExpected, recetasResponse[0].name, "error nombre")
        XCTAssertEqual(descriptionExpected, recetasResponse[0].description, "error description")
        XCTAssertEqual(ingredientesExpected, recetasResponse[0].ingredientes, "error ingredientes")
        
    }
    
    func testSearchRecetas() throws {
        let nameExpected = "receta1"
        let descriptionExpected = "description1"
        let ingredientesExpected = "ingredientes1"
        
        let nameExpected2 = "receta2"
        let descriptionExpected2 = "description2"
        let ingredientesExpected2 = "ingredientes2"
        
        useCase?.searchRecetas(value: "")
        
        wait(for: [expectation], timeout: Constants.timeOutTest)
        XCTAssertEqual(nameExpected, recetasResponse[0].name, "error nombre")
        XCTAssertEqual(descriptionExpected, recetasResponse[0].description, "error description")
        XCTAssertEqual(ingredientesExpected, recetasResponse[0].ingredientes, "error ingredientes")
        
        XCTAssertEqual(nameExpected2, recetasResponse[1].name, "error nombre")
        XCTAssertEqual(descriptionExpected2, recetasResponse[1].description, "error description")
        XCTAssertEqual(ingredientesExpected2, recetasResponse[1].ingredientes, "error ingredientes")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension RecetasUseCaseTests: RecetasProtocol {
    func onSuccess(recetas: [Receta]) {
        recetasResponse = recetas
        expectation.fulfill()
    }
    
    func onError(title: String, message: String) {
        expectation.fulfill()
    }
    
}



class RecetasRepositoryMock2: RecetasRepository {
    func getRecetas() -> Promise<[Receta]> {
        return Promise { seal in
            var recetas = [Receta]()
            recetas.append(Receta(id: 1, name: "receta1", image: "url", description: "description1", ubication: Ubication(latitude: 0, longitude: 0), ingredientes: "ingredientes1"))
            seal.resolve(recetas, nil)
        }
    }
    
    func searchRecetas(value: String) -> Promise<[Receta]> {
        return Promise { seal in
            var recetas = [Receta]()
            recetas.append(Receta(id: 1, name: "receta1", image: "url", description: "description1", ubication: Ubication(latitude: 0, longitude: 0), ingredientes: "ingredientes1"))
            recetas.append(Receta(id: 2, name: "receta2", image: "url", description: "description2", ubication: Ubication(latitude: 0, longitude: 0), ingredientes: "ingredientes2"))
            
            seal.resolve(recetas, nil)
        }
    }
    
}

