//
//  CharacterTableViewCell.swift
//  BreakingBad
//
//  Created by Philip Martin on 26/06/2022.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    // MARK: - Reuseidentifier
    static let reuseidentifier = "CharacterTableViewCell"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    // MARK: - Helpers
    
    override func awakeFromNib() {
        super.awakeFromNib()
        characterImageView.layer.cornerRadius = 70/2
        characterImageView.layer.shouldRasterize = true
        characterImageView.layer.rasterizationScale = UIScreen.main.scale
        accessoryType = .disclosureIndicator
    }
    
    func populate(charcter: Character?) {
        characterNameLabel.text = charcter?.name
        Task{
            await characterImageView?.loadImageUsingCache(withUrl:charcter?.img ?? "")
        }
    }
}
