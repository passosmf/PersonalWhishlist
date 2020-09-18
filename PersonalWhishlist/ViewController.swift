//
//  ViewController.swift
//  BuyList
//
//  Created by Marcio P Ferreira on 16/09/20.
//  Copyright © 2020 Passos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldQuantity: UITextField!
    @IBOutlet weak var emojiEmptyList: UILabel!

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet var uiView: UIView!
    
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var buttonClean: UIButton!
    @IBOutlet weak var buttonRemove: UIButton!
    
    let gabiarra: Int = 1000
    let errorNotFound: Int = 0
    var buyManager = BuyManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiEmptyList.font = UIFont.boldSystemFont(ofSize: 110)
        buttonSave.layer.cornerRadius = 5
        buttonClean.layer.cornerRadius = 5
        buttonRemove.layer.cornerRadius = 5
        buttonRemove.backgroundColor = UIColor.systemGray4
        buttonRemove.isEnabled = false
        
        textFieldName.delegate = self
        textFieldQuantity.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        let buyItem1 = BuyItem(name: "Macbook Pro 16'", quantity: "1")
        let buyItem2 = BuyItem(name: "Vacation on the beach", quantity: "2")
        let buyItem3 = BuyItem(name: "Vacation again anywhere", quantity: "1")
        buyManager.saveBuyItem(buyItem: buyItem1)
        buyManager.saveBuyItem(buyItem: buyItem2)
        buyManager.saveBuyItem(buyItem: buyItem3)
        showBuyList()
    }

    @IBAction func save(_ sender: UIButton) {
        self.view.endEditing(true)
        let message = buyManager.validateFields(name: textFieldName.text!, quantity: textFieldQuantity.text!)
        if message.count == errorNotFound  {
            let buyItem = BuyItem(name: textFieldName.text!, quantity: textFieldQuantity.text!)
            buyManager.saveBuyItem(buyItem: buyItem)
            showBuyList()
            showMessage(title: "Good!", message: "Let's work on it.")
            cleanForm(type: "")
        } else {
            showMessage(title: message[0], message: message[1])
            cleanForm(type: message[0])
        }
    }
    
    @IBAction func cleanForm(_ sender: UIButton) {
        buyManager.setSelectedBuyItem(buyItemIndex: -1)
        cleanForm(type: "")
    }
    
    @IBAction func remove(_ sender: UIButton) {
        buyManager.removeSelected()
        updateView()
        showBuyList()
        uiView.setNeedsDisplay()
        cleanForm(type: "")
    }
    
    func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .cancel) { (UIAlertAction) in
            self.uiView.backgroundColor = UIColor.white
        }
        alert.addAction(okAction)
        self.present(alert, animated: true) {
        }
    }
    
    func cleanForm(type: String) {
         if type == "" {
            buttonRemove.isEnabled = false
            buttonRemove.backgroundColor = UIColor.systemGray4
            textFieldName.text = ""
            textFieldQuantity.text = ""
        } else if type == "🔢" {
            textFieldQuantity.text = ""
        } else if type == "❓" {
            // set focus on quantity here
        }
    }
    
    func updateView() {
        for subview in uiView.subviews {
            if subview.tag >= gabiarra {
                subview.removeFromSuperview()
            }
        }
    }
    
    func showBuyList() {
        if buyManager.arrayBuyItems.count > 0 {
            emojiEmptyList.isHidden = true
            var yPos = 380
            let buttonTitle = UIButton()
            buttonTitle.tag = 999
            buttonTitle.setTitle("My whishes", for: .normal)
            buttonTitle.backgroundColor = UIColor.systemGray
            buttonTitle.layer.cornerRadius = 5
            buttonTitle.contentHorizontalAlignment = .center
            buttonTitle.frame = CGRect( x:28, y:yPos, width:365, height: 35)
            uiView.addSubview(buttonTitle)
            
            yPos += 37
            var i = gabiarra
            for item in buyManager.arrayBuyItems {
                let buttonItemList = UIButton()
                buttonItemList.addTarget(self, action: #selector(loadBuyItem), for: .touchUpInside)
                buttonItemList.tag = i
                buttonItemList.setTitle("  "+item.name.truncate(to: 20), for: .normal)
                if buyManager.getSelectedBuyItem() != -1,  buyManager.getSelectedBuyItem() == (i-gabiarra){
                    buttonItemList.backgroundColor = UIColor.systemBlue
                } else {
                    buttonItemList.backgroundColor = UIColor.systemGray3
                }
                buttonItemList.layer.cornerRadius = 5
                buttonItemList.contentHorizontalAlignment = .left
                buttonItemList.frame = CGRect( x:28, y:yPos, width:295, height: 35)
                uiView.addSubview(buttonItemList)
                
                let buttonItemListQtd = UIButton()
                buttonItemListQtd.addTarget(self, action: #selector(loadBuyItem), for: .touchUpInside)
                buttonItemListQtd.tag = i
                buttonItemListQtd.setTitle(item.quantity, for: .normal)
                if buyManager.getSelectedBuyItem() != -1,  buyManager.getSelectedBuyItem() == (i-gabiarra){
                    buttonItemListQtd.backgroundColor = UIColor.systemBlue
                } else {
                    buttonItemListQtd.backgroundColor = UIColor.systemGray3
                }
                buttonItemListQtd.layer.cornerRadius = 5
                buttonItemListQtd.contentHorizontalAlignment = .center
                buttonItemListQtd.frame = CGRect( x:325, y:yPos, width:68, height: 35)
                uiView.addSubview(buttonItemListQtd)
                
                yPos += 37
                i = i + 1
            }
        } else {
            emojiEmptyList.isHidden = false
        }
    }
    
    @objc func loadBuyItem(_ sender: UIButton) {
        let buyItemIndex = sender.tag - 1000
        let buyItem = buyManager.find(index: buyItemIndex)
        buyManager.setSelectedBuyItem(buyItemIndex: buyItemIndex)
        textFieldName.text = buyItem.name
        textFieldQuantity.text = buyItem.quantity
        buttonRemove.backgroundColor = UIColor.systemBlue
        buttonRemove.isEnabled = true
        showBuyList()
    }
}






