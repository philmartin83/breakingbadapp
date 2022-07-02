//
//  CharacterEndpoint.swift
//  BreakingBad
//
//  Created by Philip Martin on 26/06/2022.
//

import Foundation

enum CharacterEndpoint {
    case getAllCharacters
}

extension CharacterEndpoint: Endpoint {
    
    var path: String {
        switch self {
        case.getAllCharacters:
            return "characters"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getAllCharacters:
            return .get
        }
    }

    var header: [String: String]? {
        switch self {
        case .getAllCharacters:
            return nil
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .getAllCharacters:
            return nil
        }
    }
}
