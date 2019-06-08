//
//  DetailViewController.swift
//  Storm Viewer
//
//  Created by Felipe on 6/2/19.
//  Copyright © 2019 Felipe. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var totalImages: Int?
    var positionImage: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let totalImg = totalImages, let posImg = positionImage{
            title = "Picture \(posImg) of \(totalImg)"
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        }else{
            title = ""
        }
        navigationItem.largeTitleDisplayMode = .never
        // Do any additional setup after loading the view.
        if let imageToLoad = selectedImage{
            imageView.image = UIImage(named: imageToLoad)
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    @objc func shareTapped() {
        guard let image =
            imageView.image?.jpegData(compressionQuality: 0.8) else {
                print("No image found")
                return
        }
        guard let imageN = selectedImage else{
            return
        }
        let vc = UIActivityViewController(activityItems: [image,imageN,"Prueba"],
                                          applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem =
            navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
