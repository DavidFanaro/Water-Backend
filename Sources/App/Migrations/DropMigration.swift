//
//  File.swift
//  
//
//  Created by David Fanaro on 8/12/20.
//

import Fluent

class DropMigration: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Drop.schema)
        .id()
        .field("title", .string, .required)
        .field("drop_content", .string, .required)
        .field("user_id", .uuid, .required, .references("users", "id"))
        .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Drop.schema).delete()
    }
}
