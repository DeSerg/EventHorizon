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
    var mainWeaponFactory: WeaponFactory { get set }
    var additionalWeaponFactory: WeaponFactory { get set }
    
    func buildMainWeapon(damage: Int, rechargeTime: Double)
    func buildAdditionalWeapon(damage: Int, rechargeTime: Double)
    func buildHp(maxHp: Int)
    func buildArmor(armor: Int)
}

class FastShipBuilder: IShipBuilder {
    
    var ship: Ship {
        return self.ship
    }
    
    var mainWeaponFactory: WeaponFactory
    var additionalWeaponFactory: WeaponFactory
    
    func buildMainWeapon(damage: Int, rechargeTime: Double) {
        ship.mainWeapon = mainWeaponFactory.createWeapon(weaponCategory: WeaponCategory.main, damage: 10, rechargeTime: 10)
    }
    
    func buildAdditionalWeapon(damage: Int, rechargeTime: Double) {
        ship.mainWeapon = additionalWeaponFactory.createWeapon(weaponCategory: WeaponCategory.main, damage: 10, rechargeTime: 10)
    }
    
    func buildHp(maxHp: Int) {
        ship.maxHp = 100
        ship.currentHp = 100
    }
    
    func buildArmor(armor: Int) {
        ship.armor = 100
    }
    
    init(mainWeaponFactory: WeaponFactory, additionalWeaponFactory: WeaponFactory) {
        self.mainWeaponFactory = mainWeaponFactory
        self.additionalWeaponFactory = additionalWeaponFactory
    }
    
}

class PowerfulShipBuilder: IShipBuilder {
    
    var ship: Ship {
        return self.ship
    }
    
    var mainWeaponFactory: WeaponFactory
    var additionalWeaponFactory: WeaponFactory
    
    func buildMainWeapon(damage: Int, rechargeTime: Double) {
        ship.mainWeapon = mainWeaponFactory.createWeapon(weaponCategory: WeaponCategory.main, damage: 10, rechargeTime: 10)
    }
    
    func buildAdditionalWeapon(damage: Int, rechargeTime: Double) {
        ship.mainWeapon = additionalWeaponFactory.createWeapon(weaponCategory: WeaponCategory.main, damage: 10, rechargeTime: 10)
    }
    
    func buildHp(maxHp: Int) {
        ship.maxHp = 300
        ship.currentHp = 300
    }
    
    func buildArmor(armor: Int) {
        ship.armor = 300
    }
    
    init(mainWeaponFactory: WeaponFactory, additionalWeaponFactory: WeaponFactory) {
        self.mainWeaponFactory = mainWeaponFactory
        self.additionalWeaponFactory = additionalWeaponFactory
    }
    
}
