//
//  TableController.swift
//  WebView
//
//  Created by Felipe on 6/29/19.
//  Copyright © 2019 Felipe. All rights reserved.
//

import Foundation
import UIKit


class TableController: UITableViewController{
    let webSites = ["apple.com","hackingwithswift.com"]
    let webSiteUrl: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Websites List"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return webSites.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "webItem", for: indexPath)
        cell.textLabel?.text = webSites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? ViewController{
            vc.webUrl = webSites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
