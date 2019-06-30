//
//  DetailViewController.swift
//  First Challenge
//
//  Created by Felipe on 6/6/19.
//  Copyright © 2019 Felipe. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet var imageView: UIImageView!
    
    var imageSelected: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let imageToLoad = imageSelected {
            imageView.image = UIImage(named: imageToLoad)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareFlag))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func shareFlag(){
        guard let imageShare = imageView.image?.jpegData(compressionQuality: 0.8) else{
            print("image not found")
            return
        }
        
        guard let image = imageSelected else{
            return
        }
        let objectToShare = [imageShare] as Any
        let vc = UIActivityViewController(activityItems: [objectToShare,image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
    }
}
