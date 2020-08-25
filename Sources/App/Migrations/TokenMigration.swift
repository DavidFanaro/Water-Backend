//
//  File.swift
//  
//
//  Created by David Fanaro on 8/14/20.
//

import Vapor
import Fluent

class TokenMigration: Migration{
    func prepare(on database: Database) -> EventLoopFuture<Void> {
      // 2
      database.schema(Token.schema)
         // 3
        .id()
        .field("user_id", .uuid, .references("users", "id"))
        .field("value", .string, .required)
        .unique(on: "value")
        // 4
        .create()
    }

    // 5
    func revert(on database: Database) -> EventLoopFuture<Void> {
      database.schema(Token.schema).delete()
    }
}
