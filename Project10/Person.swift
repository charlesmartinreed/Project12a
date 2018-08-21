//
//  Person.swift
//  Project10
//
//  Created by Charles Martin Reed on 8/20/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

//NSCoding requires working with OBJECTS, or structs interchangeable with objects, so this is why we used a class for making a Person instead of a struct.

class Person: NSObject, NSCoding {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        
        //self means apply the param value to this class' property
        self.name = name
        self.image = image
    }
    
    //required means if anyone wants to subclass this class, they need to implement this method
    //used when loading objects of this class
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        image = aDecoder.decodeObject(forKey: "image") as! String
    }
    
    //used when saving objects of this class
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
    }
}
