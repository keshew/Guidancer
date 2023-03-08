import Foundation

protocol CreatePostViewModelProtocol: AnyObject {
    static var shared: CreatePostViewModel { get }
    init()
//    var CreatePostViewModel: NetworkModel? { get set}
}

final class CreatePostViewModel: CreatePostViewModelProtocol {
    static var shared = CreatePostViewModel()
    init() {}
//    var CreatePostViewModel: NetworkModel?
}
