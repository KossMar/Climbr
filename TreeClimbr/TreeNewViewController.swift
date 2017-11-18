//
//  TreeNewViewController.swift
//  TreeClimbr
//
//  Created by Carlo Namoca on 2017-11-17.
//  Copyright © 2017 Mar Koss. All rights reserved.
//

import UIKit

class TreeNewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate {
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var treeNameLabel: UILabel!
    @IBOutlet weak var treeNameTextField: UITextField!
    @IBOutlet weak var TreeDescTextView: UITextView!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    let imagePickerController = UIImagePickerController()
    var photoArr = Array<UIImage>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up imageview shape
        treeImageView.layer.cornerRadius = treeImageView.frame.width * 0.5
        treeImageView.clipsToBounds = true
        
        setup()
        

    }
    
    //MARK: VC buttons
    @IBAction func addPhoto(_ sender: UIButton) {
        imagePickerController.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
        // add photo should go to collection view
    }
    
    @IBAction func save(_ sender: UIButton) {
        //save details
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Collection view delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPhotoCell", for: indexPath)
        return cell
    }
    
    //MARK: Collection view
    func setup() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        imagePickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
