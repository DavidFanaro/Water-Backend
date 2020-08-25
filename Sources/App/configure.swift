import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    if let databaseURL = Environment.get("DATABASE_URL") {
        app.databases.use(try .postgres(
            url: databaseURL
            ), as: .psql)
    }
    else{
        app.databases.use(.postgres(
            hostname: Environment.get("DATABASE_HOST") ?? "",
            username: Environment.get("DATABASE_USERNAME") ?? "",
            password: Environment.get("DATABASE_PASSWORD") ?? "",
            database: Environment.get("DATABASE_NAME") ?? ""
            ), as: .psql)
    }
    
    app.migrations.add([UserMigration(),DropMigration(),TokenMigration()])
    
    // register routes
    try routes(app)
}
