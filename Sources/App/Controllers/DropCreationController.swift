//
//  File.swift
//  
//
//  Created by David Fanaro on 8/14/20.
//

import Vapor
import Fluent

class DropCreationController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let request = routes.grouped(Token.authenticator())
        request.post("createdrop", use: createdrop)
    }
    
    func createdrop(req: Request) throws -> EventLoopFuture<Drop> {
        let user = try req.auth.require(User.self)
        let dropcontent = try req.content.decode(DropContent.self)
        let drop = Drop(title: dropcontent.title, content: dropcontent.content, user: user)
        return user.$drops.create(drop, on: req.db).map{
            drop
        }
        
    }
}
