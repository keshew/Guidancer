import Foundation

protocol MapsViewModelProtocol: AnyObject {
    static var shared: MapsViewModel { get }
    init()
//    var MapsViewModel: NetworkModel? { get set}
}

final class MapsViewModel: MapsViewModelProtocol {
    static var shared = MapsViewModel()
    init() {}
//    var MapsViewModel: NetworkModel?
}
