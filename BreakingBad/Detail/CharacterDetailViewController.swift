//
//  CharacterDetailViewController.swift
//  BreakingBad
//
//  Created by Philip Martin on 26/06/2022.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    var model: DBCharacter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = model?.name
    }

}
