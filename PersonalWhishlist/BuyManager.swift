//
//  BuyManager.swift
//  BuyList
//
//  Created by Marcio P Ferreira on 16/09/20.
//  Copyright © 2020 Passos. All rights reserved.
//

import Foundation

class BuyManager {
    var arrayBuyItems = [BuyItem]()
    private var selectedBuyItem = -1
    
    func getSelectedBuyItem() -> Int {
        return selectedBuyItem
    }
    
    func setSelectedBuyItem(buyItemIndex: Int) {
        self.selectedBuyItem = buyItemIndex
    }
    
    func saveBuyItem(buyItem: BuyItem) {
        if selectedBuyItem == -1 {
            arrayBuyItems.append(buyItem)
        } else {
            arrayBuyItems[selectedBuyItem] = buyItem
            selectedBuyItem = -1
        }
    }
    
    func validateFields(name: String, quantity: String) -> [String] {
        if name.isEmpty {
            return  ["⛔️", "Try typing your wish first."]
        } else if quantity.isEmpty {
            return  ["❓", "How many?"]
        } else if !quantity.isNumber {
            return ["🔢", "Quantity must be a number."]
        }
        return []
    }
    
    func find(name: String) -> BuyItem? {
        for item in arrayBuyItems {
            if item.name == name {
                return item
            }
        }
        return nil
    }
    
    func find(index: Int) -> BuyItem {
        return arrayBuyItems[index]
    }
    
    func removeSelected() {
        arrayBuyItems.remove(at: selectedBuyItem)
        selectedBuyItem = -1
    }
}
