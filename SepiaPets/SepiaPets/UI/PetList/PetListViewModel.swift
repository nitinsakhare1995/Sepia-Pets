//
//  PetListViewModel.swift
//  SepiaPets
//
//  Created by Nitin Sakhare on 06/03/23.
//

import Foundation

class PetListViewModel {
    
    private let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol = DataProvider()) {
        self.dataService = dataService
    }
    
    // This method fetches the list of pets from the data service
    func fetchPetsList() -> [Pet]? {
        guard let jsonData = self.dataService.fetchPetList() else { return nil }
        return parse(jsonData: jsonData)?.pets
    }
    
    // This method decodes the JSON data into a PetsModel object
    func parse(jsonData: Data) -> PetsModel? {
        do {
            let decodedData = try JSONDecoder().decode(PetsModel.self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error)")
            return nil
        }
    }
    
    // This method checks if it's currently working hours
    func checkWorkingHours() -> Bool {
        let calendar = Calendar.current
        let now = Date()
        
        let weekday = calendar.component(.weekday, from: now)
        let hour = calendar.component(.hour, from: now)
        
        // Check if it's a weekday and between 9 AM and 6 PM
        return weekday >= 2 && weekday <= 6 && hour >= 9 && hour < 18
    }
    
}
