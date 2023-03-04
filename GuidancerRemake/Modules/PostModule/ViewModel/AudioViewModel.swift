import Foundation

protocol AudioViewModelProtocol: AnyObject {
    static var shared: AudioViewModel { get }
    init()
    var postModel: Post? { get set}
}

final class AudioViewModel: AudioViewModelProtocol {
    static var shared = AudioViewModel()
    init() {}
    var postModel: Post?
}
