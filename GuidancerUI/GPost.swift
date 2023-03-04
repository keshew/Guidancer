//
//  GPost.swift
//  Guidancer
//
//  Created by Vladimir Berezin on 26.11.22.
//

import Foundation
import UIKit

struct GPost {
    let name: String
    let descriptionOfPlace: String
    let image: UIImage?
    let whoAndWhenPost: String
    let profileUserImageView: UIImage?
    let likes: Int
    let comments: Int

}

#if DEBUG
extension GPost {
    static var mock: Self {
        .init(name: "Moscow Kremlin",
              descriptionOfPlace: "'Moscow Kremlin' is a fortified complex in the center of Moscow founded by the Rurik dynasty. It is the best known of the kremlins (Russian citadels), and includes five palaces, four cathedrals, and the enclosing Kremlin Wall with Kremlin towers. In addition, within this complex is the Grand Kremlin Palace that was formerly the Tsar's Moscow residence.",
              image: UIImage(named: "sight"),
              whoAndWhenPost: "Artyom Korotkov",
              profileUserImageView: UIImage(named: "sight"),
              likes: 8,
              comments: 8)
    }
}
#endif
