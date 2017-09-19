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
    
    init(weaponCategory: WeaponCategory, damage: Int, rechargeTime: Double) {
        self.weaponCategory = weaponCategory
        self.damage = damage
        self.rechargeTime = rechargeTime
    }
}

// for now - all kinds in one file

class Blaster: Weapon {
    
    init(weaponCategory: WeaponCategory, damage: Int, rechargeTime: Double, laserWidth: Double) {
        super.init(weaponCategory: weaponCategory, damage: damage, rechargeTime: rechargeTime)
    }
}

class Laser: Weapon {
    var laserWidth: Double
    
    init(weaponCategory: WeaponCategory, damage: Int, rechargeTime: Double, laserWidth: Double) {
        self.laserWidth = laserWidth
        super.init(weaponCategory: weaponCategory, damage: damage, rechargeTime: rechargeTime)
    }
}

class MachineGun: Weapon {
    
}
