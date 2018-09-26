//  Store.swift
//  Guessing Game iOS
//
//  Created by Solomon Keiffer on 9/26/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import Foundation

class Storage: NSObject, NSCoding {
    internal static var upperBound = 100
    internal static var wins = 0
    internal static var losses = 0
    internal static var isColorized = false
    internal static var colorHue: Float = 0.5
    
    static func push(upperBound: Int, wins: Int, losses: Int, isColorized: Bool, colorHue: Float) {
        self.upperBound = upperBound
        self.wins = wins
        self.losses = losses
        self.isColorized = isColorized
        self.colorHue = colorHue
        store()
    }
    
    static func call() -> (Int, Int, Int, Bool, Float) {
        recall()
        return (upperBound, wins, losses, isColorized, colorHue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        let upperBound = aDecoder.decodeObject(forKey: "upperBound") as! Int
        let wins = aDecoder.decodeObject(forKey: "wins") as! Int
        let losses = aDecoder.decodeObject(forKey: "losses") as! Int
        let isColorized = aDecoder.decodeObject(forKey: "isColorized") as! Bool
        let colorHue = aDecoder.decodeObject(forKey: "colorHue") as! Float
        Storage.push(upperBound: upperBound, wins: wins, losses: losses, isColorized: isColorized, colorHue: colorHue)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Storage.upperBound , forKey: "upperBound")
        aCoder.encode(Storage.wins , forKey: "wins")
        aCoder.encode(Storage.losses , forKey: "losses")
        aCoder.encode(Storage.isColorized , forKey: "isColorized")
        aCoder.encode(Storage.colorHue , forKey: "colorHue")
    } 

    static func store() {
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: upperBound), forKey: "upperBound")
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: wins), forKey: "wins")
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: losses), forKey: "losses")
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: isColorized), forKey: "isColorized")
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: colorHue), forKey: "colorHue")
    }

    static func recall() {
        guard let upperBoundData = UserDefaults.standard.value(forKey: "upperBound") as? Data  else {
            return store()
        }
        let upperBound = NSKeyedUnarchiver.unarchiveObject(with: upperBoundData)
        
        let wins = NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "wins") as! Data)
        let losses = NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "losses") as! Data)
        let isColorized = NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "isColorized") as! Data)
        let colorHue = NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "colorHue") as! Data)
        
        Storage.upperBound = upperBound as! Int
        Storage.wins = wins as! Int
        Storage.losses = losses as! Int
        Storage.isColorized = isColorized as! Bool
        Storage.colorHue = colorHue as! Float
    }
}
