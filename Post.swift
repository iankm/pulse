//
//  Post.swift
//  Pulse
//  Not a real .swift class
//  Specifically for UI layout purposes.
//  Created by Ian Kumar Mukherjee on 2/29/16.
//  Copyright © 2016 Ian Kumar Mukherjee. All rights reserved.
//

import UIKit

class Post {
    var answer: String
    var time: String
    
    init?(answer: String, time: String) {
        self.answer = answer
        self.time = time
        
        
        if answer.isEmpty {
            return nil
        }
    }
}
