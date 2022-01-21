// swiftlint:disable all
import Amplify
import Foundation

extension CTMemory {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case name
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let cTMemory = CTMemory.keys
    
    model.pluralName = "CTMemories"
    
    model.fields(
      .id(),
      .field(cTMemory.name, is: .optional, ofType: .string)
    )
    }
}