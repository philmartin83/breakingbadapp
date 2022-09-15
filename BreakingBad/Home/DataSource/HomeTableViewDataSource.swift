//
//  HomeTableViewDataSource.swift
//  BreakingBad
//
//  Created by Philip Martin on 26/06/2022.
//

import Foundation
import UIKit

protocol HomeTableViewInteractionDelegate: AnyObject {
    func pushViewController(character: DBCharacter?)
}

class HomeTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    private var characters: [DBCharacter]?
    weak var tableViewUpdater: HomeTableViewInteractionDelegate?
    
    // MARK: - Helpers
    func setData(characters: [DBCharacter]) {
        self.characters = characters
    }
    
    // MARK: - Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = characters?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.reuseidentifier, for: indexPath) as! CharacterTableViewCell
        cell.populate(charcter: character)
        return cell
    }
    
    // MARK: - Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let character = characters?[indexPath.row]
        tableViewUpdater?.pushViewController(character: character)
    }
}
