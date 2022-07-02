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
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
    }
    
    private func setupMainView() {
        viewModel = HomeViewModel()
        viewModel.output = self
        viewModel.fetchCharacters()
        setupCells()
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        dataSource.tableViewUpdater = self
        navigationItem.title = "Breaking Bad"
    }

    private func setupCells() {
        let nib = UINib(nibName: CharacterTableViewCell.reuseidentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CharacterTableViewCell.reuseidentifier)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CharacterDetailViewController, let model = sender as? Character {
            dest.model = model
        }
    }
}

extension ViewController: HomeViewModelOutput {
    func contentRecieved(model: [Character]) {
        dataSource.setData(characters: model)
        tableView.reloadData()
    }
    
    func requestFailed(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}

extension ViewController: HomeTableViewInteractionDelegate {
    func pushViewController(character: Character?) {
        self.performSegue(withIdentifier: segueIdentifier, sender: character)
    }
}

