//
//  File.swift
//  
//
//  Created by David Fanaro on 8/14/20.
//

import Vapor
import Fluent

class DropController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let path =  routes.grouped(Token.authenticator())
        path.get("drops", "all", use: getAllDrops)
        //path.webSocket("drops","all","socket", onUpgrade: getAllDropsSocket)
    }
    
    func getAllDrops(req: Request) throws -> EventLoopFuture<[DropResponse]> {
        var responseDrops:[DropResponse] = []
        
        return Drop.query(on: req.db).with(\.$user).all().map{ drops -> [DropResponse] in
            for drop in drops{
                let newDrop = DropResponse(userid: drop.user.id, id: drop.id, username: drop.user.username, title: drop.title, content: drop.drop_content)
                responseDrops.append(newDrop)
            }
            return responseDrops
        }

        
    }
    
    
//    func getAllDropsSocket(req: Request, sock:WebSocket) {
//
//        do{
//
//            var sockData: [Drop]!
//
//            var _ = Drop.query(on: req.db).all().map{ drops in
//                sockData = drops
//            }
//            if sockData != nil{
//                let jsonData = try JSONEncoder().encode(sockData)
//
//                sock.send(jsonData.base64EncodedString())
//                sock.close()
//            }
//
//        }catch{
//            sock.send("Error")
//            sock.close()
//        }
//
//    }
    
}
