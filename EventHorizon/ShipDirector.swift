//
//  ShipDirector.swift
//  EventHorizon
//
//  Created by deserg on 10.12.2017.
//  Copyright © 2017 deserg. All rights reserved.
//

import Foundation


class ShipDirector {

//    var builder: IShipBuilder
    
    init() {
//        self.builder = builder
    }
    
    func construct(builder: IShipBuilder) -> Ship {
        
        builder.buildMainWeapon()
        builder.buildAdditionalWeapon()
        builder.buildHp()
        builder.buildSpeed()
        builder.buildArmor()
        
        return builder.ship
        
    }
    
    
}
