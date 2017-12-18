//
//  Ship.swift
//  EventHorizon
//
//  Created by deserg on 03.10.2017.
//  Copyright © 2017 deserg. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Ship: SKSpriteNode {
    
    var mainWeapon: Weapon?
    var additionalWeapon: Weapon?
    
    var maxHp: Int?
    var currentHp: Int?
    
    var shipSpeedPerSec: CGFloat? // pix per second
    
    var armor: Int?
    
    var destination: CGPoint?
    
    init() {
        
        let texture = SKTexture(imageNamed: "spacecraft")
        let textureSize = texture.size()
        let size = CGSize(width: textureSize.width / 4, height: textureSize.height / 4)
        super.init(texture: texture, color: UIColor.clear, size: size)
        
        physicsBody = SKPhysicsBody(texture: texture, size: textureSize)
        physicsBody?.isDynamic = false
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        //super.zRotation = CGFloat(Double.pi) / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDestination(destination: CGPoint) {
        self.destination = destination
    }
    
    func shoot(to point: CGPoint) {
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.physicsBody = SKPhysicsBody(texture: bullet.texture!, size: bullet.size)
        bullet.physicsBody?.isDynamic = false
        
        bullet.position = CGPoint(x: position.x, y: position.y + size.height / 2)
        bullet.zPosition = zPosition - 10
        scene?.addChild(bullet)
        
        bullet.run(SKAction.sequence([ SKAction.move(to: point, duration: 3), SKAction.run {bullet.removeFromParent()} ]))
    }
    
    func onFly(_ dt: TimeInterval) {
        
        guard let destination = self.destination else {
            return
        }
        
        guard let shipSpeedPerSec = self.shipSpeedPerSec else {
            return
        }
        
        let shipNeedsToMove = shipSpeedPerSec * CGFloat(dt)
        
        let shipCurrentPosition = position
        let needToMoveDistance: CGFloat = min(shipNeedsToMove, abs(destination.y - shipCurrentPosition.y))
        let needToMoveDirection: CGFloat = destination.y > self.position.y ? 1 : -1
        
        if needToMoveDistance != 0 {
            self.position = CGPoint(x: position.x, y: position.y + needToMoveDistance * needToMoveDirection)
//            position.y += needToMoveDistance * needToMoveDirection
        }
        
//        let needToMoveVector = CGVector(dx: 0, dy: needToMoveDistance * needToMoveDirection)
//        run(SKAction.moveBy()
    }
}


