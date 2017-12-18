//
//  Weapon.swift
//  EventHorizon
//
//  Created by deserg on 17.09.17.
//  Copyright © 2017 deserg. All rights reserved.
//

import Foundation
import SpriteKit

enum WeaponCategory {
    case main
    case additional
}

class Weapon {
    
    var weaponCategory: WeaponCategory
    var damage: Int
    var rechargeTime: Double
    
    var lastShoot: Double?
    
    init(_ weaponCategory: WeaponCategory, _ damage: Int, _ rechargeTime: Double) {
        self.weaponCategory = weaponCategory
        self.damage = damage
        self.rechargeTime = rechargeTime
    }
    
    func shoot(from pointA: CGPoint, by vector: CGVector, at node: SKNode) {
        
        if lastShoot != nil {
            let currentTime = Double(NSDate().timeIntervalSince1970)
            let timePassed = currentTime - lastShoot! 
            if timePassed <= rechargeTime {
                return
            }
        }
        
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.physicsBody = SKPhysicsBody(texture: bullet.texture!, size: bullet.size)
        bullet.physicsBody?.isDynamic = false
        
        bullet.position = pointA
        bullet.zPosition = 20
        node.addChild(bullet)
        
        bullet.run(SKAction.sequence([ SKAction.move(by: vector, duration: 3), SKAction.run {bullet.removeFromParent()} ]))
        lastShoot = Double(NSDate().timeIntervalSince1970)
    }
}

// for now - all kinds in one file

class Blaster: Weapon {
    
    override init(_ weaponCategory: WeaponCategory, _ damage: Int, _ rechargeTime: Double) {
        super.init(weaponCategory, damage, rechargeTime)
    }
}

class Laser: Weapon {
    var laserWidth: Double
    
    init(_ weaponCategory: WeaponCategory, _ damage: Int, _ rechargeTime: Double, _ laserWidth: Double = 0) {
        self.laserWidth = laserWidth
        super.init(weaponCategory, damage, rechargeTime)
    }
}

class MachineGun: Weapon {
    override init(_ weaponCategory: WeaponCategory, _ damage: Int, _ rechargeTime: Double) {
        super.init(weaponCategory, damage, rechargeTime)
    }
}

class Rocket: Weapon {
    override init(_ weaponCategory: WeaponCategory, _ damage: Int, _ rechargeTime: Double) {
        super.init(weaponCategory, damage, rechargeTime)
    }
}
