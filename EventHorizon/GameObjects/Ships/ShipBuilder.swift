//
//  ShipBuilder.swift
//  EventHorizon
//
//  Created by deserg on 03.10.2017.
//  Copyright © 2017 deserg. All rights reserved.
//

import Foundation

protocol IShipBuilder {
    var ship: Ship {get}

    func buildMainWeapon()
    func buildAdditionalWeapon()
    func buildHp()
    func buildSpeed()
    func buildArmor()
}

class FastShipBuilder: IShipBuilder {
    
    var ship = Ship()
    
    func buildMainWeapon() {
        let weaponFactory = MachineGunFactory()
        ship.mainWeapon = weaponFactory.createWeapon(weaponCategory: WeaponCategory.main, damage: 10, rechargeTime: 0.1)
    }
    
    func buildAdditionalWeapon() {
        let weaponFactory = RocketFactory()
        ship.additionalWeapon = weaponFactory.createWeapon(weaponCategory: WeaponCategory.additional, damage: 100, rechargeTime: 4)
    }
    
    func buildHp() {
        ship.maxHp = 100
        ship.currentHp = 100
    }
    
    func buildSpeed() {
        ship.shipSpeedPerSec = 1000
    }
    
    func buildArmor() {
        ship.armor = 100
    }
    
    init() {
//        ship = Ship()
    }
    
}

class PowerfulShipBuilder: IShipBuilder {
    
    var ship = Ship()
    
    func buildMainWeapon() {
        let weaponFactory = BlasterFactory()
        ship.mainWeapon = weaponFactory.createWeapon(weaponCategory: WeaponCategory.main, damage: 10, rechargeTime: 0.5)
    }
    
    func buildAdditionalWeapon() {
        let weaponFactory = RocketFactory()
        ship.mainWeapon = weaponFactory.createWeapon(weaponCategory: WeaponCategory.additional, damage: 10, rechargeTime: 5)
    }
    
    func buildHp() {
        ship.maxHp = 300
        ship.currentHp = 300
    }
    
    func buildSpeed() {
        ship.shipSpeedPerSec = 500
    }
    
    func buildArmor() {
        ship.armor = 300
    }
    
    init() {
        
    }
    
}
