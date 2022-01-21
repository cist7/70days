// swiftlint:disable all
import Amplify
import Foundation

public struct CTMemory: Model, Identifiable, Hashable {
  public let id: String
  public var name: String?
  
  public init(id: String = UUID().uuidString,
      name: String? = nil) {
      self.id = id
      self.name = name
  }
}
