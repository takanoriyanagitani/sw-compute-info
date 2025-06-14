import struct ComputerInfo.ComputerInfomation
import enum ComputerInfo.ThermalState
import typealias Foundation.TimeInterval
import struct Hummingbird.Application
import protocol Hummingbird.ResponseEncodable
import class Hummingbird.Router

public struct CompInfo: ResponseEncodable {
  public let processorCount: Int
  public let activeProcessorCount: Int
  public let physicalMemory: UInt64
  public let systemUptime: TimeInterval
  public let thermalState: String
  public let isLowPowerModeEnabled: Bool

  public static func current() -> Self {
    let ci: ComputerInfomation = .current()
    return Self(
      processorCount: ci.processorCount,
      activeProcessorCount: ci.activeProcessorCount,
      physicalMemory: ci.physicalMemory,
      systemUptime: ci.systemUptime,
      thermalState: ci.thermalState.toString(),
      isLowPowerModeEnabled: ci.isLowPowerModeEnabled,
    )
  }
}

@main
struct cinfo2web {
  static func main() async throws {
    let router: Router = Router()

    router.get("/") { _request, _ -> CompInfo in
      return CompInfo.current()
    }

    let app: Application = Application(
      router: router,
      configuration: .init(
        address: .hostname("127.0.0.1", port: 61180),
      ),
    )

    try await app.runService()
  }
}
