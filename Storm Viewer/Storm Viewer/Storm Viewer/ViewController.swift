//
//  ViewController.swift
//  Storm Viewer
//
//  Created by Felipe on 6/2/19.
//  Copyright © 2019 Felipe. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        //declare a constant to access the filesystem
        let fm = FileManager.default
        //path to our bundle directory
        let path = Bundle.main.resourcePath!
        //get the content of the directory
        let items = try! fm.contentsOfDirectory(atPath: path)
        //look up for the files we need
        for item in items {
            //set the condition to only nssl images
            if item.hasPrefix("nssl"){
                //fill the array with nssl images
                pictures.append(item)
            }
        }
        pictures.sort()
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //try loading "Detail" view controller and typeCasting it to be a DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.selectedImage = pictures[indexPath.row]
            vc.positionImage = indexPath.row + 1
            vc.totalImages = pictures.count
            //vc.title = "Picture \(indexPath.row) of \(pictures.count)"
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }

}

