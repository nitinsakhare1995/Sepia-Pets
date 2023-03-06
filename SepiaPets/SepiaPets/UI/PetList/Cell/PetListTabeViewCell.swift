//
//  PetListTabeViewCell.swift
//  SepiaPets
//
//  Created by Nitin Sakhare on 06/03/23.
//

import UIKit

// This is a custom UITableViewCell class that has two IBOutlets: a UILabel named "lblPetName" and a UIImageView named "imgPet".
class PetListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPetName: UILabel!
    @IBOutlet weak var imgPet: UIImageView!
    
    // This function is called when the cell is first loaded from the storyboard.
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure the cell
        self.lblPetName.numberOfLines = 0  // Allow the label to have multiple lines
    }
    
    // This function sets the data for the cell.
    func configurePetListCell(petData: Pet?) {
        // Set the text for the pet name label
        lblPetName.text = petData?.title
        lblPetName.accessibilityLabel = petData?.title // Set accessibility label for voiceover support
        
        // If an image URL exists in the data, attempt to load the image from that URL
        if let imageURL = petData?.imageURL {
            // Create a URL from the image URL string
            let imageUrl = URL(string: imageURL)
            
            // Set the placeholder image
            let placeholderImage = UIImage(named: "placeholderImage")
            
            // Load the image from the URL with the placeholder image
            Utils.loadImage(from: imageUrl, placeholder: placeholderImage, into: self.imgPet)
        }
    }
}

