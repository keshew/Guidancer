import UIKit

protocol PlacesViewProtocol: AnyObject {
}

class PlacesViewController: UIViewController {
    
    var presenter: PlacesPresenterProtocol?
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.separatorStyle = .none
        view.register(PlacesCell.self, forCellReuseIdentifier: PlacesCell.identifire)
        return view
    }()
    
    private let nameOfPlaceLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Aleksandrovsk"
        name.font = .medium21
        name.textAlignment = .center
        return name
    }()
    
    private let grayLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupConstaints()
        
    }
}

extension PlacesViewController: PlacesViewProtocol {
}

private extension PlacesViewController {
    func setupView() {
        navigationItem.title = "Notifications"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(grayLineView)
        view.addSubview(nameOfPlaceLabel)
    }
    
    func setupConstaints() {
        NSLayoutConstraint.activate([
            grayLineView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            grayLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            view.trailingAnchor.constraint(equalTo: grayLineView.trailingAnchor, constant: 50),
            grayLineView.heightAnchor.constraint(equalToConstant: 1),
            
            nameOfPlaceLabel.topAnchor.constraint(equalTo: grayLineView.bottomAnchor, constant: 20),
            nameOfPlaceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: nameOfPlaceLabel.trailingAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: nameOfPlaceLabel.bottomAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
    }
}

extension PlacesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlacesCell.identifire , for: indexPath) as! PlacesCell
        
        return cell
    }
    
}

extension PlacesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
}
