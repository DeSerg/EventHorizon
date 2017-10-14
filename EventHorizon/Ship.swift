//
//  Ship.swift
//  EventHorizon
//
//  Created by deserg on 03.10.2017.
//  Copyright © 2017 deserg. All rights reserved.
//

import Foundation
import SpriteKit

class Ship: SKSpriteNode {
    
    var mainWeapon: Weapon?
    var additionalWeapon: Weapon?
    
    var maxHp: Int?
    var currentHp: Int?
    
    var agility: Int?
    
    var armor: Int?
    
    init() {
        let texture = SKTexture(imageNamed: "spacecraft")
        let textureSize = texture.size()
        let size = CGSize(width: textureSize.width / 4, height: textureSize.height / 4)
        super.init(texture: texture, color: UIColor.clear, size: size)
        //super.zRotation = CGFloat(Double.pi) / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


