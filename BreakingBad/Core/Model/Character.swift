//
//  Character.swift
//  BreakingBad
//
//  Created by Philip Martin on 26/06/2022.
//

import Foundation

struct Character: Codable {
    let charId: Int64
    let name: String
    let birthday: String
    let occupation: [String]
    let img: String
    let status, nickname: String
    let appearance: [Int]
    let portrayed: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case charId = "char_id"
        case name, birthday, occupation, img, status, nickname, appearance, portrayed, category
    }
    
    static let databaseHandler = DatabaseManager()
    
    func store() {
        guard let user = Character.databaseHandler.add(DBCharacter.self) else {return}
        user.name = name
        user.charId = Int64(charId)
        user.img = img
        Character.databaseHandler.save()
    }
}
