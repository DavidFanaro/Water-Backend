//
//  File.swift
//  
//
//  Created by David Fanaro on 8/12/20.
//

import Vapor
import Fluent
import FluentPostgresDriver

final class User: Model {
    static var schema: String = "users"
    
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "firstname")
    var firstname:String
    
    @Field(key: "lastname")
    var lastname:String
    
    @Field(key: "username")
    var username:String
    
    @Field(key: "password")
    var password:String
    
    @Children(for: \.$user)
    var drops:[Drop]
    
    @Children(for: \.$user)
    var token:[Token]
    

    
    init() {}
    
    init(first:String, last:String, user:String, pass:String) {
        self.firstname = first
        self.lastname = last
        self.username = user
    
        self.password = pass
    }
    
    func createToken()throws -> Token {
        try .init(userId: self.requireID(), token: [UInt8].random(count: 16).base64)
    }
    
}

struct UserSession: Codable, Content{
    var firstname: String
    var lastname: String
    var username: String
    var password: String
}


extension User : Codable {}
extension User : Content{}
extension User : Authenticatable{}

extension User: ModelAuthenticatable {
    static let usernameKey = \User..$username
    static let passwordHashKey = \User..$password

    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.password)
    }
}

