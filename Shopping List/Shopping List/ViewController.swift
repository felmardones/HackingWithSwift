//
//  ViewController.swift
//  Shopping List
//
//  Created by Felipe on 7/4/19.
//  Copyright © 2019 Felipe. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var itemList = [String]()
    var rightButtons = [UIBarButtonItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //create buttons for add Items to the table and delete items
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addShopItem))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(shareList))
        rightButtons.insert(shareButton, at: 0)
        rightButtons.insert(addButton, at: 0)

        navigationItem.rightBarButtonItems = rightButtons
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTable))
    }
    
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = itemList[indexPath.row]
        return cell
    }
    @objc func addShopItem(){
        print("Add Item")
        let ac = UIAlertController(title: "Add Shop Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Add", style: .default){ [weak self, weak ac] action in
            guard let shopItem = ac?.textFields?[0].text else{
                return
            }
            self?.submitItem(shopItem)
            
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    @objc func refreshTable(){
        itemList.removeAll()
        tableView.reloadData()
    }
    
    @objc func shareList(){
        let list = itemList.joined(separator: "\n")
        let aac = UIActivityViewController(activityItems: [list], applicationActivities: [])
        aac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(aac,animated: true)
    }

    func submitItem(_ item: String) {
        let indexPath = IndexPath(row: 0, section: 0)
        itemList.insert(item, at: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

}

