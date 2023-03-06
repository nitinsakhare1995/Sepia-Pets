//
//  ViewController.swift
//  SepiaPets
//
//  Created by Nitin Sakhare on 06/03/23.
//

import UIKit

// PetListVC displays a list of pets using a table view
class PetListVC: UIViewController {
    
    // The table view that displays the list of pets
    @IBOutlet weak var tableView: UITableView!
    
    // The view model responsible for fetching the pets list data
    let viewModel = PetListViewModel()
    
    // The list of pets to display in the table view
    var petsList = [Pet]()
    
    // Called after the view controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Configure the table view's row height
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 44.0 // or any value you prefer

        // Fetch the pets list data if it's currently working hours
        if viewModel.checkWorkingHours() {
            petsList = viewModel.fetchPetsList() ?? []
        }
    }
    
    // Called after the view controller's view is added to the view hierarchy
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Show an alert if it's currently not working hours
        if !viewModel.checkWorkingHours() {
            let alert = UIAlertController(title: "Not Working Hours", message: "Sorry, it's currently not working hours.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
}

// Adopt the UITableViewDataSource protocol to display the pets list in the table view
extension PetListVC: UITableViewDataSource {
    
    // Return the number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    // Configure each cell in the table view with a pet from the list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "petListCell", for: indexPath) as? PetListTableViewCell else {
            return UITableViewCell()
        }
        cell.configurePetListCell(petData: petsList[indexPath.row])
        return cell
    }
    
}

// Adopt the UITableViewDelegate protocol to handle selecting a pet from the list
extension PetListVC: UITableViewDelegate {
    
    // Push the pet detail view controller onto the navigation stack when a row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let petDetailVC = storyboard?.instantiateViewController(withIdentifier: "detail") as? PetDetailVC else {
            return
        }
        petDetailVC.contentUrl = petsList[indexPath.row].contentURL
        navigationController?.pushViewController(petDetailVC, animated: true)
    }
    
}
