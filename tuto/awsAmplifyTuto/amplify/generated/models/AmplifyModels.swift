// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "3bdc195c9bf91ada8b58c507805a5402"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: CTMemory.self)
  }
}