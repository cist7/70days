////  This file was automatically generated and should not be edited.
//
//import AWSAppSync
//
//public struct CreateCTMemoryInput: GraphQLMapConvertible {
//  public var graphQLMap: GraphQLMap
//
//  public init(id: GraphQLID? = nil, name: String? = nil, version: Int? = nil) {
//    graphQLMap = ["id": id, "name": name, "_version": version]
//  }
//
//  public var id: GraphQLID? {
//    get {
//      return graphQLMap["id"] as! GraphQLID?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "id")
//    }
//  }
//
//  public var name: String? {
//    get {
//      return graphQLMap["name"] as! String?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "name")
//    }
//  }
//
//  public var version: Int? {
//    get {
//      return graphQLMap["_version"] as! Int?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "_version")
//    }
//  }
//}
//
//public struct ModelCTMemoryConditionInput: GraphQLMapConvertible {
//  public var graphQLMap: GraphQLMap
//
//  public init(name: ModelStringInput? = nil, and: [ModelCTMemoryConditionInput?]? = nil, or: [ModelCTMemoryConditionInput?]? = nil, not: ModelCTMemoryConditionInput? = nil) {
//    graphQLMap = ["name": name, "and": and, "or": or, "not": not]
//  }
//
//  public var name: ModelStringInput? {
//    get {
//      return graphQLMap["name"] as! ModelStringInput?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "name")
//    }
//  }
//
//  public var and: [ModelCTMemoryConditionInput?]? {
//    get {
//      return graphQLMap["and"] as! [ModelCTMemoryConditionInput?]?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "and")
//    }
//  }
//
//  public var or: [ModelCTMemoryConditionInput?]? {
//    get {
//      return graphQLMap["or"] as! [ModelCTMemoryConditionInput?]?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "or")
//    }
//  }
//
//  public var not: ModelCTMemoryConditionInput? {
//    get {
//      return graphQLMap["not"] as! ModelCTMemoryConditionInput?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "not")
//    }
//  }
//}
//
//public struct ModelStringInput: GraphQLMapConvertible {
//  public var graphQLMap: GraphQLMap
//
//  public init(ne: String? = nil, eq: String? = nil, le: String? = nil, lt: String? = nil, ge: String? = nil, gt: String? = nil, contains: String? = nil, notContains: String? = nil, between: [String?]? = nil, beginsWith: String? = nil, attributeExists: Bool? = nil, attributeType: ModelAttributeTypes? = nil, size: ModelSizeInput? = nil) {
//    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "contains": contains, "notContains": notContains, "between": between, "beginsWith": beginsWith, "attributeExists": attributeExists, "attributeType": attributeType, "size": size]
//  }
//
//  public var ne: String? {
//    get {
//      return graphQLMap["ne"] as! String?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "ne")
//    }
//  }
//
//  public var eq: String? {
//    get {
//      return graphQLMap["eq"] as! String?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "eq")
//    }
//  }
//
//  public var le: String? {
//    get {
//      return graphQLMap["le"] as! String?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "le")
//    }
//  }
//
//  public var lt: String? {
//    get {
//      return graphQLMap["lt"] as! String?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "lt")
//    }
//  }
//
//  public var ge: String? {
//    get {
//      return graphQLMap["ge"] as! String?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "ge")
//    }
//  }
//
//  public var gt: String? {
//    get {
//      return graphQLMap["gt"] as! String?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "gt")
//    }
//  }
//
//  public var contains: String? {
//    get {
//      return graphQLMap["contains"] as! String?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "contains")
//    }
//  }
//
//  public var notContains: String? {
//    get {
//      return graphQLMap["notContains"] as! String?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "notContains")
//    }
//  }
//
//  public var between: [String?]? {
//    get {
//      return graphQLMap["between"] as! [String?]?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "between")
//    }
//  }
//
//  public var beginsWith: String? {
//    get {
//      return graphQLMap["beginsWith"] as! String?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "beginsWith")
//    }
//  }
//
//  public var attributeExists: Bool? {
//    get {
//      return graphQLMap["attributeExists"] as! Bool?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "attributeExists")
//    }
//  }
//
//  public var attributeType: ModelAttributeTypes? {
//    get {
//      return graphQLMap["attributeType"] as! ModelAttributeTypes?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "attributeType")
//    }
//  }
//
//  public var size: ModelSizeInput? {
//    get {
//      return graphQLMap["size"] as! ModelSizeInput?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "size")
//    }
//  }
//}
//
//public enum ModelAttributeTypes: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
//  public typealias RawValue = String
//  case binary
//  case binarySet
//  case bool
//  case list
//  case map
//  case number
//  case numberSet
//  case string
//  case stringSet
//  case null
//  /// Auto generated constant for unknown enum values
//  case unknown(RawValue)
//
//  public init?(rawValue: RawValue) {
//    switch rawValue {
//      case "binary": self = .binary
//      case "binarySet": self = .binarySet
//      case "bool": self = .bool
//      case "list": self = .list
//      case "map": self = .map
//      case "number": self = .number
//      case "numberSet": self = .numberSet
//      case "string": self = .string
//      case "stringSet": self = .stringSet
//      case "_null": self = .null
//      default: self = .unknown(rawValue)
//    }
//  }
//
//  public var rawValue: RawValue {
//    switch self {
//      case .binary: return "binary"
//      case .binarySet: return "binarySet"
//      case .bool: return "bool"
//      case .list: return "list"
//      case .map: return "map"
//      case .number: return "number"
//      case .numberSet: return "numberSet"
//      case .string: return "string"
//      case .stringSet: return "stringSet"
//      case .null: return "_null"
//      case .unknown(let value): return value
//    }
//  }
//
//  public static func == (lhs: ModelAttributeTypes, rhs: ModelAttributeTypes) -> Bool {
//    switch (lhs, rhs) {
//      case (.binary, .binary): return true
//      case (.binarySet, .binarySet): return true
//      case (.bool, .bool): return true
//      case (.list, .list): return true
//      case (.map, .map): return true
//      case (.number, .number): return true
//      case (.numberSet, .numberSet): return true
//      case (.string, .string): return true
//      case (.stringSet, .stringSet): return true
//      case (.null, .null): return true
//      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
//      default: return false
//    }
//  }
//}
//
//public struct ModelSizeInput: GraphQLMapConvertible {
//  public var graphQLMap: GraphQLMap
//
//  public init(ne: Int? = nil, eq: Int? = nil, le: Int? = nil, lt: Int? = nil, ge: Int? = nil, gt: Int? = nil, between: [Int?]? = nil) {
//    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "between": between]
//  }
//
//  public var ne: Int? {
//    get {
//      return graphQLMap["ne"] as! Int?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "ne")
//    }
//  }
//
//  public var eq: Int? {
//    get {
//      return graphQLMap["eq"] as! Int?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "eq")
//    }
//  }
//
//  public var le: Int? {
//    get {
//      return graphQLMap["le"] as! Int?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "le")
//    }
//  }
//
//  public var lt: Int? {
//    get {
//      return graphQLMap["lt"] as! Int?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "lt")
//    }
//  }
//
//  public var ge: Int? {
//    get {
//      return graphQLMap["ge"] as! Int?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "ge")
//    }
//  }
//
//  public var gt: Int? {
//    get {
//      return graphQLMap["gt"] as! Int?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "gt")
//    }
//  }
//
//  public var between: [Int?]? {
//    get {
//      return graphQLMap["between"] as! [Int?]?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "between")
//    }
//  }
//}
//
//public struct UpdateCTMemoryInput: GraphQLMapConvertible {
//  public var graphQLMap: GraphQLMap
//
//  public init(id: GraphQLID, name: String? = nil, version: Int? = nil) {
//    graphQLMap = ["id": id, "name": name, "_version": version]
//  }
//
//  public var id: GraphQLID {
//    get {
//      return graphQLMap["id"] as! GraphQLID
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "id")
//    }
//  }
//
//  public var name: String? {
//    get {
//      return graphQLMap["name"] as! String?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "name")
//    }
//  }
//
//  public var version: Int? {
//    get {
//      return graphQLMap["_version"] as! Int?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "_version")
//    }
//  }
//}
//
//public struct DeleteCTMemoryInput: GraphQLMapConvertible {
//  public var graphQLMap: GraphQLMap
//
//  public init(id: GraphQLID, version: Int? = nil) {
//    graphQLMap = ["id": id, "_version": version]
//  }
//
//  public var id: GraphQLID {
//    get {
//      return graphQLMap["id"] as! GraphQLID
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "id")
//    }
//  }
//
//  public var version: Int? {
//    get {
//      return graphQLMap["_version"] as! Int?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "_version")
//    }
//  }
//}
//
//public struct ModelCTMemoryFilterInput: GraphQLMapConvertible {
//  public var graphQLMap: GraphQLMap
//
//  public init(id: ModelIDInput? = nil, name: ModelStringInput? = nil, and: [ModelCTMemoryFilterInput?]? = nil, or: [ModelCTMemoryFilterInput?]? = nil, not: ModelCTMemoryFilterInput? = nil) {
//    graphQLMap = ["id": id, "name": name, "and": and, "or": or, "not": not]
//  }
//
//  public var id: ModelIDInput? {
//    get {
//      return graphQLMap["id"] as! ModelIDInput?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "id")
//    }
//  }
//
//  public var name: ModelStringInput? {
//    get {
//      return graphQLMap["name"] as! ModelStringInput?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "name")
//    }
//  }
//
//  public var and: [ModelCTMemoryFilterInput?]? {
//    get {
//      return graphQLMap["and"] as! [ModelCTMemoryFilterInput?]?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "and")
//    }
//  }
//
//  public var or: [ModelCTMemoryFilterInput?]? {
//    get {
//      return graphQLMap["or"] as! [ModelCTMemoryFilterInput?]?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "or")
//    }
//  }
//
//  public var not: ModelCTMemoryFilterInput? {
//    get {
//      return graphQLMap["not"] as! ModelCTMemoryFilterInput?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "not")
//    }
//  }
//}
//
//public struct ModelIDInput: GraphQLMapConvertible {
//  public var graphQLMap: GraphQLMap
//
//  public init(ne: GraphQLID? = nil, eq: GraphQLID? = nil, le: GraphQLID? = nil, lt: GraphQLID? = nil, ge: GraphQLID? = nil, gt: GraphQLID? = nil, contains: GraphQLID? = nil, notContains: GraphQLID? = nil, between: [GraphQLID?]? = nil, beginsWith: GraphQLID? = nil, attributeExists: Bool? = nil, attributeType: ModelAttributeTypes? = nil, size: ModelSizeInput? = nil) {
//    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "contains": contains, "notContains": notContains, "between": between, "beginsWith": beginsWith, "attributeExists": attributeExists, "attributeType": attributeType, "size": size]
//  }
//
//  public var ne: GraphQLID? {
//    get {
//      return graphQLMap["ne"] as! GraphQLID?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "ne")
//    }
//  }
//
//  public var eq: GraphQLID? {
//    get {
//      return graphQLMap["eq"] as! GraphQLID?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "eq")
//    }
//  }
//
//  public var le: GraphQLID? {
//    get {
//      return graphQLMap["le"] as! GraphQLID?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "le")
//    }
//  }
//
//  public var lt: GraphQLID? {
//    get {
//      return graphQLMap["lt"] as! GraphQLID?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "lt")
//    }
//  }
//
//  public var ge: GraphQLID? {
//    get {
//      return graphQLMap["ge"] as! GraphQLID?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "ge")
//    }
//  }
//
//  public var gt: GraphQLID? {
//    get {
//      return graphQLMap["gt"] as! GraphQLID?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "gt")
//    }
//  }
//
//  public var contains: GraphQLID? {
//    get {
//      return graphQLMap["contains"] as! GraphQLID?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "contains")
//    }
//  }
//
//  public var notContains: GraphQLID? {
//    get {
//      return graphQLMap["notContains"] as! GraphQLID?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "notContains")
//    }
//  }
//
//  public var between: [GraphQLID?]? {
//    get {
//      return graphQLMap["between"] as! [GraphQLID?]?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "between")
//    }
//  }
//
//  public var beginsWith: GraphQLID? {
//    get {
//      return graphQLMap["beginsWith"] as! GraphQLID?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "beginsWith")
//    }
//  }
//
//  public var attributeExists: Bool? {
//    get {
//      return graphQLMap["attributeExists"] as! Bool?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "attributeExists")
//    }
//  }
//
//  public var attributeType: ModelAttributeTypes? {
//    get {
//      return graphQLMap["attributeType"] as! ModelAttributeTypes?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "attributeType")
//    }
//  }
//
//  public var size: ModelSizeInput? {
//    get {
//      return graphQLMap["size"] as! ModelSizeInput?
//    }
//    set {
//      graphQLMap.updateValue(newValue, forKey: "size")
//    }
//  }
//}
//
//public final class CreateCtMemoryMutation: GraphQLMutation {
//  public static let operationString =
//    "mutation CreateCtMemory($input: CreateCTMemoryInput!, $condition: ModelCTMemoryConditionInput) {\n  createCTMemory(input: $input, condition: $condition) {\n    __typename\n    id\n    name\n    _version\n    _deleted\n    _lastChangedAt\n    createdAt\n    updatedAt\n  }\n}"
//
//  public var input: CreateCTMemoryInput
//  public var condition: ModelCTMemoryConditionInput?
//
//  public init(input: CreateCTMemoryInput, condition: ModelCTMemoryConditionInput? = nil) {
//    self.input = input
//    self.condition = condition
//  }
//
//  public var variables: GraphQLMap? {
//    return ["input": input, "condition": condition]
//  }
//
//  public struct Data: GraphQLSelectionSet {
//    public static let possibleTypes = ["Mutation"]
//
//    public static let selections: [GraphQLSelection] = [
//      GraphQLField("createCTMemory", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(CreateCtMemory.selections)),
//    ]
//
//    public var snapshot: Snapshot
//
//    public init(snapshot: Snapshot) {
//      self.snapshot = snapshot
//    }
//
//    public init(createCtMemory: CreateCtMemory? = nil) {
//      self.init(snapshot: ["__typename": "Mutation", "createCTMemory": createCtMemory.flatMap { $0.snapshot }])
//    }
//
//    public var createCtMemory: CreateCtMemory? {
//      get {
//        return (snapshot["createCTMemory"] as? Snapshot).flatMap { CreateCtMemory(snapshot: $0) }
//      }
//      set {
//        snapshot.updateValue(newValue?.snapshot, forKey: "createCTMemory")
//      }
//    }
//
//    public struct CreateCtMemory: GraphQLSelectionSet {
//      public static let possibleTypes = ["CTMemory"]
//
//      public static let selections: [GraphQLSelection] = [
//        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
//        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
//        GraphQLField("name", type: .scalar(String.self)),
//        GraphQLField("_version", type: .nonNull(.scalar(Int.self))),
//        GraphQLField("_deleted", type: .scalar(Bool.self)),
//        GraphQLField("_lastChangedAt", type: .nonNull(.scalar(Int.self))),
//        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
//        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
//      ]
//
//      public var snapshot: Snapshot
//
//      public init(snapshot: Snapshot) {
//        self.snapshot = snapshot
//      }
//
//      public init(id: GraphQLID, name: String? = nil, version: Int, deleted: Bool? = nil, lastChangedAt: Int, createdAt: String, updatedAt: String) {
//        self.init(snapshot: ["__typename": "CTMemory", "id": id, "name": name, "_version": version, "_deleted": deleted, "_lastChangedAt": lastChangedAt, "createdAt": createdAt, "updatedAt": updatedAt])
//      }
//
//      public var __typename: String {
//        get {
//          return snapshot["__typename"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "__typename")
//        }
//      }
//
//      public var id: GraphQLID {
//        get {
//          return snapshot["id"]! as! GraphQLID
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "id")
//        }
//      }
//
//      public var name: String? {
//        get {
//          return snapshot["name"] as? String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "name")
//        }
//      }
//
//      public var version: Int {
//        get {
//          return snapshot["_version"]! as! Int
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_version")
//        }
//      }
//
//      public var deleted: Bool? {
//        get {
//          return snapshot["_deleted"] as? Bool
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_deleted")
//        }
//      }
//
//      public var lastChangedAt: Int {
//        get {
//          return snapshot["_lastChangedAt"]! as! Int
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_lastChangedAt")
//        }
//      }
//
//      public var createdAt: String {
//        get {
//          return snapshot["createdAt"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "createdAt")
//        }
//      }
//
//      public var updatedAt: String {
//        get {
//          return snapshot["updatedAt"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "updatedAt")
//        }
//      }
//    }
//  }
//}
//
//public final class UpdateCtMemoryMutation: GraphQLMutation {
//  public static let operationString =
//    "mutation UpdateCtMemory($input: UpdateCTMemoryInput!, $condition: ModelCTMemoryConditionInput) {\n  updateCTMemory(input: $input, condition: $condition) {\n    __typename\n    id\n    name\n    _version\n    _deleted\n    _lastChangedAt\n    createdAt\n    updatedAt\n  }\n}"
//
//  public var input: UpdateCTMemoryInput
//  public var condition: ModelCTMemoryConditionInput?
//
//  public init(input: UpdateCTMemoryInput, condition: ModelCTMemoryConditionInput? = nil) {
//    self.input = input
//    self.condition = condition
//  }
//
//  public var variables: GraphQLMap? {
//    return ["input": input, "condition": condition]
//  }
//
//  public struct Data: GraphQLSelectionSet {
//    public static let possibleTypes = ["Mutation"]
//
//    public static let selections: [GraphQLSelection] = [
//      GraphQLField("updateCTMemory", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(UpdateCtMemory.selections)),
//    ]
//
//    public var snapshot: Snapshot
//
//    public init(snapshot: Snapshot) {
//      self.snapshot = snapshot
//    }
//
//    public init(updateCtMemory: UpdateCtMemory? = nil) {
//      self.init(snapshot: ["__typename": "Mutation", "updateCTMemory": updateCtMemory.flatMap { $0.snapshot }])
//    }
//
//    public var updateCtMemory: UpdateCtMemory? {
//      get {
//        return (snapshot["updateCTMemory"] as? Snapshot).flatMap { UpdateCtMemory(snapshot: $0) }
//      }
//      set {
//        snapshot.updateValue(newValue?.snapshot, forKey: "updateCTMemory")
//      }
//    }
//
//    public struct UpdateCtMemory: GraphQLSelectionSet {
//      public static let possibleTypes = ["CTMemory"]
//
//      public static let selections: [GraphQLSelection] = [
//        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
//        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
//        GraphQLField("name", type: .scalar(String.self)),
//        GraphQLField("_version", type: .nonNull(.scalar(Int.self))),
//        GraphQLField("_deleted", type: .scalar(Bool.self)),
//        GraphQLField("_lastChangedAt", type: .nonNull(.scalar(Int.self))),
//        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
//        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
//      ]
//
//      public var snapshot: Snapshot
//
//      public init(snapshot: Snapshot) {
//        self.snapshot = snapshot
//      }
//
//      public init(id: GraphQLID, name: String? = nil, version: Int, deleted: Bool? = nil, lastChangedAt: Int, createdAt: String, updatedAt: String) {
//        self.init(snapshot: ["__typename": "CTMemory", "id": id, "name": name, "_version": version, "_deleted": deleted, "_lastChangedAt": lastChangedAt, "createdAt": createdAt, "updatedAt": updatedAt])
//      }
//
//      public var __typename: String {
//        get {
//          return snapshot["__typename"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "__typename")
//        }
//      }
//
//      public var id: GraphQLID {
//        get {
//          return snapshot["id"]! as! GraphQLID
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "id")
//        }
//      }
//
//      public var name: String? {
//        get {
//          return snapshot["name"] as? String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "name")
//        }
//      }
//
//      public var version: Int {
//        get {
//          return snapshot["_version"]! as! Int
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_version")
//        }
//      }
//
//      public var deleted: Bool? {
//        get {
//          return snapshot["_deleted"] as? Bool
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_deleted")
//        }
//      }
//
//      public var lastChangedAt: Int {
//        get {
//          return snapshot["_lastChangedAt"]! as! Int
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_lastChangedAt")
//        }
//      }
//
//      public var createdAt: String {
//        get {
//          return snapshot["createdAt"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "createdAt")
//        }
//      }
//
//      public var updatedAt: String {
//        get {
//          return snapshot["updatedAt"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "updatedAt")
//        }
//      }
//    }
//  }
//}
//
//public final class DeleteCtMemoryMutation: GraphQLMutation {
//  public static let operationString =
//    "mutation DeleteCtMemory($input: DeleteCTMemoryInput!, $condition: ModelCTMemoryConditionInput) {\n  deleteCTMemory(input: $input, condition: $condition) {\n    __typename\n    id\n    name\n    _version\n    _deleted\n    _lastChangedAt\n    createdAt\n    updatedAt\n  }\n}"
//
//  public var input: DeleteCTMemoryInput
//  public var condition: ModelCTMemoryConditionInput?
//
//  public init(input: DeleteCTMemoryInput, condition: ModelCTMemoryConditionInput? = nil) {
//    self.input = input
//    self.condition = condition
//  }
//
//  public var variables: GraphQLMap? {
//    return ["input": input, "condition": condition]
//  }
//
//  public struct Data: GraphQLSelectionSet {
//    public static let possibleTypes = ["Mutation"]
//
//    public static let selections: [GraphQLSelection] = [
//      GraphQLField("deleteCTMemory", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(DeleteCtMemory.selections)),
//    ]
//
//    public var snapshot: Snapshot
//
//    public init(snapshot: Snapshot) {
//      self.snapshot = snapshot
//    }
//
//    public init(deleteCtMemory: DeleteCtMemory? = nil) {
//      self.init(snapshot: ["__typename": "Mutation", "deleteCTMemory": deleteCtMemory.flatMap { $0.snapshot }])
//    }
//
//    public var deleteCtMemory: DeleteCtMemory? {
//      get {
//        return (snapshot["deleteCTMemory"] as? Snapshot).flatMap { DeleteCtMemory(snapshot: $0) }
//      }
//      set {
//        snapshot.updateValue(newValue?.snapshot, forKey: "deleteCTMemory")
//      }
//    }
//
//    public struct DeleteCtMemory: GraphQLSelectionSet {
//      public static let possibleTypes = ["CTMemory"]
//
//      public static let selections: [GraphQLSelection] = [
//        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
//        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
//        GraphQLField("name", type: .scalar(String.self)),
//        GraphQLField("_version", type: .nonNull(.scalar(Int.self))),
//        GraphQLField("_deleted", type: .scalar(Bool.self)),
//        GraphQLField("_lastChangedAt", type: .nonNull(.scalar(Int.self))),
//        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
//        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
//      ]
//
//      public var snapshot: Snapshot
//
//      public init(snapshot: Snapshot) {
//        self.snapshot = snapshot
//      }
//
//      public init(id: GraphQLID, name: String? = nil, version: Int, deleted: Bool? = nil, lastChangedAt: Int, createdAt: String, updatedAt: String) {
//        self.init(snapshot: ["__typename": "CTMemory", "id": id, "name": name, "_version": version, "_deleted": deleted, "_lastChangedAt": lastChangedAt, "createdAt": createdAt, "updatedAt": updatedAt])
//      }
//
//      public var __typename: String {
//        get {
//          return snapshot["__typename"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "__typename")
//        }
//      }
//
//      public var id: GraphQLID {
//        get {
//          return snapshot["id"]! as! GraphQLID
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "id")
//        }
//      }
//
//      public var name: String? {
//        get {
//          return snapshot["name"] as? String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "name")
//        }
//      }
//
//      public var version: Int {
//        get {
//          return snapshot["_version"]! as! Int
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_version")
//        }
//      }
//
//      public var deleted: Bool? {
//        get {
//          return snapshot["_deleted"] as? Bool
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_deleted")
//        }
//      }
//
//      public var lastChangedAt: Int {
//        get {
//          return snapshot["_lastChangedAt"]! as! Int
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_lastChangedAt")
//        }
//      }
//
//      public var createdAt: String {
//        get {
//          return snapshot["createdAt"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "createdAt")
//        }
//      }
//
//      public var updatedAt: String {
//        get {
//          return snapshot["updatedAt"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "updatedAt")
//        }
//      }
//    }
//  }
//}
//
//public final class GetCtMemoryQuery: GraphQLQuery {
//  public static let operationString =
//    "query GetCtMemory($id: ID!) {\n  getCTMemory(id: $id) {\n    __typename\n    id\n    name\n    _version\n    _deleted\n    _lastChangedAt\n    createdAt\n    updatedAt\n  }\n}"
//
//  public var id: GraphQLID
//
//  public init(id: GraphQLID) {
//    self.id = id
//  }
//
//  public var variables: GraphQLMap? {
//    return ["id": id]
//  }
//
//  public struct Data: GraphQLSelectionSet {
//    public static let possibleTypes = ["Query"]
//
//    public static let selections: [GraphQLSelection] = [
//      GraphQLField("getCTMemory", arguments: ["id": GraphQLVariable("id")], type: .object(GetCtMemory.selections)),
//    ]
//
//    public var snapshot: Snapshot
//
//    public init(snapshot: Snapshot) {
//      self.snapshot = snapshot
//    }
//
//    public init(getCtMemory: GetCtMemory? = nil) {
//      self.init(snapshot: ["__typename": "Query", "getCTMemory": getCtMemory.flatMap { $0.snapshot }])
//    }
//
//    public var getCtMemory: GetCtMemory? {
//      get {
//        return (snapshot["getCTMemory"] as? Snapshot).flatMap { GetCtMemory(snapshot: $0) }
//      }
//      set {
//        snapshot.updateValue(newValue?.snapshot, forKey: "getCTMemory")
//      }
//    }
//
//    public struct GetCtMemory: GraphQLSelectionSet {
//      public static let possibleTypes = ["CTMemory"]
//
//      public static let selections: [GraphQLSelection] = [
//        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
//        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
//        GraphQLField("name", type: .scalar(String.self)),
//        GraphQLField("_version", type: .nonNull(.scalar(Int.self))),
//        GraphQLField("_deleted", type: .scalar(Bool.self)),
//        GraphQLField("_lastChangedAt", type: .nonNull(.scalar(Int.self))),
//        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
//        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
//      ]
//
//      public var snapshot: Snapshot
//
//      public init(snapshot: Snapshot) {
//        self.snapshot = snapshot
//      }
//
//      public init(id: GraphQLID, name: String? = nil, version: Int, deleted: Bool? = nil, lastChangedAt: Int, createdAt: String, updatedAt: String) {
//        self.init(snapshot: ["__typename": "CTMemory", "id": id, "name": name, "_version": version, "_deleted": deleted, "_lastChangedAt": lastChangedAt, "createdAt": createdAt, "updatedAt": updatedAt])
//      }
//
//      public var __typename: String {
//        get {
//          return snapshot["__typename"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "__typename")
//        }
//      }
//
//      public var id: GraphQLID {
//        get {
//          return snapshot["id"]! as! GraphQLID
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "id")
//        }
//      }
//
//      public var name: String? {
//        get {
//          return snapshot["name"] as? String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "name")
//        }
//      }
//
//      public var version: Int {
//        get {
//          return snapshot["_version"]! as! Int
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_version")
//        }
//      }
//
//      public var deleted: Bool? {
//        get {
//          return snapshot["_deleted"] as? Bool
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_deleted")
//        }
//      }
//
//      public var lastChangedAt: Int {
//        get {
//          return snapshot["_lastChangedAt"]! as! Int
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_lastChangedAt")
//        }
//      }
//
//      public var createdAt: String {
//        get {
//          return snapshot["createdAt"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "createdAt")
//        }
//      }
//
//      public var updatedAt: String {
//        get {
//          return snapshot["updatedAt"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "updatedAt")
//        }
//      }
//    }
//  }
//}
//
//public final class ListCtMemorysQuery: GraphQLQuery {
//  public static let operationString =
//    "query ListCtMemorys($filter: ModelCTMemoryFilterInput, $limit: Int, $nextToken: String) {\n  listCTMemorys(filter: $filter, limit: $limit, nextToken: $nextToken) {\n    __typename\n    items {\n      __typename\n      id\n      name\n      _version\n      _deleted\n      _lastChangedAt\n      createdAt\n      updatedAt\n    }\n    nextToken\n    startedAt\n  }\n}"
//
//  public var filter: ModelCTMemoryFilterInput?
//  public var limit: Int?
//  public var nextToken: String?
//
//  public init(filter: ModelCTMemoryFilterInput? = nil, limit: Int? = nil, nextToken: String? = nil) {
//    self.filter = filter
//    self.limit = limit
//    self.nextToken = nextToken
//  }
//
//  public var variables: GraphQLMap? {
//    return ["filter": filter, "limit": limit, "nextToken": nextToken]
//  }
//
//  public struct Data: GraphQLSelectionSet {
//    public static let possibleTypes = ["Query"]
//
//    public static let selections: [GraphQLSelection] = [
//      GraphQLField("listCTMemorys", arguments: ["filter": GraphQLVariable("filter"), "limit": GraphQLVariable("limit"), "nextToken": GraphQLVariable("nextToken")], type: .object(ListCtMemory.selections)),
//    ]
//
//    public var snapshot: Snapshot
//
//    public init(snapshot: Snapshot) {
//      self.snapshot = snapshot
//    }
//
//    public init(listCtMemorys: ListCtMemory? = nil) {
//      self.init(snapshot: ["__typename": "Query", "listCTMemorys": listCtMemorys.flatMap { $0.snapshot }])
//    }
//
//    public var listCtMemorys: ListCtMemory? {
//      get {
//        return (snapshot["listCTMemorys"] as? Snapshot).flatMap { ListCtMemory(snapshot: $0) }
//      }
//      set {
//        snapshot.updateValue(newValue?.snapshot, forKey: "listCTMemorys")
//      }
//    }
//
//    public struct ListCtMemory: GraphQLSelectionSet {
//      public static let possibleTypes = ["ModelCTMemoryConnection"]
//
//      public static let selections: [GraphQLSelection] = [
//        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
//        GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
//        GraphQLField("nextToken", type: .scalar(String.self)),
//        GraphQLField("startedAt", type: .scalar(Int.self)),
//      ]
//
//      public var snapshot: Snapshot
//
//      public init(snapshot: Snapshot) {
//        self.snapshot = snapshot
//      }
//
//      public init(items: [Item?], nextToken: String? = nil, startedAt: Int? = nil) {
//        self.init(snapshot: ["__typename": "ModelCTMemoryConnection", "items": items.map { $0.flatMap { $0.snapshot } }, "nextToken": nextToken, "startedAt": startedAt])
//      }
//
//      public var __typename: String {
//        get {
//          return snapshot["__typename"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "__typename")
//        }
//      }
//
//      public var items: [Item?] {
//        get {
//          return (snapshot["items"] as! [Snapshot?]).map { $0.flatMap { Item(snapshot: $0) } }
//        }
//        set {
//          snapshot.updateValue(newValue.map { $0.flatMap { $0.snapshot } }, forKey: "items")
//        }
//      }
//
//      public var nextToken: String? {
//        get {
//          return snapshot["nextToken"] as? String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "nextToken")
//        }
//      }
//
//      public var startedAt: Int? {
//        get {
//          return snapshot["startedAt"] as? Int
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "startedAt")
//        }
//      }
//
//      public struct Item: GraphQLSelectionSet {
//        public static let possibleTypes = ["CTMemory"]
//
//        public static let selections: [GraphQLSelection] = [
//          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
//          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
//          GraphQLField("name", type: .scalar(String.self)),
//          GraphQLField("_version", type: .nonNull(.scalar(Int.self))),
//          GraphQLField("_deleted", type: .scalar(Bool.self)),
//          GraphQLField("_lastChangedAt", type: .nonNull(.scalar(Int.self))),
//          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
//          GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
//        ]
//
//        public var snapshot: Snapshot
//
//        public init(snapshot: Snapshot) {
//          self.snapshot = snapshot
//        }
//
//        public init(id: GraphQLID, name: String? = nil, version: Int, deleted: Bool? = nil, lastChangedAt: Int, createdAt: String, updatedAt: String) {
//          self.init(snapshot: ["__typename": "CTMemory", "id": id, "name": name, "_version": version, "_deleted": deleted, "_lastChangedAt": lastChangedAt, "createdAt": createdAt, "updatedAt": updatedAt])
//        }
//
//        public var __typename: String {
//          get {
//            return snapshot["__typename"]! as! String
//          }
//          set {
//            snapshot.updateValue(newValue, forKey: "__typename")
//          }
//        }
//
//        public var id: GraphQLID {
//          get {
//            return snapshot["id"]! as! GraphQLID
//          }
//          set {
//            snapshot.updateValue(newValue, forKey: "id")
//          }
//        }
//
//        public var name: String? {
//          get {
//            return snapshot["name"] as? String
//          }
//          set {
//            snapshot.updateValue(newValue, forKey: "name")
//          }
//        }
//
//        public var version: Int {
//          get {
//            return snapshot["_version"]! as! Int
//          }
//          set {
//            snapshot.updateValue(newValue, forKey: "_version")
//          }
//        }
//
//        public var deleted: Bool? {
//          get {
//            return snapshot["_deleted"] as? Bool
//          }
//          set {
//            snapshot.updateValue(newValue, forKey: "_deleted")
//          }
//        }
//
//        public var lastChangedAt: Int {
//          get {
//            return snapshot["_lastChangedAt"]! as! Int
//          }
//          set {
//            snapshot.updateValue(newValue, forKey: "_lastChangedAt")
//          }
//        }
//
//        public var createdAt: String {
//          get {
//            return snapshot["createdAt"]! as! String
//          }
//          set {
//            snapshot.updateValue(newValue, forKey: "createdAt")
//          }
//        }
//
//        public var updatedAt: String {
//          get {
//            return snapshot["updatedAt"]! as! String
//          }
//          set {
//            snapshot.updateValue(newValue, forKey: "updatedAt")
//          }
//        }
//      }
//    }
//  }
//}
//
//public final class SyncCtMemoriesQuery: GraphQLQuery {
//  public static let operationString =
//    "query SyncCtMemories($filter: ModelCTMemoryFilterInput, $limit: Int, $nextToken: String, $lastSync: AWSTimestamp) {\n  syncCTMemories(filter: $filter, limit: $limit, nextToken: $nextToken, lastSync: $lastSync) {\n    __typename\n    items {\n      __typename\n      id\n      name\n      _version\n      _deleted\n      _lastChangedAt\n      createdAt\n      updatedAt\n    }\n    nextToken\n    startedAt\n  }\n}"
//
//  public var filter: ModelCTMemoryFilterInput?
//  public var limit: Int?
//  public var nextToken: String?
//  public var lastSync: Int?
//
//  public init(filter: ModelCTMemoryFilterInput? = nil, limit: Int? = nil, nextToken: String? = nil, lastSync: Int? = nil) {
//    self.filter = filter
//    self.limit = limit
//    self.nextToken = nextToken
//    self.lastSync = lastSync
//  }
//
//  public var variables: GraphQLMap? {
//    return ["filter": filter, "limit": limit, "nextToken": nextToken, "lastSync": lastSync]
//  }
//
//  public struct Data: GraphQLSelectionSet {
//    public static let possibleTypes = ["Query"]
//
//    public static let selections: [GraphQLSelection] = [
//      GraphQLField("syncCTMemories", arguments: ["filter": GraphQLVariable("filter"), "limit": GraphQLVariable("limit"), "nextToken": GraphQLVariable("nextToken"), "lastSync": GraphQLVariable("lastSync")], type: .object(SyncCtMemory.selections)),
//    ]
//
//    public var snapshot: Snapshot
//
//    public init(snapshot: Snapshot) {
//      self.snapshot = snapshot
//    }
//
//    public init(syncCtMemories: SyncCtMemory? = nil) {
//      self.init(snapshot: ["__typename": "Query", "syncCTMemories": syncCtMemories.flatMap { $0.snapshot }])
//    }
//
//    public var syncCtMemories: SyncCtMemory? {
//      get {
//        return (snapshot["syncCTMemories"] as? Snapshot).flatMap { SyncCtMemory(snapshot: $0) }
//      }
//      set {
//        snapshot.updateValue(newValue?.snapshot, forKey: "syncCTMemories")
//      }
//    }
//
//    public struct SyncCtMemory: GraphQLSelectionSet {
//      public static let possibleTypes = ["ModelCTMemoryConnection"]
//
//      public static let selections: [GraphQLSelection] = [
//        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
//        GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
//        GraphQLField("nextToken", type: .scalar(String.self)),
//        GraphQLField("startedAt", type: .scalar(Int.self)),
//      ]
//
//      public var snapshot: Snapshot
//
//      public init(snapshot: Snapshot) {
//        self.snapshot = snapshot
//      }
//
//      public init(items: [Item?], nextToken: String? = nil, startedAt: Int? = nil) {
//        self.init(snapshot: ["__typename": "ModelCTMemoryConnection", "items": items.map { $0.flatMap { $0.snapshot } }, "nextToken": nextToken, "startedAt": startedAt])
//      }
//
//      public var __typename: String {
//        get {
//          return snapshot["__typename"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "__typename")
//        }
//      }
//
//      public var items: [Item?] {
//        get {
//          return (snapshot["items"] as! [Snapshot?]).map { $0.flatMap { Item(snapshot: $0) } }
//        }
//        set {
//          snapshot.updateValue(newValue.map { $0.flatMap { $0.snapshot } }, forKey: "items")
//        }
//      }
//
//      public var nextToken: String? {
//        get {
//          return snapshot["nextToken"] as? String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "nextToken")
//        }
//      }
//
//      public var startedAt: Int? {
//        get {
//          return snapshot["startedAt"] as? Int
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "startedAt")
//        }
//      }
//
//      public struct Item: GraphQLSelectionSet {
//        public static let possibleTypes = ["CTMemory"]
//
//        public static let selections: [GraphQLSelection] = [
//          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
//          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
//          GraphQLField("name", type: .scalar(String.self)),
//          GraphQLField("_version", type: .nonNull(.scalar(Int.self))),
//          GraphQLField("_deleted", type: .scalar(Bool.self)),
//          GraphQLField("_lastChangedAt", type: .nonNull(.scalar(Int.self))),
//          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
//          GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
//        ]
//
//        public var snapshot: Snapshot
//
//        public init(snapshot: Snapshot) {
//          self.snapshot = snapshot
//        }
//
//        public init(id: GraphQLID, name: String? = nil, version: Int, deleted: Bool? = nil, lastChangedAt: Int, createdAt: String, updatedAt: String) {
//          self.init(snapshot: ["__typename": "CTMemory", "id": id, "name": name, "_version": version, "_deleted": deleted, "_lastChangedAt": lastChangedAt, "createdAt": createdAt, "updatedAt": updatedAt])
//        }
//
//        public var __typename: String {
//          get {
//            return snapshot["__typename"]! as! String
//          }
//          set {
//            snapshot.updateValue(newValue, forKey: "__typename")
//          }
//        }
//
//        public var id: GraphQLID {
//          get {
//            return snapshot["id"]! as! GraphQLID
//          }
//          set {
//            snapshot.updateValue(newValue, forKey: "id")
//          }
//        }
//
//        public var name: String? {
//          get {
//            return snapshot["name"] as? String
//          }
//          set {
//            snapshot.updateValue(newValue, forKey: "name")
//          }
//        }
//
//        public var version: Int {
//          get {
//            return snapshot["_version"]! as! Int
//          }
//          set {
//            snapshot.updateValue(newValue, forKey: "_version")
//          }
//        }
//
//        public var deleted: Bool? {
//          get {
//            return snapshot["_deleted"] as? Bool
//          }
//          set {
//            snapshot.updateValue(newValue, forKey: "_deleted")
//          }
//        }
//
//        public var lastChangedAt: Int {
//          get {
//            return snapshot["_lastChangedAt"]! as! Int
//          }
//          set {
//            snapshot.updateValue(newValue, forKey: "_lastChangedAt")
//          }
//        }
//
//        public var createdAt: String {
//          get {
//            return snapshot["createdAt"]! as! String
//          }
//          set {
//            snapshot.updateValue(newValue, forKey: "createdAt")
//          }
//        }
//
//        public var updatedAt: String {
//          get {
//            return snapshot["updatedAt"]! as! String
//          }
//          set {
//            snapshot.updateValue(newValue, forKey: "updatedAt")
//          }
//        }
//      }
//    }
//  }
//}
//
//public final class OnCreateCtMemorySubscription: GraphQLSubscription {
//  public static let operationString =
//    "subscription OnCreateCtMemory {\n  onCreateCTMemory {\n    __typename\n    id\n    name\n    _version\n    _deleted\n    _lastChangedAt\n    createdAt\n    updatedAt\n  }\n}"
//
//  public init() {
//  }
//
//  public struct Data: GraphQLSelectionSet {
//    public static let possibleTypes = ["Subscription"]
//
//    public static let selections: [GraphQLSelection] = [
//      GraphQLField("onCreateCTMemory", type: .object(OnCreateCtMemory.selections)),
//    ]
//
//    public var snapshot: Snapshot
//
//    public init(snapshot: Snapshot) {
//      self.snapshot = snapshot
//    }
//
//    public init(onCreateCtMemory: OnCreateCtMemory? = nil) {
//      self.init(snapshot: ["__typename": "Subscription", "onCreateCTMemory": onCreateCtMemory.flatMap { $0.snapshot }])
//    }
//
//    public var onCreateCtMemory: OnCreateCtMemory? {
//      get {
//        return (snapshot["onCreateCTMemory"] as? Snapshot).flatMap { OnCreateCtMemory(snapshot: $0) }
//      }
//      set {
//        snapshot.updateValue(newValue?.snapshot, forKey: "onCreateCTMemory")
//      }
//    }
//
//    public struct OnCreateCtMemory: GraphQLSelectionSet {
//      public static let possibleTypes = ["CTMemory"]
//
//      public static let selections: [GraphQLSelection] = [
//        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
//        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
//        GraphQLField("name", type: .scalar(String.self)),
//        GraphQLField("_version", type: .nonNull(.scalar(Int.self))),
//        GraphQLField("_deleted", type: .scalar(Bool.self)),
//        GraphQLField("_lastChangedAt", type: .nonNull(.scalar(Int.self))),
//        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
//        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
//      ]
//
//      public var snapshot: Snapshot
//
//      public init(snapshot: Snapshot) {
//        self.snapshot = snapshot
//      }
//
//      public init(id: GraphQLID, name: String? = nil, version: Int, deleted: Bool? = nil, lastChangedAt: Int, createdAt: String, updatedAt: String) {
//        self.init(snapshot: ["__typename": "CTMemory", "id": id, "name": name, "_version": version, "_deleted": deleted, "_lastChangedAt": lastChangedAt, "createdAt": createdAt, "updatedAt": updatedAt])
//      }
//
//      public var __typename: String {
//        get {
//          return snapshot["__typename"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "__typename")
//        }
//      }
//
//      public var id: GraphQLID {
//        get {
//          return snapshot["id"]! as! GraphQLID
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "id")
//        }
//      }
//
//      public var name: String? {
//        get {
//          return snapshot["name"] as? String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "name")
//        }
//      }
//
//      public var version: Int {
//        get {
//          return snapshot["_version"]! as! Int
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_version")
//        }
//      }
//
//      public var deleted: Bool? {
//        get {
//          return snapshot["_deleted"] as? Bool
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_deleted")
//        }
//      }
//
//      public var lastChangedAt: Int {
//        get {
//          return snapshot["_lastChangedAt"]! as! Int
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_lastChangedAt")
//        }
//      }
//
//      public var createdAt: String {
//        get {
//          return snapshot["createdAt"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "createdAt")
//        }
//      }
//
//      public var updatedAt: String {
//        get {
//          return snapshot["updatedAt"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "updatedAt")
//        }
//      }
//    }
//  }
//}
//
//public final class OnUpdateCtMemorySubscription: GraphQLSubscription {
//  public static let operationString =
//    "subscription OnUpdateCtMemory {\n  onUpdateCTMemory {\n    __typename\n    id\n    name\n    _version\n    _deleted\n    _lastChangedAt\n    createdAt\n    updatedAt\n  }\n}"
//
//  public init() {
//  }
//
//  public struct Data: GraphQLSelectionSet {
//    public static let possibleTypes = ["Subscription"]
//
//    public static let selections: [GraphQLSelection] = [
//      GraphQLField("onUpdateCTMemory", type: .object(OnUpdateCtMemory.selections)),
//    ]
//
//    public var snapshot: Snapshot
//
//    public init(snapshot: Snapshot) {
//      self.snapshot = snapshot
//    }
//
//    public init(onUpdateCtMemory: OnUpdateCtMemory? = nil) {
//      self.init(snapshot: ["__typename": "Subscription", "onUpdateCTMemory": onUpdateCtMemory.flatMap { $0.snapshot }])
//    }
//
//    public var onUpdateCtMemory: OnUpdateCtMemory? {
//      get {
//        return (snapshot["onUpdateCTMemory"] as? Snapshot).flatMap { OnUpdateCtMemory(snapshot: $0) }
//      }
//      set {
//        snapshot.updateValue(newValue?.snapshot, forKey: "onUpdateCTMemory")
//      }
//    }
//
//    public struct OnUpdateCtMemory: GraphQLSelectionSet {
//      public static let possibleTypes = ["CTMemory"]
//
//      public static let selections: [GraphQLSelection] = [
//        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
//        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
//        GraphQLField("name", type: .scalar(String.self)),
//        GraphQLField("_version", type: .nonNull(.scalar(Int.self))),
//        GraphQLField("_deleted", type: .scalar(Bool.self)),
//        GraphQLField("_lastChangedAt", type: .nonNull(.scalar(Int.self))),
//        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
//        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
//      ]
//
//      public var snapshot: Snapshot
//
//      public init(snapshot: Snapshot) {
//        self.snapshot = snapshot
//      }
//
//      public init(id: GraphQLID, name: String? = nil, version: Int, deleted: Bool? = nil, lastChangedAt: Int, createdAt: String, updatedAt: String) {
//        self.init(snapshot: ["__typename": "CTMemory", "id": id, "name": name, "_version": version, "_deleted": deleted, "_lastChangedAt": lastChangedAt, "createdAt": createdAt, "updatedAt": updatedAt])
//      }
//
//      public var __typename: String {
//        get {
//          return snapshot["__typename"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "__typename")
//        }
//      }
//
//      public var id: GraphQLID {
//        get {
//          return snapshot["id"]! as! GraphQLID
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "id")
//        }
//      }
//
//      public var name: String? {
//        get {
//          return snapshot["name"] as? String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "name")
//        }
//      }
//
//      public var version: Int {
//        get {
//          return snapshot["_version"]! as! Int
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_version")
//        }
//      }
//
//      public var deleted: Bool? {
//        get {
//          return snapshot["_deleted"] as? Bool
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_deleted")
//        }
//      }
//
//      public var lastChangedAt: Int {
//        get {
//          return snapshot["_lastChangedAt"]! as! Int
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_lastChangedAt")
//        }
//      }
//
//      public var createdAt: String {
//        get {
//          return snapshot["createdAt"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "createdAt")
//        }
//      }
//
//      public var updatedAt: String {
//        get {
//          return snapshot["updatedAt"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "updatedAt")
//        }
//      }
//    }
//  }
//}
//
//public final class OnDeleteCtMemorySubscription: GraphQLSubscription {
//  public static let operationString =
//    "subscription OnDeleteCtMemory {\n  onDeleteCTMemory {\n    __typename\n    id\n    name\n    _version\n    _deleted\n    _lastChangedAt\n    createdAt\n    updatedAt\n  }\n}"
//
//  public init() {
//  }
//
//  public struct Data: GraphQLSelectionSet {
//    public static let possibleTypes = ["Subscription"]
//
//    public static let selections: [GraphQLSelection] = [
//      GraphQLField("onDeleteCTMemory", type: .object(OnDeleteCtMemory.selections)),
//    ]
//
//    public var snapshot: Snapshot
//
//    public init(snapshot: Snapshot) {
//      self.snapshot = snapshot
//    }
//
//    public init(onDeleteCtMemory: OnDeleteCtMemory? = nil) {
//      self.init(snapshot: ["__typename": "Subscription", "onDeleteCTMemory": onDeleteCtMemory.flatMap { $0.snapshot }])
//    }
//
//    public var onDeleteCtMemory: OnDeleteCtMemory? {
//      get {
//        return (snapshot["onDeleteCTMemory"] as? Snapshot).flatMap { OnDeleteCtMemory(snapshot: $0) }
//      }
//      set {
//        snapshot.updateValue(newValue?.snapshot, forKey: "onDeleteCTMemory")
//      }
//    }
//
//    public struct OnDeleteCtMemory: GraphQLSelectionSet {
//      public static let possibleTypes = ["CTMemory"]
//
//      public static let selections: [GraphQLSelection] = [
//        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
//        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
//        GraphQLField("name", type: .scalar(String.self)),
//        GraphQLField("_version", type: .nonNull(.scalar(Int.self))),
//        GraphQLField("_deleted", type: .scalar(Bool.self)),
//        GraphQLField("_lastChangedAt", type: .nonNull(.scalar(Int.self))),
//        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
//        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
//      ]
//
//      public var snapshot: Snapshot
//
//      public init(snapshot: Snapshot) {
//        self.snapshot = snapshot
//      }
//
//      public init(id: GraphQLID, name: String? = nil, version: Int, deleted: Bool? = nil, lastChangedAt: Int, createdAt: String, updatedAt: String) {
//        self.init(snapshot: ["__typename": "CTMemory", "id": id, "name": name, "_version": version, "_deleted": deleted, "_lastChangedAt": lastChangedAt, "createdAt": createdAt, "updatedAt": updatedAt])
//      }
//
//      public var __typename: String {
//        get {
//          return snapshot["__typename"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "__typename")
//        }
//      }
//
//      public var id: GraphQLID {
//        get {
//          return snapshot["id"]! as! GraphQLID
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "id")
//        }
//      }
//
//      public var name: String? {
//        get {
//          return snapshot["name"] as? String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "name")
//        }
//      }
//
//      public var version: Int {
//        get {
//          return snapshot["_version"]! as! Int
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_version")
//        }
//      }
//
//      public var deleted: Bool? {
//        get {
//          return snapshot["_deleted"] as? Bool
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_deleted")
//        }
//      }
//
//      public var lastChangedAt: Int {
//        get {
//          return snapshot["_lastChangedAt"]! as! Int
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "_lastChangedAt")
//        }
//      }
//
//      public var createdAt: String {
//        get {
//          return snapshot["createdAt"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "createdAt")
//        }
//      }
//
//      public var updatedAt: String {
//        get {
//          return snapshot["updatedAt"]! as! String
//        }
//        set {
//          snapshot.updateValue(newValue, forKey: "updatedAt")
//        }
//      }
//    }
//  }
//}
