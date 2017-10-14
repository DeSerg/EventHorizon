//
//  WeaponFactory.swift
//  EventHorizon
//
//  Created by deserg on 19.09.17.
//  Copyright © 2017 deserg. All rights reserved.
//

import Foundation

class WeaponFactory {
    func createWeapon(weaponCategory: WeaponCategory, damage: Int, rechargeTime: Double) -> Weapon {
        preconditionFailure("This method must be overridden")
    }
}

class BlasterFactory: WeaponFactory {
    override func createWeapon(weaponCategory: WeaponCategory, damage: Int, rechargeTime: Double) -> Weapon {
        return Blaster(weaponCategory, damage, rechargeTime)
    }
}

class LaserFactory: WeaponFactory {
    override func createWeapon(weaponCategory: WeaponCategory, damage: Int, rechargeTime: Double) -> Weapon {
        return Laser(weaponCategory, damage, rechargeTime)
    }
}

class MachineGunFactory: WeaponFactory {
    override func createWeapon(weaponCategory: WeaponCategory, damage: Int, rechargeTime: Double) -> Weapon {
        return MachineGun(weaponCategory, damage, rechargeTime)
    }
}
