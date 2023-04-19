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
        guard let url = URL(string: "http://31.31.203.226:4444/upload") else {
            print("Invalid URL")
            return
        }
        
        let image = UIImage(named: "Image")
        guard let imageData = image?.pngData() else {
            print("Failed to convert image to PNG data")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2Mzk2YmFlZDJmMjMzNjg0YzIyOGY0OTYiLCJpYXQiOjE2Nzg0NzQ0MjksImV4cCI6MTY4MTA2NjQyOX0.ywVOpubpCEaJR1IHULn3JCl2Uc2pC-4IFu_dj-h3NUU", forHTTPHeaderField: "Authorization")
        let body = NSMutableData()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"example.png\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body as Data
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            print("Response status code: \(response.statusCode)")
            print("Response body: \(String(data: data, encoding: .utf8) ?? "")")
        }
        task.resume()
    }
    
    func createPost() {
        //to network manager
        guard let url = URL(string: "http://31.31.203.226:4444/posts") else { return }
        //        let image = UIImage(named: "Image")?.pngData()
        let parameters = ["title": view?.guideNameTextField.text, "text": view?.guideDescriptionTextField.text]
        var request = URLRequest(url: url)
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2Mzk2YmFlZDJmMjMzNjg0YzIyOGY0OTYiLCJpYXQiOjE2NzgzNjcwODQsImV4cCI6MTY4MDk1OTA4NH0.nOtNy2q_plfH6CwojMBY4uInrFhGQBi2zewqM6ZWXyE"
        request.httpMethod = "POST"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data else { return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
        view?.showAlert()
    }
}

extension CreatePostPresenter: CreatePostPresenterProtocol {
}
