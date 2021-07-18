//
//  LineData.swift
//  ListLab
//
//  Created by Goncalo Palaio on 18/07/2021.
//

import Foundation

class LineData: Decodable {
    enum CodingKeys: String, CodingKey {
        case evt, content, id, color
    }
    
    let evt: String
    let content: String
    let id: Int
    let color: String?
    
    // runtime data - should be moved into a different struct
    var highlighted: Bool = false
}
