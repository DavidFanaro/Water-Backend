//
//  File.swift
//  
//
//  Created by David Fanaro on 8/25/20.
//

import Vapor

struct DropResponse: Content, Codable {
    var userid: UUID?
    var id: UUID?
    var username:String
    var title:String
    var content:String
}
