// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "a4868f7c2bf8c94383af8477fec21cab"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: AmplifyTuto.self)
  }
}