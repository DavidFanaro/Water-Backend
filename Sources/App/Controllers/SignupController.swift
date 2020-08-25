//
//  File.swift
//  
//
//  Created by David Fanaro on 8/14/20.
//

import Vapor
import Fluent

class SignupController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let path = routes.grouped("signup")
        path.post(use: create)
        
    }
    
    func create(req: Request) throws -> EventLoopFuture<UserSession> {
        let userDetails = try req.content.decode(UserSession.self)
        let user = User(first: userDetails.firstname, last: userDetails.lastname, user: userDetails.username, pass: try Bcrypt.hash(userDetails.password))
        return user.save(on: req.db).map{
            userDetails
        }
    }
    
}
