import Foundation

protocol MapsViewModelProtocol: AnyObject {
    static var shared: MapsViewModel { get }
    init()
    var mapsViewModel: Post? { get set}
}

final class MapsViewModel: MapsViewModelProtocol {
    static var shared = MapsViewModel()
    init() {}
    var mapsViewModel: Post?
}
