//
//  ViewController.swift
//  Project10
//
//  Created by Charles Martin Reed on 8/20/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //add a button to our nav to let the user pick from the UIImagePicker
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        
        
    }

  
    //MARK: - DATA SOURCE METHODS for UICollectionViewController
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCell
        
        let person = people[indexPath.item]
        
        cell.name.text = person.name
        
        //get the image path for a person object
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        //formatting our border
        //convert to cgColor because we're using CALayer
        cell.imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }

    @objc func addNewPerson() {
        
        //create our image picker
        let picker = UIImagePickerController()
        
        //to allow the user to crop the photo
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
    }
    
    //MARK: - DELEGATE METHODS for UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //extract the image from the dictionary - edited image because we're allowing image to be cropped
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        
        //generate a unique filename for the image, using UUID
        let imageName = UUID().uuidString
        
        //convert to a JPEG and write that JPEG to disk in the Documents Directory
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = UIImageJPEGRepresentation(image, 80) {
            try? jpegData.write(to: imagePath)
        }
        
        //dismiss the view controller
        dismiss(animated: true, completion: nil)
        
        //create a new Person and reload the collectionView
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView?.reloadData()
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //pull out the Person object at the array index that was tapped and show a UIAlertController asking users to rename the person
        let person = people[indexPath.item]
        
        let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [unowned self, ac] _ in
            let newName = ac.textFields![0]
            person.name = newName.text!
            
            self.collectionView?.reloadData()
            
        })
        
        present(ac, animated: true, completion: nil)
        
    }
    
    //notice how the file path is actually a URL
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

}

