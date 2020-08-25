//
//  File.swift
//  
//
//  Created by David Fanaro on 8/14/20.
//

import Vapor
import Fluent

enum SessionSource: Int, Content {
  case signup
  case login
}

//1
final class Token: Model {
  //2
  static let schema = "tokens"
  
  @ID(key: "id")
  var id: UUID?
  
  //3
  @Parent(key: "user_id")
  var user: User
  
  //4
  @Field(key: "value")
  var value: String
  
  init() {}
    
    init(id: UUID? = nil, userId: User.IDValue, token: String){
      self.id = id
      self.$user.id = userId
      self.value = token
     
    }
}

extension Token: Content{}



extension Token: ModelTokenAuthenticatable{
    static let valueKey = \Token.$value
    static let userKey = \Token.$user

    var isValid: Bool {
        true
    }
}
