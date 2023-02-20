//
//  String+RemoveCharacters.swift
//  Topuppin
//
//  Created by Giri Bahari on 20/02/23.
//

import Foundation

extension String {
    func stringByRemovingAll(characters: [Character]) -> String {
        return String(self.filter({ !characters.contains($0) }))
    }
}
