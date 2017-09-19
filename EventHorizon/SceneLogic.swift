//
//  SceneLogic.swift
//  EventHorizon
//
//  Created by deserg on 17.09.17.
//  Copyright © 2017 deserg. All rights reserved.
//

import Foundation

// singleton to navigate between scenes

class SceneManager {
    
    private static var instance: SceneManager = SceneManager()
    
    init() {
        mainMenu = MainMenu()
        game = Game()
        workshop = Workshop()
    }
    
    static func getInstance() -> SceneManager {
        return instance
    }
    
    var mainMenu: MainMenu
    var game: Game
    var workshop: Workshop
    
}
 
