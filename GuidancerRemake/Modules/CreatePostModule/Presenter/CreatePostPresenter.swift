import UIKit

protocol CreatePostPresenterProtocol: AnyObject {
    init(view: CreatePostViewProtocol, network: NetworkManagerProtocol, router: CreatePostRouterProtocol?)
    var viewModel: CreatePostViewModel? { get set }
    func createPost()
    func uploadFile()
}

class CreatePostPresenter {
    weak var view: CreatePostViewProtocol?
    let network: NetworkManagerProtocol?
    var viewModel: CreatePostViewModel?
    var router: CreatePostRouterProtocol?

    required init(view: CreatePostViewProtocol, network: NetworkManagerProtocol, router: CreatePostRouterProtocol?) {
        self.view = view
        self.network = network
        self.router = router
    }
    
    
    
    func uploadFile() {
        let photo = UIImage(named: "Image")?.pngData()?.base64EncodedString()
        let bii = UUID().uuidString
        guard let url = URL(string: "http://31.31.203.226:4444/upload") else { return }
        let parameters = "image=\(photo)".data(using: .utf8)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(bii)", forHTTPHeaderField: "form-data")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2Mzk2YmFlZDJmMjMzNjg0YzIyOGY0OTYiLCJpYXQiOjE2Nzg0NzQ0MjksImV4cCI6MTY4MTA2NjQyOX0.ywVOpubpCEaJR1IHULn3JCl2Uc2pC-4IFu_dj-h3NUU", forHTTPHeaderField: "Authorization")
        guard let httpBody = parameters else { return }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            guard let data else { return }
            let responseStrin = String(data: data, encoding: .utf8)
            print(responseStrin)
        }.resume()
    }
    
    func createPost() {
        //to network manager
        guard let url = URL(string: "http://31.31.203.226:4444/posts") else { return }
        let parameters = ["title": view?.guideNameTextField.text, "text": view?.guideDescriptionTextField.text]
        var request = URLRequest(url: url)
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2Mzk2YmFlZDJmMjMzNjg0YzIyOGY0OTYiLCJpYXQiOjE2NzgzNjcwODQsImV4cCI6MTY4MDk1OTA4NH0.nOtNy2q_plfH6CwojMBY4uInrFhGQBi2zewqM6ZWXyE"
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data else { return }
                do {
                    let jspn = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(jspn)
                } catch {
//                    print(error)
                }
            }
        }.resume()
        view?.showAlert()
    }
}

extension CreatePostPresenter: CreatePostPresenterProtocol {
}
