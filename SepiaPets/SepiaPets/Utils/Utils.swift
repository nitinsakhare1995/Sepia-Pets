//
//  Utils.swift
//  SepiaPets
//
//  Created by Nitin Sakhare on 06/03/23.
//

import Foundation
import UIKit

// MARK: Utils Class to access reusable functions

struct Utils {
    
    // Define a static function named "readLocalFile" that takes a parameter named "name" of type String and returns an optional Data object.
    static func readLocalFile(forName name: String) -> Data? {
        
        do {
            // Try to get the path of the file with the given name and type from the app's main bundle.
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               // If the path exists, try to read the file contents as a string and then encode them as UTF-8 data.
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                // If successful, return the data object.
                return jsonData
            }
        } catch {
            // If an error occurs, print it to the console.
            print(error)
        }
        
        // If the function has not yet returned, return nil.
        return nil
    }
    
    /**
     A static function that asynchronously loads an image from a given URL, displays a placeholder image until the requested image is loaded, and then sets the loaded image into the provided UIImageView object. If the URL is nil or the image cannot be loaded, the placeholder image is displayed instead.
     
     - Parameter url: The URL from which the image will be loaded.
     - Parameter placeholder: The UIImage object to be displayed as a placeholder image while the image is being loaded.
     - Parameter imageView: The UIImageView object into which the loaded image will be set.
     
     - Note: This function performs the image loading asynchronously, so it does not block the UI thread while the image is being loaded.
     */
    static func loadImage(from url: URL?, placeholder: UIImage?, into imageView: UIImageView) {
        // Set the placeholder image
        imageView.image = placeholder
        
        // Check for a valid URL
        guard let url = url else {
            return
        }
        
        // Create a URL session configuration
        let sessionConfig = URLSessionConfiguration.default
        
        // Create a URL session
        let session = URLSession(configuration: sessionConfig)
        
        // Create a data task with the image URL
        let task = session.dataTask(with: url) { (data, response, error) in
            // Check for errors
            guard error == nil else {
                print("Error loading image: \(error!)")
                return
            }
            
            // Check for valid image data
            guard let data = data else {
                print("No image data found")
                return
            }
            
            // Create the image from the data
            let image = UIImage(data: data)
            
            // Update the UI on the main thread
            DispatchQueue.main.async {
                // Set the image view with the loaded image
                imageView.image = image ?? placeholder
            }
        }
        
        // Start the data task
        task.resume()
    }
    
}
