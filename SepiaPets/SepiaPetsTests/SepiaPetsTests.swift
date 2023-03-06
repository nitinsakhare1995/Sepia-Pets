//
//  SepiaPetsTests.swift
//  SepiaPetsTests
//
//  Created by Nitin Sakhare on 06/03/23.
//

// Import XCTest framework for writing unit tests
import XCTest
// Import the app module to test its functionality
@testable import SepiaPets

// Declare a final class that inherits from XCTestCase to write unit tests
final class SepiaPetsTests: XCTestCase {
    
    // Define a test case that reads the JSON file containing pet data
    func testReadJSONFile() {
        // Get the bundle for the current test class
        let bundle = Bundle(for: type(of: self))
        // Get the URL of the JSON file to test, or fail if it's missing
        guard let url = bundle.url(forResource: "pets_list", withExtension: "json") else {
            XCTFail("Missing file: pets_list.json")
            return
        }
        
        do {
            // Read the JSON data from the file
            let jsonData = try Data(contentsOf: url)
            // Parse the JSON data
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
            // Check that the parsed JSON is not nil and is of type [String: Any]
            XCTAssertNotNil(json)
            XCTAssertTrue(json is [String: Any])
        } catch {
            // Fail the test if there's an error while reading or parsing the JSON file
            XCTFail("Failed to read or parse JSON file: \(error.localizedDescription)")
        }
    }
    
}

