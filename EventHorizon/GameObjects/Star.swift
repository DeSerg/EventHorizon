//
//  Star.swift
//  EventHorizon
//
//  Created by deserg on 10.12.2017.
//  Copyright © 2017 deserg. All rights reserved.
//

import SpriteKit
import GameplayKit
import SpriteKit
import UIKit

class Star: SKSpriteNode {
    let starSize: CGFloat = 20
    
    init(imagedNamed imageName: String, parent: SKNode, coef: CGFloat = 1, inOrigin: Bool = true) {
//        super.init(imageNamed: imageName)
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: UIColor.black, size: texture.size())
        name = "star"
        size = CGSize(width: starSize * coef, height: starSize * coef)
        zRotation = CGFloat.random(min: 0, max: CGFloat(Double.pi))
        zPosition = 40
        
        if inOrigin {
            position.y = PlayableRect.height + size.height / 2
            let starMinX = PlayableRect.minX - size.width / 2
            let starMaxX = PlayableRect.maxX + size.width / 2
            position.x = CGFloat.random(min: starMinX, max: starMaxX)
        } else {
            position = EventHorizon.instance.helper.randomPoint()
        }
        
        let starScale = EventHorizon.instance.helper.scaleFor(yCoord: position.y)
        setScale(starScale)
        
        parent.addChild(self)
        EventHorizon.instance.addObject(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func spawn() {
        
    }
    
}

