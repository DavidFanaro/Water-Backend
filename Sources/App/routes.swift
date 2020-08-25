import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    try app.register(collection: SignupController())
    try app.register(collection: LoginController())
    try app.register(collection: DropCreationController())
    try app.register(collection: DropController())
    
}
