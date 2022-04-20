// swiftlint:disable all
import Amplify
import Foundation

extension AmplifyTuto {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case name
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let amplifyTuto = AmplifyTuto.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "AmplifyTutos"
    
    model.fields(
      .id(),
      .field(amplifyTuto.name, is: .optional, ofType: .string),
      .field(amplifyTuto.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(amplifyTuto.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}