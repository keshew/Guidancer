import Foundation

protocol PostViewModelProtocol: AnyObject {
    static var shared: PostViewModel { get set }
    init()
    var postViewModel: Post? { get set}
}

final class PostViewModel: PostViewModelProtocol {
    static var shared = PostViewModel()
    init() {}
    var postViewModel: Post?
}
