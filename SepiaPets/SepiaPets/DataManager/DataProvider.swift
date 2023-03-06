//
//  DataProvider.swift
//  SepiaPets
//
//  Created by Nitin Sakhare on 06/03/23.
//

import Foundation

// Define a protocol named "DataServiceProtocol" that requires a single function named "fetchPetList" that returns an optional Data object.
protocol DataServiceProtocol {
    func fetchPetList() -> Data?
}

// Define a class named "DataProvider" that conforms to the "DataServiceProtocol".
class DataProvider: DataServiceProtocol {
    
    // Define a static property named "shared" that is an instance of the "DataProvider" class.
    static let shared = DataProvider()
    
    // Implement the "fetchPetList" function required by the "DataServiceProtocol".
    func fetchPetList() -> Data? {
        
        // If the "readLocalFile" function from the "Utils" class successfully retrieves a "jsonData" object with the name "pets_list", return the data.
        if let jsonData = Utils.readLocalFile(forName: "pets_list") {
            return jsonData
        }
        
        // If the data could not be retrieved, return nil.
        return nil
    }
    
}

