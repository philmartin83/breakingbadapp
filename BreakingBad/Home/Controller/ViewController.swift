//
//  ViewController.swift
//  BreakingBad
//
//  Created by Philip Martin on 26/06/2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private var dataSource = HomeTableViewDataSource()
    private var viewModel: HomeViewModel!
    private let segueIdentifier = "goToCharacterDetail"
    private let databaseManager = DatabaseManager.shared
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
    }
    
    private func setupMainView() {
        checkData()
        setupCells()
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        dataSource.tableViewUpdater = self
        navigationItem.title = "Breaking Bad"
    }
    
    private func checkData() {
        /*
         Check to see if we have characters in our database
         If we don't then use our viewModel to go fetch the data we will check again
         based on the response
         */
        let fetch = databaseManager.fetch(DBCharacter.self)
        if fetch.count == 0 {
            viewModel = HomeViewModel()
            viewModel.output = self
            viewModel.fetchCharacters()
        } else {
            dataSource.setData(characters: fetch)
            tableView.reloadData()
        }
    }

    private func setupCells() {
        let nib = UINib(nibName: CharacterTableViewCell.reuseidentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CharacterTableViewCell.reuseidentifier)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CharacterDetailViewController, let model = sender as? DBCharacter {
            dest.model = model
        }
    }
}

extension ViewController: HomeViewModelOutput {
    func contentRecieved(model: [Character]) {
        // from the response we store the data
        model.forEach({$0.store()})
        checkData()
    }
    
    func requestFailed(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}

extension ViewController: HomeTableViewInteractionDelegate {
    func pushViewController(character: DBCharacter?) {
        self.performSegue(withIdentifier: segueIdentifier, sender: character)
    }
}

