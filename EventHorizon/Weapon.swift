//
//  Weapon.swift
//  EventHorizon
//
//  Created by deserg on 17.09.17.
//  Copyright © 2017 deserg. All rights reserved.
//

import Foundation

enum WeaponCategory {
    case main
    case additional
}

class Weapon {
    
    var weaponCategory: WeaponCategory
    var damage: Int
    var rechargeTime: Double
    
    init(_ weaponCategory: WeaponCategory, _ damage: Int, _ rechargeTime: Double) {
        self.weaponCategory = weaponCategory
        self.damage = damage
        self.rechargeTime = rechargeTime
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
