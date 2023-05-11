import UIKit

protocol CreatePostPresenterProtocol: AnyObject {
    init(view: CreatePostViewProtocol, network: NetworkManagerProtocol, router: CreatePostRouterProtocol?)
    var viewModel: CreatePostViewModel? { get set }
    func createPost()
    func uploadImage(image: UIImage?)
    func audio(urls: URL)
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
    
    var dictionaryOfImages: [String:Any] = [:]
    var dictionaryOfMP3: [String:Any] = [:]
    
    func audio(urls: URL) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let dateString = dateFormatter.string(from: Date())
        
        guard let url = URL(string: "http://31.31.203.226:4444/upload") else {
            print("Invalid URL")
            return
        }
    
        guard let imageData = try? Data(contentsOf: urls) else {
            print("Failed to convert mp3 to data")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2Mzk2YmFlZDJmMjMzNjg0YzIyOGY0OTYiLCJpYXQiOjE2Nzg0NzQ0MjksImV4cCI6MTY4MTA2NjQyOX0.ywVOpubpCEaJR1IHULn3JCl2Uc2pC-4IFu_dj-h3NUU", forHTTPHeaderField: "Authorization")
        let body = NSMutableData()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(dateString).mp3\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/mp3\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body as Data
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            let string = String(data: data, encoding: .utf8)
            self.dictionaryOfMP3 = string?.convertToDictionary() ?? [:]
            print("Response status code: \(response.statusCode)")
            print("Response body: \(String(data: data, encoding: .utf8) ?? "")")
        }
        task.resume()
    }
    
    func uploadImage(image: UIImage?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let dateString = dateFormatter.string(from: Date())
        
        guard let url = URL(string: "http://31.31.203.226:4444/upload") else {
            print("Invalid URL")
            return
        }
    
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
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(dateString).png\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body as Data
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            let string = String(data: data, encoding: .utf8)
            self.dictionaryOfImages = string?.convertToDictionary() ?? [:]
            print("Response status code: \(response.statusCode)")
            print("Response body: \(String(data: data, encoding: .utf8) ?? "")")
        }
        task.resume()
    }
    
    func createPost() {
        //to network manager
        guard let url = URL(string: "http://31.31.203.226:4444/posts") else { return }
        let parameters: [String: String?] = [
                          "location": view?.adressLabel.text,
                          "title": view?.guideNameTextField.text,
                          "text": view?.guideDescriptionTextField.text,
                          "imageUrl": "http://31.31.203.226:4444\(self.dictionaryOfImages.first?.value ?? "")",
                          "audioUrl": "http://31.31.203.226:4444\(self.dictionaryOfMP3.first?.value ?? "")"
        ]
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
        view?.hidePreviousPost()
       
    }
}

extension CreatePostPresenter: CreatePostPresenterProtocol {
}

extension String {
    func convertToDictionary() -> [String: Any]? {
        if let data = data(using: .utf8) {
            return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        }
        return nil
    }
}
