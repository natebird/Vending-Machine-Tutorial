//
//  VendingMachine.swift
//  VendingMachine
//
//  Created by Nate Bird on 3/3/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

// Protocols

protocol VendingMachineType {
  var selection: [VendingSelection] { get }
  var inventory: [VendingSelection: ItemType] { get set }
  var amountDeposited: Double { get set }
  
  init(inventory: [VendingSelection: ItemType])
  func vend(selection: VendingSelection, quantity: Double) throws
  func deposit(amount: Double)
}

protocol ItemType {
  let price: Double { get }
  var quantity: Double { get set }
}


// Error Types

enum InventoryError: ErrorType {
  case invalidResource
  case conversionError
  case invalidKey
}

// Helper Classes
class PlistConverter {
  class func dictionaryFromFile(resource: String, ofType type: String) throws -> [String: AnyObject] {
    guard let path = NSBundle.mainBundle().pathForResource(resource, ofType: type) else {
      throw InventoryError.invalidResource
    }
    
    guard let dictionary = NSDictionary(contentsOfFile: path),
    let castDictionary = dictionary as? [String: AnyObject] else {
      throw InventoryError.conversionError
    }
    
    return castDictionary
  }
}

class InventoryUnarchiver {
  class func vendingInventoryFromDictionary(dictionary: [String: AnyObject]) throws -> [VendingSelection: ItemType] {
    
    var inventory: [VendingSelection : ItemType] = [:]
    
    for (key, value) in dictionary {
      if let itemDict = value as? [String : Double],
         let price = itemDict["price"],
         let quantity = itemDict["quantity"] {
        
          let item = VendingItem(price: price, quantity: quantity)
        
          guard let key = VendingSelection(rawValue: key) else {
            throw InventoryError.invalidKey
          }
        
        inventory.updateValue(item, forKey: key)
      }
      
      return inventory
    }
  }
}

// Concrete Types

enum VendingSelection: String {
  case Soda
  case DietSoda
  case Chips
  case Cookie
  case Sandwich
  case Wrap
  case CandyBar
  case PopTart
  case Water
  case FruitJuice
  case SportsDrink
  case Gum
}

struct VendingItem {
  let price: Double
  var quantity: Double
}

class VendingMachine: VendingMachineType {
  var selection: [VendingSelection] = [.Soda, .DietSoda, .Chips, .Cookie, .Sandwich, .Wrap, .CandyBar, .PopTart, .Water, .FruitJuice, .SportsDrink, .Gum]
  var inventory: [VendingSelection : ItemType]
  var amountDeposited: Double = 10
  
  required init(inventory: [VendingSelection : ItemType]) {
    self.inventory = inventory
  }
  
  func vend(selection: VendingSelection, quantity: Double) throws {
    // add code
  }
  
  func deposit(amount: Double) {
    // add code
  }
}