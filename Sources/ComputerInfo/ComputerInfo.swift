import struct Foundation.Data
import class Foundation.JSONEncoder
import class Foundation.ProcessInfo
import typealias Foundation.TimeInterval

public enum ThermalState: Codable {
  case unknown
  case normal
  case fair
  case serious
  case critical

  public func toString() -> String {
    switch self {
    case .unknown: return "unknown"
    case .normal: return "normal"
    case .fair: return "fair"
    case .serious: return "serious"
    case .critical: return "critical"
    }
  }

  public static func fromProcessInfo(_ pinfo: ProcessInfo) -> Self {
    switch pinfo.thermalState {
    case .nominal: return Self.normal
    case .fair: return Self.fair
    case .serious: return Self.serious
    case .critical: return Self.critical
    @unknown default: return Self.unknown
    }
  }
}

public struct ComputerInfomation: Codable {
  public let processorCount: Int
  public let activeProcessorCount: Int
  public let physicalMemory: UInt64
  public let systemUptime: TimeInterval
  public let thermalState: ThermalState
  public let isLowPowerModeEnabled: Bool

  public func toJson(encoder: JSONEncoder) -> Result<Data, Error> {
    return Result(catching: {
      try encoder.encode(self)
    })
  }

  public static func rawInfo() -> ProcessInfo { ProcessInfo.processInfo }

  public static func current() -> Self {
    let raw: ProcessInfo = Self.rawInfo()
    return Self(
      processorCount: raw.processorCount,
      activeProcessorCount: raw.activeProcessorCount,
      physicalMemory: raw.physicalMemory,
      systemUptime: raw.systemUptime,
      thermalState: ThermalState.fromProcessInfo(raw),
      isLowPowerModeEnabled: raw.isLowPowerModeEnabled,
    )
  }
}
