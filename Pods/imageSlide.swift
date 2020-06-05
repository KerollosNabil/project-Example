//
//  imageSlide.swift
//  tryPhatmacy
//
//  Created by MAC on 6/5/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation


struct ImageSlideModel:Codable {
    var imageUrl:URL
    var json: Data?{
        return try? JSONEncoder().encode(self)
    }
    init?(json:Data) {
        if let data = try? JSONDecoder().decode(ImageSlideModel.self, from: json){
            self = data
        }else{
            return nil
        }
    }
    init(imageUrl:URL) {
        self.imageUrl = imageUrl
    }
}
