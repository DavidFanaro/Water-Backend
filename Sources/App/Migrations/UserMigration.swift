//
//  File.swift
//  
//
//  Created by David Fanaro on 8/12/20.
//

import Fluent

class UserMigration: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(User.schema)
        .id()
        .field("firstname",.string,.required)
        .field("lastname",.string,.required)
        .field("username",.string,.required)
        .field("password",.string,.required)
        .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(User.schema).delete()
    }
    
}
