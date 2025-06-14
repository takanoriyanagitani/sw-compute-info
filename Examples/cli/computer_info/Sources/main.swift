import struct ComputerInfo.ComputerInfomation
import struct Foundation.Data
import class Foundation.JSONEncoder

@main
struct computerInfo {
  static func main() {
    let info: ComputerInfomation = .current()
    let rdata: Result<Data, _> = info.toJson(encoder: JSONEncoder())
    let rstr: Result<String, _> = rdata.flatMap {
      let dat: Data = $0
      let ostr: String? = String(data: dat, encoding: .utf8)
      let s: String = ostr ?? "INVALID PROCESS INFO"
      return .success(s)
    }
    do {
      let s: String = try rstr.get()
      print("\( s )")
    } catch {
      print("\( error )")
    }
  }
}
