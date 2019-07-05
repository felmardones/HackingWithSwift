//
//  ViewController.swift
//  White House Petitions
//
//  Created by Felipe on 7/4/19.
//  Copyright © 2019 Felipe. All rights reserved.
//

import UIKit

class ViewController: UITableViewController{
    
    var petitions = [Petition]()
    var searchResults = [Petition]()
    var lastStatePetitions = [Petition]()
    var buttonsRight = [UIBarButtonItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let creditBtn = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showCredits))
        let searchBtn = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchList))
        buttonsRight.insert(creditBtn, at: 0)
        buttonsRight.insert(searchBtn, at: 0)
        navigationItem.rightBarButtonItems = buttonsRight
        let urlString: String
        if navigationController?.tabBarItem.tag == 0{
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }else{
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parse(json: data)
                return
            }
        }
        showError()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        let petition =  petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func parse(json:Data){
        let decoder = JSONDecoder();
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            lastStatePetitions = petitions
            tableView.reloadData()
        }
    }
    
    func showError(){
        let ac = UIAlertController(title: "Error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    @objc func showCredits(){
        let ac = UIAlertController(title: "Credits", message: "The data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true)
    }
    @objc func searchList(){
        let ac = UIAlertController(title: "Search", message: "Introduce the search words", preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Search", style: .default){ [weak self, weak ac] action in
            guard let searchText = ac?.textFields?[0].text else{
                return
            }
            self?.searchTextInPetitionsList(searchText)
        }
        ac.addAction(submitAction)
        present(ac,animated: true)
        
    }
    
    func searchTextInPetitionsList(_ search: String){
        petitions = lastStatePetitions
        searchResults = petitions.filter{ $0.title.contains(search) || $0.body.contains(search) }
        petitions = searchResults
        tableView.reloadData()
    }
}

