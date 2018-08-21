//
//  Person.swift
//  Project10
//
//  Created by Charles Martin Reed on 8/20/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

//Using Codeable is preferred when dealing with Swift only code because it is streamlined compared to NSCoding. Uses JSON to read and write.
//Unlike NSCoding, we don't have to require a special init aDecoder or an aCoder method.

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        
        //self means apply the param value to this class' property
        self.name = name
        self.image = image
    }
    
}
