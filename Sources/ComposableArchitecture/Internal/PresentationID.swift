@_spi(Reflection) import CasePaths

@available(iOS 13.0, *)
extension PresentationState {
  var id: PresentationID? {
    self.wrappedValue.map(PresentationID.init(base:))
  }
}

@available(iOS 13.0, *)
struct PresentationID: Hashable, Identifiable, Sendable {
  private let identifier: AnyHashableSendable?
  private let tag: UInt32?
  private let type: Any.Type

  init<Base>(base: Base) {
    self.tag = EnumMetadata(Base.self)?.tag(of: base)
    if let id = _identifiableID(base) ?? EnumMetadata.project(base).flatMap(_identifiableID) {
      self.identifier = AnyHashableSendable(id)
    } else {
      self.identifier = nil
    }
    self.type = Base.self
  }

  var id: Self { self }

  static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.identifier == rhs.identifier
      && lhs.tag == rhs.tag
      && lhs.type == rhs.type
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.identifier)
    hasher.combine(self.tag)
    hasher.combine(ObjectIdentifier(self.type))
  }
}
